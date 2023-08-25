import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  AppRouter(this.navigatorKey);

  @override
  final GlobalKey<NavigatorState> navigatorKey;
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      initial: true,
      page: DashboardRoute.page,
      path: '/dashboard',
      children: [
        AutoRoute(
          initial: true,
          page: EmptyRouterRoute.page,
          path: 'homeTabs',
          children: [
            AutoRoute(initial: true, page: HomeRoute.page, path: 'home'),
            AutoRoute(page: SearchCreatorRoute.page, path: 'searchCreator'),
          ],
        ),
        AutoRoute(page: SearchRoute.page, path: 'search'),
        AutoRoute(page: MainRoute.page, path: 'main'),
        AutoRoute(page: NotificationRoute.page, path: 'notification'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
      ],
    ),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: QRRoute.page, path: '/qrRoute'),
    AutoRoute(page: UserRoute.page, path: '/user'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}

@RoutePage()
class EmptyRouterScreen extends AutoRouter {
  const EmptyRouterScreen({super.key});
}
