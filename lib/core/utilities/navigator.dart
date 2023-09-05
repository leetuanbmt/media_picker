import '../../routes/app_routes.dart';
import '../config.dart';

class AppNavigator {
  factory AppNavigator() => instance;

  AppNavigator._internal();

  static final AppNavigator instance = AppNavigator._internal();

  // Navigator key for navigation
  final navigatorKey = GlobalKey<NavigatorState>();

  // App router
  late final appRouter = AppRouter(navigatorKey);

  // App navigator current context
  BuildContext get currentContext => navigatorKey.currentContext!;

  // App navigator current route
  RouteData get currentRouter => appRouter.topRoute.router.current;

  void push(Widget child) => currentContext.nextPage(child);

  void pop() => navigatorKey.currentState?.maybePop();
}
