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
    AutoRoute(page: LoginRoute.page, path: '/login', initial: true),
    AutoRoute(page: UserRoute.page, path: '/user'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}
