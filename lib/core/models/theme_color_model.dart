import '../config.dart';

class ThemeColor {
  final int id;
  final String colorName;
  final Color colorValue;

  const ThemeColor(
    this.id,
    this.colorName,
    this.colorValue,
  );

  static List<ThemeColor> themeColorList = const [
    ThemeColor(1, "green1", AppTheme.green1),
    ThemeColor(2, "green2", AppTheme.green2),
    ThemeColor(3, "red1", AppTheme.red1),
    ThemeColor(4, "red2", AppTheme.red2),
    ThemeColor(5, "red3", AppTheme.red3),
    ThemeColor(6, "purple", AppTheme.purple),
    ThemeColor(7, "orange", AppTheme.orange),
    ThemeColor(8, "yellow", AppTheme.yellow),
    ThemeColor(9, "grey1", AppTheme.grey1),
    ThemeColor(10, "darkGrey", AppTheme.darkGrey),
    ThemeColor(11, "grey2", AppTheme.grey2),
    ThemeColor(12, "blue", AppTheme.blue),
  ];
}
