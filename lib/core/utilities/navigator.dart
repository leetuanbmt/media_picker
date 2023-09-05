import '../../routes/app_routes.dart';
import '../config.dart';

class AppNavigator {
  factory AppNavigator() => instance;

  AppNavigator._internal();

  static final AppNavigator instance = AppNavigator._internal();

  // App router
  late final appRouter = AppRouter();

  // App navigator current route
  RouteData get currentRouter => appRouter.topRoute.router.current;
}
