import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/utilities/logger.dart';
import 'core/utilities/preferences.dart';
import 'root.dart';

Future<void> initService() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Preferences.setPreferences();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  } catch (e) {
    Logger.log(e, tag: 'initService');
  }
}

void main() async {
  await initService();
  runApp(const ProviderScope(child: RootApp()));
}
