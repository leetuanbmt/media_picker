import 'dart:math';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';

import '../../core/config.dart';
import '../../core/models/story/story.dart';
import '../../core/models/user/user_model.dart';
import '../../core/utilities/utilities.dart';
import '../../widgets/commons/cache_image.dart';
import '../../widgets/commons/indicators/loading_indicator.dart';

@RoutePage()
class StoryViewPage extends StatefulWidget {
  const StoryViewPage({
    Key? key,
    required this.stories,
    this.initialPage = 0,
    this.storyInitPage = 0,
  }) : super(key: key);
  final List<StoryList> stories;
  final int initialPage;
  final int storyInitPage;
  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late double currentPageValue;

  List<StoryList> get _stories => widget.stories;

  @override
  void initState() {
    currentPageValue = widget.initialPage.toDouble();
    _pageController = PageController(initialPage: widget.initialPage);
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page!;
      });
    });

    // set bottom navigator bar dark
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
    );
    super.initState();
  }

  @override
  void deactivate() {
    // for (UserModel user in _users) {
    //   for (StoryData item in user.storyData) {
    //     item.dispose();
    //   }
    // }

    for (var element in _stories) {
      element.dispose();
    }

// set bottom navigator bar light
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
      ),
    );

    super.deactivate();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _stories.length,
        itemBuilder: (_, int index) {
          final bool isLeaving = (index - currentPageValue) <= 0;
          final double t = index - currentPageValue;
          final double? rotationY = lerpDouble(0, 30, t);
          final Matrix4 transform = Matrix4.identity();
          transform.setEntry(3, 2, 0.003);
          transform.rotateY(-rotationY! * (pi / 180.0));
          return Transform(
            alignment: isLeaving ? Alignment.centerRight : Alignment.centerLeft,
            transform: transform,
            child: StoryScreen(
              currentIndexStory: index,
              stories: _stories[index].stories,
              author: _stories[index].user,
              isLast: index == _stories.length - 1,
              initialPage: widget.storyInitPage,
              animationPage: (int nextPage) {
                _pageController.animateToPage(
                  nextPage,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.easeInOut,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class StoryScreen extends StatefulWidget {
  const StoryScreen({
    Key? key,
    required this.stories,
    required this.isLast,
    required this.animationPage,
    required this.currentIndexStory,
    required this.author,
    this.initialPage = 0,
  }) : super(key: key);
  final List<StoryItem> stories;
  final UserModel author;
  final bool isLast;
  final int currentIndexStory, initialPage;
  final Function(int) animationPage;
  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> showLoading = ValueNotifier<bool>(false);

  late PageController _pageController;
  late AnimationController _animationController;
  int _currentIndex = 0;
  List<StoryItem> stories = <StoryItem>[];
  late UserModel author;

  StoryItem get _story => stories[_currentIndex];

  @override
  void initState() {
    super.initState();

    author = widget.author;

    stories = widget.stories;
    _pageController = PageController(initialPage: widget.initialPage);
    _animationController = AnimationController(vsync: this);

    // init view page index
    _currentIndex = widget.initialPage;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadStory(stories[_currentIndex], animateToPage: false);
      await _initializeNextVideo();
    });
    _animationController.addStatusListener(_listenVideoPlayer);
  }

// initialize next video
  Future<void> _initializeNextVideo() async {
    if (_currentIndex + 1 < stories.length) {
      Logger.log("Loading next video ${_currentIndex + 1}");
      final StoryItem nextStory = stories[_currentIndex + 1];
      if (nextStory.info.isVideo) {
        await _initializeVideo(nextStory);
      }
    }
  }

  // listen video end next story or next page
  Future<void> _listenVideoPlayer(AnimationStatus status) async {
    if (status != AnimationStatus.completed) return;
    // if finished video

    _animationController.stop();
    _animationController.reset();
    if (_currentIndex + 1 < stories.length) {
      // if not last story go to next story
      if (!mounted) return;
      setState(() {
        _currentIndex += 1;
      });
      await _loadStory(stories[_currentIndex]);
      await _initializeNextVideo();
    } else {
      if (widget.isLast) {
        // if last story and last page close story screen
        Navigator.pop(context);
      } else {
        // if last story and not last page go to next page
        widget.animationPage(widget.currentIndexStory + 1);
      }
    }
  }

  @override
  void deactivate() {
    _pauseAll();
    super.deactivate();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: _onTapDown,
        child: Stack(
          children: <Widget>[
            switch (_story.info.type) {
              DbKeys.image => CacheImage(
                  image: _story.info.url,
                  dimension: Size.infinite,
                ),
              DbKeys.video => Container(
                  width: context.screenWidth,
                  height: context.screenHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExtendedNetworkImageProvider(
                        _story.info.thumbnail,
                        cache: true,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      if (_story.player != null &&
                          _story.player!.value.isInitialized)
                        Center(
                          child: AspectRatio(
                            aspectRatio: _story.player!.value.aspectRatio,
                            child: VideoPlayer(_story.player!),
                          ),
                        ),
                      Positioned.fill(
                        child: ValueListenableBuilder<bool>(
                          valueListenable: showLoading,
                          builder: (_, bool isLoading, __) {
                            return AnimatedOpacity(
                              opacity: isLoading ? 1.0 : 0.0,
                              duration: kThemeAnimationDuration,
                              child: const Stack(
                                alignment: Alignment.center,
                                children: <Widget>[LoadingIndicator()],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              _ => const SizedBox.shrink(),
            },
            _author(),
          ],
        ),
      ),
    );
  }

  Widget _author() {
    return Positioned(
      top: kToolbarHeight * .2 + context.screenPadding.top,
      left: 10.0,
      right: 10.0,
      child: Column(
        children: <Widget>[
          Row(
            children: stories
                .asMap()
                .entries
                .map(
                  (e) => AnimatedBar(
                    animController: _animationController,
                    position: e.key,
                    currentIndex: _currentIndex,
                  ),
                )
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 1.5,
              vertical: 10.0,
            ),
            child: UserInfo(user: author, timeAgo: _story.info.timeAgo),
          ),
        ],
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if (mounted) {
        setState(() {
          if (_currentIndex - 1 >= 0) {
            _currentIndex -= 1;
            _loadStory(stories[_currentIndex]);
          }
        });
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (mounted) {
        setState(() {
          if (_currentIndex + 1 < stories.length) {
            _currentIndex += 1;
            _loadStory(stories[_currentIndex]);
          } else {
            _currentIndex = 0;
            _loadStory(stories[_currentIndex]);
          }
        });
      }
    } else {
      if (_story.info.type == DbKeys.video) {
        if (_story.player!.value.isPlaying) {
          _story.player?.pause();
          _animationController.stop();
        } else {
          _story.player?.play();
          _animationController.forward();
        }
      }
    }
  }

  void _pauseAll() {
    for (int i = 0; i < stories.length; i++) {
      final StoryItem storyModel = stories[i];
      if (storyModel.info.isVideo && storyModel.player != null) {
        storyModel.player?.pause();
      }
    }
  }

  Future<void> _loadStory(
    StoryItem story, {
    bool animateToPage = true,
  }) async {
    _animationController.stop();
    _animationController.reset();
    _pauseAll();
    switch (story.info.type) {
      case DbKeys.image:
        _animationController.duration = const Duration(seconds: 3);
        _animationController.forward();
        break;
      case DbKeys.video:
        await _loadingVideo(story);
        break;
    }
    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _initializeVideo(StoryItem story) async {
    try {
      if (story.isLoading) return;
      story.isLoading = true;
      if (story.player != null && story.player!.value.isInitialized) return;
      final fileInfo = await CustomCacheManager.instance.getFile(
        story.info.url,
        isAutoDownload: true,
      );
      if (!mounted) return;
      if (fileInfo == null) {
        story.player = VideoPlayerController.networkUrl(
          Uri.parse(story.info.url),
        );
      } else {
        Logger.log('Playing for cache');
        story.player = VideoPlayerController.file(fileInfo.file);
      }
      await story.player?.initialize();
      story.isLoading = false;
    } catch (e) {
      Logger.log("Error init video: $e");
    }
  }

  Future<void> _loadingVideo(StoryItem story) async {
    try {
      if (story.player != null && story.player!.value.isInitialized) {
        _animationController.duration = Duration(seconds: story.info.duration);
        _animationController.forward();
        story.player!.seekTo(const Duration());
        story.player!.play();
      } else {
        showLoading.value = true;
        await _initializeVideo(story);
        if (!_animationController.toStringDetails().contains('DISPOSED')) {
          showLoading.value = false;
          _animationController.duration = Duration(
            seconds: story.info.duration,
          );
          _animationController.forward();
          story.player!.play();
          story.player!.setLooping(true);
        }
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      Logger.log(e);
    }
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    Key? key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  }) : super(key: key);
  final AnimationController animController;
  final int position;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (_, BoxConstraints constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                if (position == currentIndex)
                  AnimatedBuilder(
                    animation: animController,
                    builder: (_, __) {
                      return _buildContainer(
                        constraints.maxWidth * animController.value,
                        Colors.white,
                      );
                    },
                  )
                else
                  const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 3.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black26, width: 0.8),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.user,
    required this.timeAgo,
  }) : super(key: key);
  final UserModel user;
  final String timeAgo;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CacheImage(
          image: user.avatar,
          dimension: Size.square(40.r),
          radius: 100,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '${user.name}\n',
                  style: context.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: timeAgo,
                  style: context.labelMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const CloseButton(color: Colors.white),
      ],
    );
  }
}
