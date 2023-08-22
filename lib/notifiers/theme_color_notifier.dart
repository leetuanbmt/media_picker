import '../core/config.dart';
import '../core/utilities/preferences.dart';

class ThemeColorNotifier extends StateNotifier<int> {
  ThemeColorNotifier() : super(Preferences.themeColor ?? 0);

  void selectThemeColor(int colorIndex) {
    state = colorIndex;
    AppTheme.primaryColor = ThemeColor.themeColorList
        .firstWhere((element) => element.id == colorIndex)
        .colorValue;
  }
}

final selectedThemeColor = StateNotifierProvider<ThemeColorNotifier, int>(
  (_) => ThemeColorNotifier(),
);
