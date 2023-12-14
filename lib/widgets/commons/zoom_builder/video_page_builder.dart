part of 'media_builder_preview.dart';

class VideoPageBuilder extends StatefulWidget {
  const VideoPageBuilder({
    super.key,
    this.asset,
    this.url,
    this.autoPlay = false,
    this.thumbnail,
    this.onFinish,
    this.toggleShowAppBar,
  }) : assert(asset == null || url == null, 'please exit asset or ur');
  final AssetEntity? asset;
  final String? url;
  final ImageProvider? thumbnail;
  final bool autoPlay;
  final VoidCallback? onFinish;
  final Function(bool)? toggleShowAppBar;
  @override
  State<VideoPageBuilder> createState() => _VideoPageBuilderState();
}

class _VideoPageBuilderState extends State<VideoPageBuilder>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _controller;
  bool isPlaying = false;
  bool get isControllerPlaying => _controller?.value.isPlaying ?? false;
  bool hasErrorWhenInitializing = false;
  bool isLoading = false;
  double aspectRatio = 16 / 9;
  bool _hideStuff = false;
  Timer? _hideTimer;
  AnimationController? _buttonAnimation;
  @override
  void initState() {
    super.initState();
    _buttonAnimation = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    );
    if (widget.asset != null) {
      final mediaSize = MediaQuery.of(context).size;
      final Size size = AppUtils.sizeImage(
        widget.asset!.width.toDouble(),
        widget.asset!.height.toDouble(),
        targetHeight: mediaSize.width,
        targetWidth: mediaSize.height,
      );
      aspectRatio = size.width / size.height;
    }
    initializeVideoPlayerController();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _buttonAnimation?.dispose();
    _controller?.removeListener(videoPlayerListener);
    _controller?.pause();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> initializeVideoPlayerController() async {
    isLoading = widget.autoPlay;
    String? url = widget.url;
    if (widget.asset != null) {
      url = await widget.asset!.getMediaUrl();
    } else {
      debugPrint('url ${widget.url}');
      debugPrint('thumbnail ${widget.thumbnail}');
    }
    _controller = VideoPlayerController.networkUrl(Uri.parse(url!));
    setInitState();
    try {
      await _controller?.initialize();
      setState(() {
        aspectRatio = _controller!.value.aspectRatio;
        isLoading = false;
      });
      if (widget.autoPlay) {
        _hideStuff = true;
        widget.toggleShowAppBar?.call(false);
        _controller?.play();
        _buttonAnimation?.forward();
      }
      _controller?.addListener(videoPlayerListener);
    } catch (e) {
      debugPrint('Error when initialize video controller: $e');
      hasErrorWhenInitializing = true;
    } finally {
      setInitState();
    }
  }

  void videoPlayerListener() {
    if (isControllerPlaying != isPlaying) {
      isPlaying = isControllerPlaying;
    }
    if (_controller?.value.position == _controller?.value.duration) {
      widget.onFinish?.call();
    }
    setInitState();
  }

  void _cancelAndRestartTimer() {
    _hideTimer?.cancel();
    _hideStuff = false;
    widget.toggleShowAppBar?.call(true);
    _startHideTimer();
    setInitState();
  }

  void _startHideTimer() {
    _hideTimer = Timer(const Duration(seconds: 3), () {
      _hideStuff = true;
      widget.toggleShowAppBar?.call(false);
      setInitState();
    });
  }

  void _setHideStuff(bool value) {
    _hideStuff = value;
    widget.toggleShowAppBar?.call(!value);
    setInitState();
  }

  Future<void> playButtonCallback() async {
    if (hasErrorWhenInitializing) {
      return;
    }
    if (_controller?.value != null) {
      if (isPlaying) {
        _controller?.pause();
        _buttonAnimation?.reverse();
      } else {
        if (_controller?.value.duration == _controller?.value.position) {
          _controller!
            ..seekTo(Duration.zero)
            ..play();
          _buttonAnimation?.forward();
        } else {
          _setHideStuff(true);
          widget.toggleShowAppBar?.call(false);
          _controller?.play();
          _buttonAnimation?.forward();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MouseRegion(
      onHover: (_) => _cancelAndRestartTimer(),
      child: GestureDetector(
        onTap: _cancelAndRestartTimer,
        child: AbsorbPointer(
          absorbing: _hideStuff,
          child: Container(
            width: size.width,
            height: size.height,
            decoration: widget.thumbnail != null
                ? BoxDecoration(
                    image: DecorationImage(image: widget.thumbnail!),
                  )
                : null,
            child: !hasErrorWhenInitializing
                ? Stack(
                    children: <Widget>[
                      if (_controller != null)
                        Positioned.fill(
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: aspectRatio,
                              child: VideoPlayer(_controller!),
                            ),
                          ),
                        ),
                      if (isLoading) const _LoadingIndicator(),
                      if (_controller != null && !isLoading)
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Center(
                            child: AnimatedOpacity(
                              duration: kThemeAnimationDuration,
                              opacity: _hideStuff ? 0.0 : 1.0,
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
                                    (_controller?.value.isPlaying ?? false)
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
                      if (_controller != null)
                        AnimatedOpacity(
                          opacity: _hideStuff ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 300),
                          child: _buildBottomBar(),
                        ),
                    ],
                  )
                : const Center(child: Text('Load video false')),
          ),
        ),
      ),
    );
  }

  Align _buildBottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 40,
        color: Colors.black.withOpacity(.2),
        child: Row(
          children: <Widget>[
            _buildSkipBack(),
            _buildPlayPause(),
            _buildSkipForward(),
            _buildPosition(),
            VideoProgress(_controller!, seekTo: _seekTo),
            _buildRemaining(),
          ],
        ),
      ),
    );
  }

  Widget _buildPosition() {
    final Duration position = _controller?.value != null
        ? _controller!.value.position
        : const Duration();
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Text(
        AppUtils.formatDuration(position),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget _buildRemaining() {
    final VideoPlayerValue? latestValue = _controller?.value;
    final Duration position = latestValue != null
        ? latestValue.duration - latestValue.position
        : const Duration();

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Text(
        '-${AppUtils.formatDuration(position)}',
        style: const TextStyle(color: Colors.white, fontSize: 12.0),
      ),
    );
  }

  GestureDetector _buildPlayPause() {
    return GestureDetector(
      onTap: playButtonCallback,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        color: Colors.transparent,
        padding: const EdgeInsets.only(
          left: 6.0,
          right: 6.0,
        ),
        child: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _buttonAnimation!,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  GestureDetector _buildSkipBack() {
    return GestureDetector(
      onTap: _skipBack,
      child: Container(
        height: 40,
        color: Colors.transparent,
        margin: const EdgeInsets.only(left: 10.0),
        padding: const EdgeInsets.only(
          left: 6.0,
          right: 6.0,
        ),
        child: const Icon(
          CupertinoIcons.gobackward_15,
          color: Colors.white,
          size: 18.0,
        ),
      ),
    );
  }

  GestureDetector _buildSkipForward() {
    return GestureDetector(
      onTap: _skipForward,
      child: Container(
        height: 40,
        color: Colors.transparent,
        padding: const EdgeInsets.only(
          left: 6.0,
          right: 8.0,
        ),
        margin: const EdgeInsets.only(
          right: 8.0,
        ),
        child: const Icon(
          CupertinoIcons.goforward_15,
          color: Colors.white,
          size: 18.0,
        ),
      ),
    );
  }

  Future<void> _seekTo(Duration position) async {
    final bool isFinished = position == _controller?.value.duration;
    if (isFinished && isPlaying) {
      _controller?.pause();
      _buttonAnimation?.reverse();
    } else if (!isPlaying) {
      _controller?.play();
      _buttonAnimation?.forward();
    }
  }

  void _skipBack() {
    _cancelAndRestartTimer();
    final int beginning = const Duration().inMilliseconds;
    final int skip = (_controller!.value.position - const Duration(seconds: 15))
        .inMilliseconds;
    _controller?.seekTo(Duration(milliseconds: math.max(skip, beginning)));
  }

  void _skipForward() {
    _cancelAndRestartTimer();
    final int end = _controller!.value.duration.inMilliseconds;
    final int skip = (_controller!.value.position + const Duration(seconds: 15))
        .inMilliseconds;
    _controller?.seekTo(Duration(milliseconds: math.min(skip, end)));
  }

  void setInitState() {
    if (mounted) {
      setState(() {});
    }
  }
}
