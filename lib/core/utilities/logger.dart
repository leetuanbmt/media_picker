import 'dart:developer' as dev;
import '../config.dart';

class Logger {
  Logger._();
  static void log(dynamic msg, {String tag = AppConfig.title}) {
    dev.log('$tag: $msg');
  }
}
