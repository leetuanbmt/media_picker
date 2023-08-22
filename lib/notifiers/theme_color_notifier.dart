import '../core/config.dart';
import '../core/utilities/preferences.dart';
import '../core/utilities/theme_color.dart';

final selectedThemeColor = StateNotifierProvider<ThemeColorNotifier, String>(
  (_) => ThemeColorNotifier(),
);

class ThemeColorNotifier extends StateNotifier<String> {
  ThemeColorNotifier() : super((Preferences.themeColor ?? 'ff47C3BE'));

  void selectThemeColor(String color) {
    state = color;
    AppTheme.primaryColor =
        AppColor.supportColors.firstWhere((e) => e == Vx.hexToColor(color));
  }
}
