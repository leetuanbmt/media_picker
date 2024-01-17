import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';

import 'core/config.dart';
import 'core/utilities/navigator.dart';
import 'hooks/configurations/use_deep_linking.dart';
import 'hooks/configurations/use_get_storage_perms.dart';
import 'l10n/l10n.dart';

import 'providers/user_preferences/user_preferences_provider.dart';
import 'screens/calling_screen/loading_wrapper_screen.dart';

class RootApp extends StatefulHookConsumerWidget {
  const RootApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootAppState();
}

class _RootAppState extends ConsumerState<RootApp> {
  @override
  Widget build(BuildContext context) {
    // locale
    final locale = ref.watch(userPreferencesProvider.select((s) => s.locale));

    // theme mode
    final themeMode =
        ref.watch(userPreferencesProvider.select((s) => s.themeMode));

    // theme color
    final themeColor =
        ref.watch(userPreferencesProvider.select((s) => s.themeColor));

    // light theme
    final lightTheme = useMemoized(
      () => AppTheme.appTheme(themeColor, Brightness.light),
      [themeColor],
    );

    // dark theme
    final darkTheme = useMemoized(
      () => AppTheme.appTheme(themeColor, Brightness.dark),
      [themeColor],
    );
    getCallingPermissions();
    useDeepLinking();

    return MaterialApp.router(
      title: AppConfig.title,
      supportedLocales: L10n.all,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: AppNavigator.instance.appRouter.config(
        navigatorObservers: () => [MyObserver()],
      ),
      builder: (context, child) {
        return Portal(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: LoadingWrapperScreen(child!),
          ),
        );
      },
    );
  }
}

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    Logger.log('New route pushed: ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    final routeName = AppNavigator.instance.currentRouter.name;
    Logger.log('Route popped: $routeName');
    super.didPop(route, previousRoute);
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    Logger.log('Tab route visited: ${route.name}');
    super.didInitTabRoute(route, previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    final routeName = AppNavigator.instance.currentRouter.name;
    Logger.log('Tab route re-visited: $routeName');
    super.didChangeTabRoute(route, previousRoute);
  }
}
