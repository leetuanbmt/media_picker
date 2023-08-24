import '../core/config.dart';
import '../core/models/models.dart';
import '../core/utilities/utilities.dart';

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
  ThemeColorNotifier() : super(AppTheme.defaultColor);

  void selectThemeColor(Color color) {
    state = color;
    AppTheme.primaryColor = AppTheme.findByValue(color.value);
    Preferences.setInt(AppConfig.themeColorKey, color.value);
  }
}
