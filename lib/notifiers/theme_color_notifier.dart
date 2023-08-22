import '../core/config.dart';
import '../core/utilities/preferences.dart';

final selectedThemeColor = StateNotifierProvider<ThemeColorNotifier, int>(
  (_) => ThemeColorNotifier(),
);

class ThemeColorNotifier extends StateNotifier<int> {
  ThemeColorNotifier() : super(Preferences.themeColor ?? 1);

  void selectThemeColor(int colorIndex) {
    state = colorIndex;
    AppTheme.primaryColor = ThemeColor.themeColorList
        .firstWhere((element) => element.id == colorIndex)
        .colorValue;
  }
}
