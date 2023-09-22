import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../core/config.dart';
import '../../providers/socket_provider.dart';
import 'webrtc_wrapper/webrtc_wrapper.dart';

// https://gist.github.com/yetithefoot/7592580

@RoutePage()
class CallScreen extends ConsumerStatefulWidget {
  const CallScreen(this.callerId, this.calleeId, this.offer, {super.key});
  final String callerId, calleeId;
  final RTCSessionDescription? offer;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  late final socket = ref.watch(socketProvider).socket;

  WebRtcWrapper? webRtcWrapper;

  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;

  @override
  void initState() {
    WidgetsBinding.instance.endOfFrame.then((value) {
      webRtcWrapper = WebRtcWrapper(
        socket: socket!,
        callerId: widget.callerId,
        calleeId: widget.calleeId,
        offer: widget.offer,
      );
      joinMeeting();
    });

    super.initState();
  }

  void joinMeeting() async {
    webRtcWrapper
      ?..initialize()
      ..on("user-joined", context, (ev, context) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    webRtcWrapper?.close();
    super.dispose();
  }

  List<Connection> get connections => webRtcWrapper?.connections ?? [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("P2P Call App"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  if (connections.isNotEmpty)
                    RTCVideoView(
                      connections.first.remoteRender,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    ),
                  if (webRtcWrapper?.localRender != null)
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: SizedBox(
                        height: 150,
                        width: 120,
                        child: RTCVideoView(
                          webRtcWrapper!.localRender,
                          mirror: isFrontCameraSelected,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
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
                    onPressed: _toggleMic,
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
                    icon: Icon(isVideoOn ? Icons.videocam : Icons.videocam_off),
                    onPressed: _toggleCamera,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _leaveCall() {
    webRtcWrapper?.close();
    Navigator.of(context).pop();
  }

  _toggleMic() {}

  _toggleCamera() {}

  _switchCamera() {}
}
