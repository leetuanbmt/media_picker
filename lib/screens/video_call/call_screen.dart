import 'dart:math';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../core/config.dart';
import '../../providers/socket_provider.dart';
import '../../widgets/commons/measure_size.dart';
import 'webrtc_wrapper/webrtc_wrapper.dart';

// https://gist.github.com/yetithefoot/7592580

@RoutePage()
class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({
    super.key,
    required this.callerId,
    required this.calleeId,
    this.offer,
  });
  final String callerId, calleeId;
  final RTCSessionDescription? offer;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  WebRtcWrapper? webRtcWrapper;

  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;

  final position = ValueNotifier<Offset>(const Offset(20, 20));

  @override
  void initState() {
    WidgetsBinding.instance.endOfFrame.then((value) {
      webRtcWrapper = WebRtcWrapper(
        callerId: widget.callerId,
        calleeId: widget.calleeId,
        offer: widget.offer,
        transport: ref.read(socketProvider.notifier).transport,
      );
      joinMeeting();
    });

    super.initState();
  }

  void joinMeeting() async {
    webRtcWrapper
      ?..initialize()
      ..on(StringPayload.userJoin, context, (ev, context) {
        Logger.log("Joint new user");
        setState(() {});
      });
  }

  @override
  void deactivate() {
    ref.read(socketProvider).endCall();
    webRtcWrapper?.close();

    super.deactivate();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("P2P Call App"),
      ),
      body: MeasureSize(
        onChange: print,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    if (webRtcWrapper?.remoteRender != null)
                      RTCVideoView(
                        webRtcWrapper!.remoteRender,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      ),
                    if (webRtcWrapper?.localRender != null)
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
                              webRtcWrapper!.localRender,
                              mirror: isFrontCameraSelected,
                              objectFit: RTCVideoViewObjectFit
                                  .RTCVideoViewObjectFitCover,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(isAudioOn ? Icons.mic : Icons.mic_off),
                      onPressed: _toggleAudio,
                    ),
                    IconButton(
                      icon: const Icon(Icons.call_end),
                      iconSize: 30,
                      onPressed: _leaveCall,
                    ),
                    IconButton(
                      icon: const Icon(Icons.cameraswitch),
                      onPressed: _switchCamera,
                    ),
                    IconButton(
                      icon: Icon(
                        isVideoOn ? Icons.videocam : Icons.videocam_off,
                      ),
                      onPressed: _toggleVideo,
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

  _leaveCall() {
    webRtcWrapper?.close();
    Navigator.of(context).pop();
  }

  _toggleAudio() {
    setState(() {
      isAudioOn = webRtcWrapper?.toggleAudio() ?? false;
    });
  }

  _toggleVideo() {
    setState(() {
      isVideoOn = webRtcWrapper?.toggleVideo() ?? false;
    });
  }

  _switchCamera() {
    setState(() {
      isFrontCameraSelected = webRtcWrapper?.switchCamera() ?? false;
    });
  }
}
