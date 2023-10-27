part of '../chat_screen.dart';

class ChatAudio extends StatefulWidget {
  const ChatAudio(this.message, {super.key});
  final Message message;

  @override
  State<ChatAudio> createState() => _ChatAudioState();
}

class _ChatAudioState extends State<ChatAudio> {
  final duration = 232;
  final url =
      'https://firebasestorage.googleapis.com/v0/b/codebase-57bc1.appspot.com/o/chat%2Faudios%2F1647482220232.png?alt=media&token=c8b0bbea-8bf5-4d7e-a4c1-19c3792d6ea0';

  VideoPlayerController? _controller;

  final _durationStream = StreamController<Duration>.broadcast();
  final _sliderValue = ValueNotifier<double>(0.0);
  bool _dragging = false;
  bool isLoaded = false;
  bool isPlaying = false;
  bool get isControllerPlaying => _controller?.value.isPlaying ?? false;

  @override
  void didUpdateWidget(ChatAudio oldWidget) {
    if (oldWidget.message != widget.message) {
      _dispose();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> openAudioFile() async {
    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(url));
      await _controller?.initialize();
      _controller?.addListener(audioPlayerListener);
    } catch (e) {
      if (mounted) {
        context.toast('Error when opening audio file: $e');
      }
    } finally {
      isLoaded = true;
      if (mounted) {
        setState(() {});
      }
    }
  }

  void audioPlayerListener() {
    if (isControllerPlaying != isPlaying) {
      isPlaying = isControllerPlaying;
      if (mounted) {
        setState(() {});
      }
    }

    if (_controller?.value.position != null) {
      _durationStream.add(_controller!.value.position);
    }
  }

  void _dispose() {
    _controller?.pause();
    _controller?.removeListener(audioPlayerListener);
    _controller?.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Colors.grey.withOpacity(0.2),
        border: Border.all(
          color: Colors.blueGrey.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (isPlaying) {
                _controller?.pause();
              } else {
                if (!isLoaded) {
                  openAudioFile().then((value) {
                    _controller?.play();
                  });
                }
              }
            },
            child: Icon(
              isPlaying
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_filled_sharp,
              size: 40,
              color: context.primary,
            ),
          ),
          durationIndicator,
        ],
      ),
    );
  }

  Widget get durationIndicator => StreamBuilder<Duration>(
        initialData: Duration.zero,
        stream: _durationStream.stream,
        builder: (BuildContext _, AsyncSnapshot<Duration> data) {
          int value = data.data!.inSeconds;
          if (_dragging == false) {
            _sliderValue.value = value.toDouble();
          }
          double max = duration.toDouble();

          if (data.data!.inSeconds > max) {
            return const SizedBox();
          }
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect rect) => LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: <double>[value / max, value / max],
                          colors: <Color>[
                            context.colorScheme.primary,
                            Colors.white.withOpacity(.85),
                          ],
                        ).createShader(rect),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Assets.imagesWaveform.provider(),
                            ),
                          ),
                        ),
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                          trackHeight: 20,
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                          overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 0,
                          ),
                          thumbColor: Colors.transparent,
                          activeTrackColor: Colors.transparent,
                          inactiveTrackColor: Colors.transparent,
                        ),
                        child: Slider(
                          min: 0,
                          max: max,
                          value: value.toDouble(),
                          label:
                              AppUtils.formatDuration(Duration(seconds: value)),
                          divisions: 100,
                          onChangeStart: (_) => _dragging = true,
                          onChangeEnd: (double val) {
                            _dragging = false;
                            _controller?.seekTo(Duration(seconds: val.toInt()));
                          },
                          onChanged: (double val) {
                            _sliderValue.value = val;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Dimensions.width5,
                Center(
                  child: Text(
                    AppUtils.formatDuration(
                      Duration(
                        seconds: duration - data.data!.inSeconds,
                      ),
                    ),
                    style: context.labelMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: context.primary,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}
