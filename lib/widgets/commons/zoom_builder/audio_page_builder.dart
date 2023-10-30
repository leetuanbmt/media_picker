part of 'media_builder_preview.dart';

class AudioPageBuilder extends StatefulWidget {
  const AudioPageBuilder({super.key, required this.asset});

  final AssetEntity asset;

  @override
  State<StatefulWidget> createState() => _AudioPageBuilderState();
}

class _AudioPageBuilderState extends State<AudioPageBuilder> {
  final StreamController<Duration> durationStreamController =
      StreamController<Duration>.broadcast();
  VideoPlayerController? _controller;

  bool isLoaded = false;
  bool isPlaying = false;
  bool get isControllerPlaying => _controller?.value.isPlaying ?? false;
  late Duration assetDuration;

  @override
  void initState() {
    super.initState();
    openAudioFile();
  }

  @override
  void dispose() {
    _controller?.pause();
    _controller?.removeListener(audioPlayerListener);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> openAudioFile() async {
    try {
      final String? url = await widget.asset.getMediaUrl();
      assetDuration = Duration(seconds: widget.asset.duration);
      _controller = VideoPlayerController.networkUrl(Uri.parse(url!));
      await _controller?.initialize();
      _controller?.addListener(audioPlayerListener);
    } catch (e) {
      debugPrint('Error when opening audio file: $e');
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
      durationStreamController.add(_controller!.value.position);
    }
  }

  Widget get titleWidget => Text(
        widget.asset.title ?? '',
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      );

  Widget get audioControlButton => GestureDetector(
        onTap: () {
          if (isPlaying) {
            _controller?.pause();
          } else {
            _controller?.play();
          }
        },
        child: Container(
          margin: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12)],
            shape: BoxShape.circle,
          ),
          child: Icon(
            isPlaying ? Icons.pause_circle_outline : Icons.play_circle_filled,
            size: 70.0,
            color: Colors.white,
          ),
        ),
      );

  Widget get durationIndicator => StreamBuilder<Duration>(
        initialData: Duration.zero,
        stream: durationStreamController.stream,
        builder: (BuildContext _, AsyncSnapshot<Duration> data) {
          return Text(
            '${AppUtils.formatDuration(data.data!)}'
            ' / '
            '${AppUtils.formatDuration(assetDuration)}',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: isLoaded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                titleWidget,
                audioControlButton,
                durationIndicator,
              ],
            )
          : const _LoadingIndicator(),
    );
  }
}
