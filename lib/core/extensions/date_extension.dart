import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String format(String pattern) {
    return DateFormat(pattern).format(this);
  }
}
