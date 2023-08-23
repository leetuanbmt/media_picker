import '../core/config.dart';
import '../core/models/global_setting/global_setting.dart';
import '../core/utilities/preferences.dart';
import '../core/utilities/theme_color.dart';

final appGlobalNotifier =
    StateNotifierProvider<AppGlobalNotifier, GlobalSetting>(
  (_) => AppGlobalNotifier(),
);

class AppGlobalNotifier extends StateNotifier<GlobalSetting> {
  AppGlobalNotifier() : super(const GlobalSetting());

  void setColor(Color color) {
    state = state.copyWith(themeColor: color);
  }
}

final selectedThemeColor = StateNotifierProvider<ThemeColorNotifier, Color>(
  (_) => ThemeColorNotifier(),
);

class ThemeColorNotifier extends StateNotifier<Color> {
  ThemeColorNotifier() : super(Color((Preferences.themeColor ?? 0xFF000000)));

  void selectThemeColor(Color color) {
    state = color;
    AppTheme.primaryColor =
        AppColor.supportColors.firstWhere((e) => e == state);
    Preferences.setInt(
      'themeColor',
      color.value,
    );
  }
}
