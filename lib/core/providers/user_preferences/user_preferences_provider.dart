import 'dart:async';

import '../../config.dart';
import '../../utilities/preferences/preferences.dart';
import 'user_preferences_state.dart';

final userPreferencesProvider =
    StateNotifierProvider<UserPreferencesNotifier, UserPreferences>(
  (ref) => UserPreferencesNotifier(),
);

class UserPreferencesNotifier extends PersistedStateNotifier<UserPreferences> {
  UserPreferencesNotifier()
      : super(
          UserPreferences.withDefaults(),
          'preferences',
          encrypted: true,
        );

  void setLocale(Locale locale) {
    state = state.copyWith(locale: locale);
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void setThemeColor(AppColor color) {
    state = state.copyWith(themeColor: color);
  }

  void reset() {
    state = UserPreferences.withDefaults();
  }

  void saveAccount(
    String username,
    String password,
    bool isRememberMe,
  ) {
    state = state.copyWith(
      isRememberMe: isRememberMe,
      username: username,
      password: password,
    );
  }

  @override
  FutureOr<UserPreferences> fromJson(Map<String, dynamic> json) {
    return UserPreferences.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => state.toJson();
}
