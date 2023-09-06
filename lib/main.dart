import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/utilities/logger.dart';
import 'core/utilities/preferences.dart';
import 'root.dart';

Future<void> initService() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Preferences.setPreferences();
  } catch (e) {
    Logger.log(e, tag: 'initService');
  }
}

void main() async {
  await initService();
  runApp(
    const ProviderScope(
      observers: [LoggerProvider()],
      child: RootApp(),
    ),
  );
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
