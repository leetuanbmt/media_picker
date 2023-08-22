import 'core/config.dart';
import 'core/utilities/language.dart';
import 'routes/app_routes.dart';

class RootApp extends HookConsumerWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = ref.watch(selectedThemeColor);
    return EasyLocalization(
      supportedLocales: AppLanguage.supports,
      fallbackLocale: AppLanguage.defaultLanguage,
      startLocale: AppLanguage.defaultLanguage,
      path: 'assets/locales',
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: false,
        builder: (_, Widget? child) {
          return Builder(
            builder: (context) {
              return MaterialApp.router(
                title: AppConfig.title,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                showPerformanceOverlay: false,
                theme: AppTheme.appTheme.copyWith(
                  primaryColor: Vx.hexToColor(colorTheme),
                ),
                routerDelegate: _appRouter.delegate(),
                routeInformationParser: _appRouter.defaultRouteParser(),
              );
            },
          );
        },
      ),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
final _appRouter = AppRouter(navigatorKey);
