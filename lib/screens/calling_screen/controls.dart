import '../../core/config.dart';
import '../../core/models/enum/enum.dart';
import 'widgets/dial_button.dart';

class Controls extends StatelessWidget {
  const Controls({
    super.key,
    required this.callStatus,
    required this.isAudioOn,
    required this.isVideoOn,
    required this.isFrontCameraSelected,
    this.onSwitchCamera,
    this.onToggleAudio,
    this.onToggleVideo,
    this.onEndCall,
  });
  final CallStatus callStatus;
  final bool isAudioOn, isVideoOn, isFrontCameraSelected;
  final VoidCallback? onSwitchCamera, onToggleAudio, onToggleVideo, onEndCall;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (callStatus == CallStatus.inCall)
              DialButton(
                icon: isAudioOn
                    ? Icons.volume_mute_rounded
                    : Icons.volume_off_sharp,
                iconColor: Colors.black,
                color: Colors.white.withOpacity(.5),
                onTap: onToggleAudio,
              ),
            DialButton(
              icon: callStatus == CallStatus.ended ||
                      callStatus == CallStatus.rejected
                  ? Icons.close
                  : Icons.call,
              iconColor: Colors.white,
              color: callStatus == CallStatus.ended ||
                      callStatus == CallStatus.rejected
                  ? Colors.black.withOpacity(.5)
                  : Colors.redAccent,
              onTap: onEndCall,
            ),
            if (callStatus == CallStatus.inCall)
              DialButton(
                icon: isFrontCameraSelected
                    ? Icons.camera_front
                    : Icons.camera_rear,
                color: Colors.white.withOpacity(.5),
                iconColor: Colors.black,
                onTap: onSwitchCamera,
              ),
          ],
        ),
      ),
    );
  }
}
