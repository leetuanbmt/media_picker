import 'package:flutter/foundation.dart';

import '../config.dart';

class Logger {
  Logger._();
  static void log(dynamic msg, {String? tag}) {
    if (kDebugMode) {
      Vx.log("$tag: $msg");
    }
  }
}
