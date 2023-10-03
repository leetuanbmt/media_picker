import '../config.dart';

extension NumberExtension on num {
  String get toCurrency {
    return NumberFormat().format(this);
  }

  String get toCompactCurrency {
    return NumberFormat.compact().format(this);
  }
}
