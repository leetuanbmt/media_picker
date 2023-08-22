import 'core/config.dart';
import 'core/models/theme_color_bloc.dart';

class ThemeColorState extends StateNotifier<int> {
  ThemeColorState() : super(0);

  void selectThemeColor(int colorIndex) {
    state = colorIndex;
    AppTheme.primaryColor = ThemeColor.themeColorList
        .firstWhere((element) => element.id == colorIndex)
        .colorValue;
  }
}

final selectedThemeColor = StateNotifierProvider<ThemeColorState, int>(
  (_) => ThemeColorState(),
);
