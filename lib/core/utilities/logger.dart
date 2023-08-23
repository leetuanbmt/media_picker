import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

import '../config.dart';

class Logger {
  Logger._();
  static void log(dynamic msg, {String? tag}) {
    if (kDebugMode) {
      developer.log(
        msg.toString(),
        name: tag ?? AppConfig.title,
      );
    }
  }
}
