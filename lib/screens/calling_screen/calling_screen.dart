import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/config.dart';
import '../../core/models/call/call.dart';
import '../../core/models/call_history/call_history.dart';
import '../../core/models/enum/enum.dart';
import '../../core/utilities/utilities.dart';
import '../../providers/call_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../widgets/commons/cache_image.dart';
import 'controls.dart';
import 'peer_connection.dart';

// https://gist.github.com/yetithefoot/7592580

@RoutePage()
class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({super.key, required this.call});
  final Call call;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  Call get call => widget.call;
  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? '';

  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;

  bool _isAlreadyEndedCall = false;

  bool isStopStream = false;

  final position = ValueNotifier<Offset>(const Offset(20, 100));

  final _peerConnection = PeerConnection();

  final _localRenderer = RTCVideoRenderer();

  final _remoteRenderer = RTCVideoRenderer();

  StreamSubscription? _callStreamSubscription;

  StreamSubscription? _callStatus;

  CallStatus callStatus = CallStatus.calling;

  late CallHistory callHistory;

  String get roomId => call.channelId;

  final duration = ValueNotifier(Duration.zero);

  String get uidListen => call.hasDialled ? call.receiverId : call.callerId;

  late final callerCollection = FirebaseFirestore.instance
      .collection(DbCollection.users)
      .doc(call.callerId)
      .collection(DbCollection.callHistories)
      .doc(call.timeepoch.toString());

  late final receiverCollection = FirebaseFirestore.instance
      .collection(DbCollection.users)
      .doc(call.receiverId)
      .collection(DbCollection.callHistories)
      .doc(call.timeepoch.toString());

  bool get inCall => callStatus == CallStatus.inCall;

  // play local ringtone
  final _player = AudioPlayer();
  Timer? _timer;

  ProviderSubscription? _callStream;

  @override
  void initState() {
    initRenderers();
    // init call history model;
    callHistory = CallHistory(
      callerId: call.callerId,
      callerName: call.callerName,
      callerPic: call.callerPic,
      receiverId: call.receiverId,
      receiverName: call.receiverName,
      receiverPic: call.receiverPic,
      channelId: call.channelId,
      hasDialled: call.hasDialled,
      callTime: DateTime.now(),
      type: DbKeys.outgoing,
    );

    _callStatus = ref
        .read(firestoreProvider)
        .collection(DbCollection.users)
        .doc(uidListen)
        .collection(DbCollection.callHistories)
        .doc(call.timeepoch.toString())
        .snapshots()
        .listen(listenStatusCall);
    _checkPermissions().whenComplete(() {
      initRenderers();
      openUserMedia().whenComplete(() {
        joinRoom();
        setHistoryCall();
      });
    });

    super.initState();
  }

  void initRenderers() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.bluetooth.request();
    if (status.isPermanentlyDenied) {
      Logger.log('Bluetooth Permission disabled');
    }

    status = await Permission.bluetoothConnect.request();
    if (status.isPermanentlyDenied) {
      Logger.log('Bluetooth Connect Permission disabled');
    }

    status = await Permission.camera.request();
    if (status.isPermanentlyDenied) {
      Logger.log('Camera Permission disabled');
    }

    status = await Permission.microphone.request();

    if (status.isPermanentlyDenied) {
      Logger.log('Microphone Permission disabled');
    }
  }

  _playCallingTone() async {
    _player.play(AssetSource('sounds/ringtone.mp3'));
  }

  void setHistoryCall() {
    if (call.hasDialled) {
      _playCallingTone();
      callerCollection.set(
        callHistory.copyWith(hasDialled: true, type: DbKeys.outgoing).toJson(),
        SetOptions(merge: true),
      );
      receiverCollection.set(
        callHistory.copyWith(hasDialled: false, type: DbKeys.incoming).toJson(),
        SetOptions(merge: true),
      );
    } else {
      receiverCollection.set(
        {
          DbKeys.started: DateTime.now(),
          DbKeys.callStatus: CallStatus.inCall.value,
          DbKeys.type: DbKeys.incoming,
        },
        SetOptions(merge: true),
      );
      callerCollection.set(
        {
          DbKeys.started: DateTime.now(),
          DbKeys.callStatus: CallStatus.inCall.value,
          DbKeys.type: DbKeys.outgoing,
        },
        SetOptions(merge: true),
      );
    }
  }

  void listenStatusCall(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.exists && snapshot.data() != null) {
      callStatus = CallStatus.fromString(snapshot.data()![DbKeys.callStatus]);
      setState(() {});
      stopCallingSound();
      switch (callStatus) {
        case CallStatus.inCall:
          _startTimerNow();
          break;
        case CallStatus.ended:
        case CallStatus.rejected:
        case CallStatus.missed:
          _timer?.cancel();
          _stopStream();
          break;

        default:
      }
    }
  }

  void stopCallingSound() {
    if (_player.state == PlayerState.playing) {
      _player.stop();
    }
  }

  Future<void> openUserMedia() async {
    _peerConnection
      ..onAddRemoteStream = ((stream) {
        _remoteRenderer.srcObject = stream;
        setState(() {});
      })
      ..onAddLocalStream = ((stream) {
        _localRenderer.srcObject = stream;
        setState(() {});
      })
      ..openUserMedia();
  }

  void joinRoom() async {
    // If you are the caller, create a room
    if (widget.call.hasDialled) {
      _peerConnection.createRoom(roomId);
    } else {
      // If you are the receiver, join the room
      _peerConnection.joinRoom(roomId);
    }
  }

  _startTimerNow() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      duration.value = Duration(seconds: duration.value.inSeconds + 1);
    });
  }

  @override
  void deactivate() {
    _stopStream();
    _callStream?.close();
    _callStatus?.cancel();
    _callStreamSubscription?.cancel();
    super.deactivate();
  }

  _stopStream() {
    if (isStopStream) return;
    isStopStream = true;
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _peerConnection
      ..leaveRoom(roomId)
      ..close();
  }

  void dragUpdate(DragUpdateDetails details) {
    final appBarHeight = kTextTabBarHeight + context.screenPadding.top;
    final minWidth = context.screenWidth - 120.w;
    final minHeight = context.screenHeight - 150.h - appBarHeight.h;
    position.value = Offset(
      max(min(position.value.dx - details.delta.dx, minWidth), 0),
      max(min(position.value.dy - details.delta.dy, minHeight), 0),
    );
  }

  String get status {
    switch (callStatus) {
      case CallStatus.calling:
        return call.hasDialled
            ? '${context.lang.calling} ...'
            : '${context.lang.connecting} ...';
      case CallStatus.ringing:
        return '${context.lang.calling} ...';
      case CallStatus.rejected:
        return context.lang.callReject;
      case CallStatus.ended:
        return '${context.lang.callEnd} ${AppUtils.formatDuration(duration.value)}';
      case CallStatus.missed:
        return context.lang.callEnd;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            CacheImage(
              image: call.hasDialled ? call.receiverPic : call.callerPic,
              dimension: MediaQuery.of(context).size,
            ),
            Container(
              color: Colors.black.withOpacity(.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    call.hasDialled ? call.receiverName : call.callerName,
                    style: context.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    status,
                    style: context.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            if (inCall) ...[
              RTCVideoView(
                _remoteRenderer,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              ),
              AnimatedBuilder(
                animation: position,
                builder: (_, Widget? child) {
                  return AnimatedPositioned(
                    right: position.value.dx,
                    bottom: position.value.dy,
                    duration: Duration.zero,
                    child: child!,
                  );
                },
                child: GestureDetector(
                  onPanUpdate: dragUpdate,
                  child: Container(
                    height: 150.h,
                    width: 120.w,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RTCVideoView(
                      _localRenderer,
                      mirror: isFrontCameraSelected,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    ),
                  ),
                ),
              ),
            ],
            //  else
            //   Column(
            //     children: [
            //       SizedBox(height: context.screenHeight * .1),
            //       CacheImage(
            //         image: call.hasDialled ? call.receiverPic : call.callerPic,
            //         dimension: context.screenWidth * .5,
            //         radius: 100,
            //       ),
            //       const SizedBox(height: 20),
            //     ],
            //   ),
            SafeArea(
              top: false,
              child: Controls(
                callStatus: callStatus,
                isAudioOn: isAudioOn,
                isVideoOn: isVideoOn,
                isFrontCameraSelected: isFrontCameraSelected,
                onEndCall: () {
                  _isAlreadyEndedCall = callStatus == CallStatus.ended ||
                      callStatus == CallStatus.rejected ||
                      callStatus == CallStatus.missed;
                  _leaveCall();
                },
                onToggleAudio: _toggleAudio,
                onSwitchCamera: _switchCamera,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _leaveCall() async {
    if (_isAlreadyEndedCall) {
      Navigator.pop(context);
      return;
    }
    _stopStream();
    ref.read(callUtils).endCall(widget.call);
    DateTime now = DateTime.now();
    await callerCollection.set(
      {
        DbKeys.callStatus: CallStatus.ended.value,
        DbKeys.ended: now,
      },
      SetOptions(merge: true),
    );
    await receiverCollection.set(
      {
        DbKeys.callStatus: CallStatus.ended.value,
        DbKeys.ended: now,
      },
      SetOptions(merge: true),
    );
  }

  _toggleAudio() {
    _peerConnection.toggleAudio();
    setState(() {
      isAudioOn = !isAudioOn;
    });
  }

  // _toggleVideo() {
  //   _peerConnection.toggleVideo();
  //   setState(() {
  //     isVideoOn = !isVideoOn;
  //   });
  // }

  _switchCamera() {
    _peerConnection.switchCamera();
    setState(() {
      isFrontCameraSelected = !isFrontCameraSelected;
    });
  }
}
