import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/config.dart';
import '../core/models/models.dart';
import '../core/utilities/utilities.dart';

part 'global_notifier.g.dart';

@riverpod
class AppGlobal extends _$AppGlobal {
  @override
  GlobalSetting build() => const GlobalSetting();

  void setColor(Color color) {
    state = state.copyWith(themeColor: color);
    AppTheme.primaryColor = AppTheme.findByValue(color.value);
    Preferences.setInt(AppConfig.themeColorKey, color.value);
  }
}

@riverpod
class ThemeColor extends _$ThemeColor {
  @override
  Color build() {
    return ref.watch(appGlobalProvider).themeColor ?? AppTheme.defaultColor;
  }

  void selectThemeColor(Color color) {
    state = color;
  }
}
