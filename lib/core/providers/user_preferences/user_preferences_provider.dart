import 'dart:async';

import '../../config.dart';
import '../../utilities/preferences/preferences.dart';
import 'user_preferences_state.dart';

class UserPreferencesNotifier extends PersistedStateNotifier<UserPreferences> {
  static final provider = StateNotifierProvider.autoDispose<
      UserPreferencesNotifier, UserPreferences>((ref) {
    return UserPreferencesNotifier();
  });

  static Refreshable<UserPreferencesNotifier> get notifier => provider.notifier;

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
