import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../core/config.dart';
import '../../core/models/call/call.dart';
import '../../core/models/call_history/call_history.dart';
import '../../core/models/enum/enum.dart';
import '../../core/utilities/utilities.dart';
import '../../providers/call_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../widgets/commons/cache_image.dart';
import '../pickup_screen.dart';
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
  String get currentUserId =>
      ref.read(firebaseAuthProvider).currentUser?.uid ?? '';

  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;
  bool _isAlreadyEndedCall = false;
  bool isStopStream = false;
  final position = ValueNotifier<Offset>(const Offset(20, 20));
  final _peerConnection = PeerConnection();
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();

  StreamSubscription? _callStreamSubscription;

  StreamSubscription? _callStatus;

  CallStatus callStatus = CallStatus.calling;

  late CallHistory callHistory;

  final duration = ValueNotifier(Duration.zero);

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

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
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
      isCallMissed: false,
      callTime: DateTime.now(),
      callStatus: CallStatus.calling,
      type: 'outgoing',
    );

    _callStatus = ref
        .read(firestoreProvider)
        .collection(DbCollection.users)
        .doc(call.hasDialled ? call.callerId : call.receiverId)
        .collection(DbCollection.callHistories)
        .doc(call.timeepoch.toString())
        .snapshots()
        .listen(listenStatusCall);

    setHistoryCall();
    openUserMedia();
    super.initState();
  }

  _playCallingTone() async {
    _player.play(AssetSource('sounds/ringtone.mp3'));
  }

  void setHistoryCall() {
    if (widget.call.hasDialled) {
      _playCallingTone();
      callerCollection.set(callHistory.toJson(), SetOptions(merge: true));
      receiverCollection.set(
        callHistory
            .copyWith(
              type: DbKey.incoming,
              callStatus: CallStatus.missed,
            )
            .toJson(),
        SetOptions(merge: true),
      );
    } else {
      receiverCollection.set(
        {
          DbKey.started: DateTime.now(),
          DbKey.callStatus: CallStatus.inCall.value,
        },
        SetOptions(merge: true),
      );
      callerCollection.set(
        {
          DbKey.started: DateTime.now(),
          DbKey.callStatus: CallStatus.inCall.value,
        },
        SetOptions(merge: true),
      );
    }
  }

  void listenStatusCall(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.exists && snapshot.data() != null) {
      callStatus = CallStatus.fromString(snapshot.data()![DbKey.callStatus]);
      setState(() {});
      stopCallingSound();
      switch (callStatus) {
        case CallStatus.inCall:
          _startTimerNow();
          break;
        case CallStatus.ended:
          _timer?.cancel();
          break;
        case CallStatus.rejected:
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

  void openUserMedia() async {
    await _peerConnection.openUserMedia(_localRenderer, _remoteRenderer);
    _peerConnection.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });
    checkCallStatus();
    setState(() {});
  }

  void checkCallStatus() async {
    // check if caller or receiver
    if (widget.call.hasDialled) {
      _peerConnection.createRoom(widget.call.channelId);
    } else {
      Logger.log("Joining room ${widget.call.channelId}");
      _peerConnection.joinRoom(widget.call.channelId);
    }
    endCallHandler();
  }

  void endCallHandler() {
    final currentUser = ref.read(firebaseAuthProvider).currentUser?.uid;
    ref.watch(callStream(currentUser!)).whenData((snapshot) {
      if (snapshot == null || !snapshot.exists) {
        Navigator.pop(context);
        _stopStream();
      }
    });
  }

  _startTimerNow() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      duration.value = Duration(seconds: duration.value.inSeconds + 1);
    });
  }

  @override
  void dispose() {
    _callStatus?.cancel();
    _callStreamSubscription?.cancel();
    super.dispose();
  }

  _stopStream() {
    if (isStopStream) return;
    isStopStream = true;
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _peerConnection.dispose();
    _peerConnection.hangUp(_localRenderer);
  }

  void dragUpdate(DragUpdateDetails details) {
    final appBarHeight = kTextTabBarHeight + MediaQuery.of(context).padding.top;
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
        return call.hasDialled ? 'Connecting...' : 'Calling...';
      case CallStatus.ringing:
      case CallStatus.missed:
        return 'Ringing...';
      case CallStatus.rejected:
        return 'Call Rejected';
      case CallStatus.ended:
        return 'Call Ended ${AppUtils.formatDuration(duration.value)}';
      default:
        return '';
    }
  }

  @override
  void deactivate() {
    _stopStream();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              if (inCall)
                Expanded(
                  child: Stack(
                    children: [
                      RTCVideoView(
                        _remoteRenderer,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: RTCVideoView(
                              _localRenderer,
                              mirror: isFrontCameraSelected,
                              objectFit: RTCVideoViewObjectFit
                                  .RTCVideoViewObjectFitCover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: context.screenHeight * .1),
                      CacheImage(
                        image:
                            call.hasDialled ? call.callerPic : call.receiverPic,
                        dimension: context.screenWidth * .5,
                        radius: 100,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        call.hasDialled ? call.callerName : call.receiverName,
                        style: context.headlineMedium?.copyWith(
                          color: context.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        status,
                        style: context.bodyMedium?.copyWith(
                          color: context.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (inCall)
                      DialButton(
                        icon: isAudioOn
                            ? Icons.volume_mute_rounded
                            : Icons.volume_off_sharp,
                        iconColor: Colors.black,
                        color: Colors.black.withOpacity(.2),
                        onTap: _toggleAudio,
                      ),
                    DialButton(
                      icon: callStatus == CallStatus.ended ||
                              callStatus == CallStatus.rejected
                          ? Icons.close
                          : Icons.call,
                      iconColor: Colors.white,
                      color: callStatus == CallStatus.ended ||
                              callStatus == CallStatus.rejected
                          ? Colors.black.withOpacity(.2)
                          : Colors.redAccent,
                      onTap: () {
                        _isAlreadyEndedCall = callStatus == CallStatus.ended ||
                            callStatus == CallStatus.rejected;
                        _leaveCall();
                      },
                    ),
                    if (inCall)
                      DialButton(
                        icon: Icons.switch_camera,
                        color: Colors.black.withOpacity(.2),
                        iconColor: Colors.black,
                        onTap: _switchCamera,
                      ),
                  ],
                ),
              ),
            ],
          ),
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
    ref.read(callProvider).endCall(widget.call);
    DateTime now = DateTime.now();
    await callerCollection.set(
      {
        DbKey.callStatus: CallStatus.ended.value,
        DbKey.ended: now,
      },
      SetOptions(merge: true),
    );
    await receiverCollection.set(
      {
        DbKey.callStatus: CallStatus.ended.value,
        DbKey.ended: now,
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
