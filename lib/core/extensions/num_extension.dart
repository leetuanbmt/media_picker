import 'package:flutter/widgets.dart';
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

  String timeAgo(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final now = DateTime.now().millisecondsSinceEpoch - toInt();
    if (DateTime.fromMillisecondsSinceEpoch(now).day > 1) {
      return DateFormat.yMMMMd(locale.languageCode).add_Hm().format(date);
    }
    return timeago.format(date, locale: locale.languageCode);
  }
}
