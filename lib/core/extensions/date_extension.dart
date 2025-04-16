import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateExt on DateTime {
  String format(String pattern) {
    return DateFormat(pattern).format(this);
  }

  String timeAgo() => timeago.format(this);
}
