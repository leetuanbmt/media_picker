import '../config.dart';

class AppColor {
  AppColor._();
  static const green1 = Color(0xff47C3BE);
  static const green2 = Color(0xff55BE81);
  static const red1 = Color(0xffFF3976);
  static const red2 = Color(0xffFF5D5D);
  static const red3 = Color(0xffEE5266);
  static const purple = Color(0xff6B7CFF);
  static const blue = Color(0xff40A3FF);
  static const orange = Color(0xffFF8A48);
  static const yellow = Color(0xffFCA600);
  static const grey1 = Color(0xffACAEB5);
  static const darkGrey = Color(0xff575F74);
  static const grey2 = Color(0xff4F4F4F);

  static Color defaultColor = green1;
  static final supportColors = <Color>[
    green1,
    green2,
    red1,
    red2,
    red3,
    purple,
    blue,
    orange,
    yellow,
    grey1,
    darkGrey,
    grey2,
  ];
}
