import '../config.dart';
import 'preferences.dart';

class AppColors {
  AppColors._();

  static Color get defaultColor => Preferences.themeColor == null
      ? supportColors.first
      : Color(Preferences.themeColor!);

  static const supportColors = <Color>[
    Color(0xff47C3BE),
    Color(0xff55BE81),
    Color(0xffFF3976),
    Color(0xffFF5D5D),
    Color(0xffEE5266),
    Color(0xff6B7CFF),
    Color(0xff40A3FF),
    Color(0xffFF8A48),
    Color(0xffFCA600),
    Color(0xffACAEB5),
    Color(0xff575F74),
    Color(0xff4F4F4F),
  ];

  static Color findByValue(int value) {
    return supportColors.firstWhere((e) => e.value == value);
  }
}
