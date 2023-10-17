import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../config.dart';
import '../utilities/utilities.dart';

extension NumberExtension on num {
  String get toCurrency {
    return NumberFormat().format(this);
  }

  String get toCompactCurrency {
    return NumberFormat.compact().format(this);
  }

  DateTime get date => DateTime.fromMillisecondsSinceEpoch(toInt());

  String get timeAgo {
    final locale = Preferences.getString('language') ?? 'en';
    final now = DateTime.now().millisecondsSinceEpoch - toInt();
    if (DateTime.fromMillisecondsSinceEpoch(now).day > 1) {
      // return DateFormat('MM/dd/yyyy', locale).format(date);
      return DateFormat.yMMMMd(locale).add_Hm().format(date);
    }

    return timeago.format(date, locale: locale);
  }
}
