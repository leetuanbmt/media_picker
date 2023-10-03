import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:media_kit/media_kit.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/config.dart';
import 'core/utilities/preferences.dart';
import 'firebase_options.dart';
import 'root.dart';

Future<void> initService() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    MediaKit.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Preferences.setPreferences();
  } catch (e) {
    Logger.log('initService $e', tag: 'initService');
  }
}

void main() async {
  await initService();
  runZonedGuarded(() async {
    await SentryFlutter.init(
      (options) {
        options.dsn = AppConfig.sentryDsn;
      },
    );
    runApp(
      const ProviderScope(
        // observers: [LoggerProvider()],
        child: RootApp(),
      ),
    );
  }, (exception, stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
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
      '[${provider.name ?? provider.runtimeType}] value: $newValue',
      tag: "didUpdateProvider",
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
      tag: "didAddProvider",
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    Logger.log(
      '[${provider.name ?? provider.runtimeType}]',
      tag: "didDisposeProvider",
    );
  }
}
