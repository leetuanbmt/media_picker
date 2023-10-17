import '../../routes/app_routes.dart';
import '../../routes/app_routes.gr.dart';
import '../config.dart';

class AppNavigator {
  factory AppNavigator() => instance;

  AppNavigator._internal();

  static final AppNavigator instance = AppNavigator._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // App router
  late final appRouter = AppRouter();

  // App navigator current route
  RouteData get currentRouter => appRouter.topRoute.router.current;

  // Current context

  goToLogin() {
    if (instance.currentRouter.name == LoginRoute.name) return;

    instance.appRouter.pushAndPopUntil(
      LoginRoute(),
      predicate: (route) => false,
    );
  }

  goToDashboard() {
    if (instance.currentRouter.name == DashboardRoute.name) return;
    instance.appRouter.pushAndPopUntil(
      const DashboardRoute(),
      predicate: (route) => false,
    );
  }

  navigator(PageRouteInfo routePage) {
    instance.appRouter.navigate(routePage);
  }
}
