import '../config.dart';

extension NumberExtension on num {
  String get toCurrency {
    return NumberFormat().format(this);
  }
}
