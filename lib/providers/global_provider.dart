import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/config.dart';
import '../core/models/models.dart';
import '../core/repositories/base_repository.dart';
import '../core/utilities/utilities.dart';

part 'global_provider.g.dart';

final appProvider = Provider((ref) => AppRepositoriesImpl());

@riverpod
class AppGlobal extends _$AppGlobal {
  @override
  GlobalSetting build() => const GlobalSetting();

  void setColor(Color color) {
    state = state.copyWith(themeColor: color);
    AppTheme.primaryColor = color;
    Preferences.setInt(AppConfig.themeColorKey, color.value);
  }
}

final colorProvider = StateProvider.autoDispose<Color>(
  (ref) => ref.read(appGlobalProvider).themeColor ?? AppTheme.defaultColor,
);
