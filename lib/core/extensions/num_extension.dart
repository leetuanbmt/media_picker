import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension NumberExtension on num {
  String get toCurrency {
    return NumberFormat().format(this);
  }

  String get toCompactCurrency {
    return NumberFormat.compact().format(this);
  }

  DateTime get date => DateTime.fromMillisecondsSinceEpoch(toInt());

  String timeAgo(context) {
    final locale = context.locale.languageCode;
    final now = DateTime.now().millisecondsSinceEpoch - toInt();
    if (DateTime.fromMillisecondsSinceEpoch(now).day > 1) {
      return DateFormat.yMMMMd(locale).add_Hm().format(date);
    }

    return timeago.format(date, locale: locale);
  }
}
