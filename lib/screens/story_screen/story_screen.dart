import 'dart:math';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';

import 'package:video_player/video_player.dart';

import '../../core/config.dart';
import '../../core/models/story/story.dart';
import '../../core/models/user/user_model.dart';
import '../../core/utilities/utilities.dart';
import '../../core/utilities/video_manager.dart';
import '../../widgets/commons/cache_image.dart';
import '../../widgets/commons/indicators/loading_indicator.dart';

final videoProvider = ChangeNotifierProvider<VideoManager>(
  (ref) => VideoManager(),
);

@RoutePage()
class StoryViewPage extends ConsumerStatefulWidget {
  const StoryViewPage({
    super.key,
    required this.stories,
    this.initialPage = 0,
    this.storyInitPage = 0,
  });
  final List<StoryList> stories;
  final int initialPage;
  final int storyInitPage;
  @override
  ConsumerState<StoryViewPage> createState() => _StoryViewPageState();
  static openStory(
    BuildContext context, {
    required List<StoryList> stories,
    int initialPage = 0,
    int storyInitPage = 0,
  }) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        settings: const RouteSettings(name: 'StoryViewPage'),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: StoryViewPage(
              stories: stories,
              initialPage: initialPage,
              storyInitPage: storyInitPage,
            ),
          );
        },
      ),
    );
  }
}

class _StoryViewPageState extends ConsumerState<StoryViewPage>
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
    super.initState();
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
          // check if story is leaving or entering
          final bool isLeaving = (index - currentPageValue) <= 0;

          // calculate rotation of page
          final double t = index - currentPageValue;
          final double? rotationY = lerpDouble(0, 30, t);

          final Matrix4 transform = Matrix4.identity();
          // set perspective to transform
          transform.setEntry(3, 2, 0.003);
          // set translate to transform
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

class StoryScreen extends ConsumerStatefulWidget {
  const StoryScreen({
    super.key,
    required this.stories,
    required this.isLast,
    required this.animationPage,
    required this.currentIndexStory,
    required this.author,
    this.initialPage = 0,
  });
  final List<StoryModel> stories;
  final UserModel author;
  final bool isLast;
  final int currentIndexStory, initialPage;
  final Function(int) animationPage;
  @override
  ConsumerState<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends ConsumerState<StoryScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final videoManager = VideoManager();

  late PageController _pageController;
  late AnimationController _animationController;
  int _currentIndex = 0;
  List<StoryModel> get stories => widget.stories;

  UserModel get author => widget.author;

  StoryModel get _story => stories[_currentIndex];

  @override
  void initState() {
    // init page controller
    _pageController = PageController(initialPage: widget.initialPage);

    // init animation controller
    _animationController = AnimationController(vsync: this);

    // init view page index
    _currentIndex = widget.initialPage;

    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());

    // listen animation status
    _animationController.addStatusListener(_listenVideoPlayer);

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // play video when page is loaded
  Future<void> _initialize() async {
    await _loadStory(stories[_currentIndex], animateToPage: false);
  }

// initialize next video
  Future<void> _initializeNextVideo() async {
    if (_currentIndex + 1 < stories.length) {
      Logger.log('Loading next video ${_currentIndex + 1}');
      final StoryModel nextStory = stories[_currentIndex + 1];
      if (nextStory.isVideo) {
        ref.read(videoProvider).initializeNextVideo(nextStory.url);
      }
    }
  }

  // listen video end next story or next page
  Future<void> _listenVideoPlayer(AnimationStatus status) async {
    if (status != AnimationStatus.completed) return;
    // if finished video go to next story
    _animationController.stop();
    _animationController.reset();

    if (_currentIndex + 1 < stories.length) {
      // if not last story go to next story
      if (!mounted) return;
      setState(() {
        _currentIndex += 1;
      });
      await _loadStory(stories[_currentIndex]);
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      // check if app is resumed play video
      case AppLifecycleState.resumed:
        ref.read(videoProvider).resume();
        _animationController.forward();
        break;
      // check if app is paused pause video
      case AppLifecycleState.paused:
        ref.read(videoProvider).pause();
        _animationController.stop();
        break;
      default:
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void deactivate() {
    ref.read(videoProvider).pauseAll();
    super.deactivate();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
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
            Center(
              child: switch (_story.type) {
                DbKeys.image => AspectRatio(
                    aspectRatio: _story.aspectRatio,
                    child: CacheImage(
                      image: _story.url,
                      dimension: Size.infinite,
                    ),
                  ),
                DbKeys.video => Container(
                    width: context.screenWidth,
                    height: context.screenHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExtendedNetworkImageProvider(
                          _story.thumbnail,
                          cache: true,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Consumer(
                        builder: (_, ref, child) {
                          final videoAsync = ref.watch(videoProvider);
                          final video = videoAsync.video;
                          return video != null && videoAsync.isInitialized
                              ? AspectRatio(
                                  aspectRatio: _story.aspectRatio,
                                  child: VideoPlayer(video),
                                )
                              : const LoadingIndicator();
                        },
                      ),
                    ),
                  ),
                _ => const SizedBox.shrink(),
              },
            ),
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
            child: UserInfo(user: author, timeAgo: _story.timeAgo),
          ),
        ],
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    final manager = ref.read(videoProvider);
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
      if (_story.type == DbKeys.video) {
        if (manager.isPlaying) {
          manager.pause();
          _animationController.stop();
        } else {
          manager.resume();
          _animationController.forward();
        }
      }
    }
  }

  Future<void> _loadStory(StoryModel story, {bool animateToPage = true}) async {
    _animationController.stop();
    _animationController.reset();
    switch (story.type) {
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

  Future<void> _loadingVideo(StoryModel story) async {
    ref.read(videoProvider).play(story.url);
    await _initializeNextVideo();
    // if (_animationController.toStringDetails().contains('DISPOSED')) return;
    _animationController.duration = Duration(seconds: story.duration);
    _animationController.forward();
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  });
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
    super.key,
    required this.user,
    required this.timeAgo,
  });
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
