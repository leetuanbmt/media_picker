import 'package:auto_route/auto_route.dart';

import '../core/utilities/preferences.dart';
import 'app_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter implements AutoRouteGuard {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: DashboardRoute.page,
      path: '/dashboard',
      initial: true,
      children: [
        AutoRoute(
          initial: true,
          page: HomeTabRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: SearchCreatorRoute.page),
          ],
        ),
        AutoRoute(
          page: ProfileTabRoute.page,
          children: [
            AutoRoute(initial: true, page: ProfileRoute.page),
            AutoRoute(page: EditProfileRoute.page),
            AutoRoute(page: PointConfirmRoute.page),
            AutoRoute(page: UsageGuideRoute.page),
            AutoRoute(page: UsageFlowRoute.page),
            AutoRoute(page: UsagePlayRoute.page),
          ],
        ),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: MainRoute.page),
        AutoRoute(page: NotificationRoute.page),
      ],
    ),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: QRRoute.page),
    AutoRoute(page: UserRoute.page),
    AutoRoute(page: OTPRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: SelectAttributeRoute.page),
    RedirectRoute(path: '*', redirectTo: '/dashboard'),
  ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authenticated = Preferences.authenticated;
    if (authenticated || resolver.route.name != DashboardRoute.name) {
      resolver.next(true);
    } else {
      resolver.redirect(
        LoginRoute(onResult: (didLogin) => resolver.next(didLogin)),
      );
    }
  }
}

@RoutePage(name: 'HomeTabRoute')
class HomeTab extends AutoRouter {
  const HomeTab({super.key});
}

@RoutePage(name: 'ProfileTabRoute')
class ProfileTab extends AutoRouter {
  const ProfileTab({super.key});
}
