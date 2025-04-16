part of '../../media_picker.dart';

class VideoPageBuilder extends StatefulWidget {
  const VideoPageBuilder({
    super.key,
    required this.asset,
    required this.delegate,
    this.hasOnlyOneVideoAndMoment = false,
  });

  final AssetEntity asset;

  final AssetPickerViewerBuilderDelegate<AssetEntity, AssetPathEntity> delegate;

  final bool hasOnlyOneVideoAndMoment;

  @override
  State<VideoPageBuilder> createState() => _VideoPageBuilderState();
}

class _VideoPageBuilderState extends State<VideoPageBuilder> {
  VideoPlayerController get controller => _controller!;
  VideoPlayerController? _controller;

  bool hasLoaded = false;

  bool hasErrorWhenInitializing = false;

  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);

  bool get isControllerPlaying => _controller?.value.isPlaying ?? false;

  bool _isInitializing = false;
  bool _isLocallyAvailable = false;

  @override
  void didUpdateWidget(VideoPageBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.asset != oldWidget.asset) {
      _controller
        ?..removeListener(videoPlayerListener)
        ..pause()
        ..dispose();
      _controller = null;
      hasLoaded = false;
      hasErrorWhenInitializing = false;
      isPlaying.value = false;
      _isInitializing = false;
      _isLocallyAvailable = false;
    }
  }

  @override
  void dispose() {
    _controller
      ?..removeListener(videoPlayerListener)
      ..pause()
      ..dispose();
    super.dispose();
  }

  Future<void> initializeVideoPlayerController() async {
    _isInitializing = true;
    _isLocallyAvailable = true;
    final String? url = await widget.asset.getMediaUrl();
    if (url == null) {
      hasErrorWhenInitializing = true;
      if (mounted) {
        setState(() {});
      }
      return;
    }
    final Uri uri = Uri.parse(url);
    if (Platform.isAndroid) {
      _controller = VideoPlayerController.contentUri(uri);
    } else {
      _controller = VideoPlayerController.networkUrl(uri);
    }
    try {
      await controller.initialize();
      hasLoaded = true;
      controller
        ..addListener(videoPlayerListener)
        ..setLooping(widget.hasOnlyOneVideoAndMoment);
      if (widget.hasOnlyOneVideoAndMoment) {
        controller.play();
      }
    } catch (e, s) {
      FlutterError.presentError(
        FlutterErrorDetails(
          exception: e,
          stack: s,
          silent: true,
        ),
      );
      hasErrorWhenInitializing = true;
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }

  void videoPlayerListener() {
    if (isControllerPlaying != isPlaying.value) {
      isPlaying.value = isControllerPlaying;
    }
  }

  Future<void> playButtonCallback() async {
    if (isPlaying.value) {
      controller.pause();
      return;
    }
    if (widget.delegate.isDisplayingDetail.value &&
        !MediaQuery.accessibleNavigationOf(context)) {
      widget.delegate.switchDisplayingDetail(value: false);
    }
    if (controller.value.duration == controller.value.position) {
      controller
        ..seekTo(Duration.zero)
        ..play();
      return;
    }
    controller.play();
  }

  Widget _contentBuilder(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned.fill(
          child: Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
        ),
        if (!widget.hasOnlyOneVideoAndMoment)
          ValueListenableBuilder<bool>(
            valueListenable: isPlaying,
            builder: (_, bool value, __) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: value || MediaQuery.accessibleNavigationOf(context)
                  ? playButtonCallback
                  : widget.delegate.switchDisplayingDetail,
              child: Center(
                child: AnimatedOpacity(
                  duration: kThemeAnimationDuration,
                  opacity: value ? 0.0 : 1.0,
                  child: GestureDetector(
                    onTap: playButtonCallback,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black12),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        value
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_filled,
                        size: 70.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocallyAvailableBuilder(
      key: ValueKey<String>(widget.asset.id),
      asset: widget.asset,
      builder: (BuildContext context, AssetEntity asset) {
        if (hasErrorWhenInitializing) {
          return Center(
            child: ScaleText(
              Singleton.textDelegate.loadFailed,
              semanticsLabel:
                  Singleton.textDelegate.semanticsTextDelegate.loadFailed,
            ),
          );
        }
        if (!_isLocallyAvailable && !_isInitializing) {
          initializeVideoPlayerController();
        }
        if (!hasLoaded) {
          return const SizedBox.shrink();
        }
        return Semantics(
          onLongPress: playButtonCallback,
          onLongPressHint:
              Singleton.textDelegate.semanticsTextDelegate.sActionPlayHint,
          child: _contentBuilder(context),
        );
      },
    );
  }
}
