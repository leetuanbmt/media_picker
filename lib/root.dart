import 'core/config.dart';
import 'core/utilities/language.dart';
import 'core/utilities/navigator.dart';
import 'providers/global_provider.dart';
import 'screens/calling_screen/loading_wrapper_screen.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: AppLanguage.supports,
      fallbackLocale: AppLanguage.defaultLanguage,
      startLocale: AppLanguage.defaultLanguage,
      path: 'assets/locales',
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: false,
        builder: (_, Widget? child) {
          return Consumer(
            builder: (context, ref, child) {
              final appGlobal = ref.watch(appGlobalProvider);
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: MaterialApp.router(
                  title: AppConfig.title,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  showPerformanceOverlay: false,
                  showSemanticsDebugger: false,
                  theme: AppTheme.appTheme.copyWith(
                    primaryColor: appGlobal.themeColor,
                  ),
                  routerConfig: AppNavigator.instance.appRouter.config(
                    navigatorObservers: () => [MyObserver()],
                  ),
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaleFactor: 1.0,
                      ),
                      child: LoadingWrapperScreen(child!),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
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
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    Logger.log('Tab route visited: ${route.name}');
    super.didInitTabRoute(route, previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    Logger.log('Tab route re-visited: ${route.name}');
    super.didChangeTabRoute(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    Logger.log('Route popped: ${route.settings.name}');
    super.didPop(route, previousRoute);
  }
}
