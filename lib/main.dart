import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/config.dart';
import 'core/utilities/persisted_state_notifier.dart';
import 'firebase_options.dart';
import 'root.dart';

Future<void> initService() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    final hiveCacheDir = (await getApplicationSupportDirectory()).path;

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // init hive
    Hive.init(hiveCacheDir);

    await PersistedStateNotifier.initializeBoxes(
      path: hiveCacheDir,
    );

    if (kReleaseMode)
      await SentryFlutter.init((options) => options.dsn = AppConfig.sentryDsn);
    // set image cache size
    PaintingBinding.instance.imageCache
      ..maximumSize = 1000
      ..maximumSizeBytes = 500 << 20;
  } catch (e) {
    Logger.log('initService $e', tag: 'initService');
  }
}

void main() async {
  runZonedGuarded(() async {
    await initService();
    runApp(
      const ProviderScope(
        // observers: [LoggerProvider()],
        child: ScreenUtilInit(
          designSize: Size(375, 812),
          minTextAdapt: false,
          child: RootApp(),
        ),
      ),
    );
  }, (exception, stackTrace) async {
    if (kReleaseMode) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  });
}

class LoggerProvider extends ProviderObserver {
  const LoggerProvider();
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    Logger.log(
      '[${provider.name ?? provider.runtimeType}]',
      tag: 'didUpdateProvider',
    );
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    Logger.log(
      '[${provider.name ?? provider.runtimeType}]',
      tag: 'didAddProvider',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    Logger.log(
      '[${provider.name ?? provider.runtimeType}]',
      tag: 'didDisposeProvider',
    );
  }
}
