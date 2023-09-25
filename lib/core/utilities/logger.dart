import 'package:flutter/foundation.dart';
import '../config.dart';

class Logger {
  Logger._();
  static void log(dynamic msg, {String tag = AppConfig.title}) {
    if (kDebugMode) {
      Vx.log("$tag: $msg");
    }
  }
}
