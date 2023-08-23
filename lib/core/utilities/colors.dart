import '../config.dart';
import 'preferences.dart';

class AppColors {
  AppColors._();

  static Color get defaultColor => Preferences.themeColor == null
      ? supportColors.first
      : Color(Preferences.themeColor!);

  static const blackBold = Color(0xff332C2C);

  static const fontGrayLead = Color(0xff646464);

  static const fontGreen = Color(0xff00BAB3);

  static const purple = Color(0xff6B7CFF);

  static const fontGray = Color(0xff95A8B5);

  static const lightGray = Color(0xffF2F2F5);

  static const black = Color(0xff211A1A);

  static const box = Color(0xffD4D4D4);

  static const boxFont = Color(0xffAFAFAF);

  static const fontBoldLight = Color(0xff565656);

  static const middleGray = Color(0xffC0C8CD);

  static const perlGreen = Color(0xffF1F8F7);

  static const icon = Color(0xffBDBDBD);

  static const background = Color(0xffF9FBFB);

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
