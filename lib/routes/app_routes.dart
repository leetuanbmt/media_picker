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
          page: HomeTabRoute.page,
          children: [
            AutoRoute(initial: true, page: HomeRoute.page),
            AutoRoute(page: SearchCreatorRoute.page),
          ],
        ),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: MainRoute.page),
        AutoRoute(page: NotificationRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: QRRoute.page),
    AutoRoute(page: UserRoute.page),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}

@RoutePage(name: 'HomeTabRoute')
class HomeTab extends AutoRouter {
  const HomeTab({super.key});
}
