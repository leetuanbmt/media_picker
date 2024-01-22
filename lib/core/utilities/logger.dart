import 'dart:convert';
import 'dart:developer' as dev;

import '../config.dart';

class Logger {
  Logger._();
  static void log(dynamic msg, {String tag = AppConfigs.title}) {
    try {
      dev.log(jsonEncode(msg), name: tag);
    } catch (e) {
      dev.log('$msg', name: tag);
    }
  }
}
