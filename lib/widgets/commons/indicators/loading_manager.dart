import 'dart:math';

import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';

class LoadingManager {
  factory LoadingManager() => instance;

  LoadingManager._();

  static final LoadingManager instance = LoadingManager._();

  bool showLoading = false;
  BuildContext? buildContext;

  void show(BuildContext context) {
    if (showLoading) {
      return;
    }
    buildContext = context;
    showLoading = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      routeSettings: const RouteSettings(name: "LoadingManager"),
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: const Center(child: TurnLoading()),
      ),
    );
  }

  void hide(BuildContext context) {
    if (!showLoading) {
      return;
    }
    buildContext = null;
    Navigator.pop(context);
    showLoading = false;
  }
}

class TurnLoading extends HookWidget {
  const TurnLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final animate = useAnimationController(
      duration: const Duration(seconds: 2),
      initialValue: 0,
    )..repeat();
    return Center(
      child: AnimatedBuilder(
        animation: animate,
        builder: (context, child) {
          return Transform.rotate(
            angle: animate.value * 2 * pi,
            child: child,
          );
        },
        child: Assets.iconsIconLoading.svg(),
      ),
    );
  }
}
