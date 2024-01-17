import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../core/config.dart';
import '../../l10n/l10n.dart';
part 'user_preferences_state.g.dart';

@JsonSerializable()
final class UserPreferences {
  const UserPreferences({
    required this.locale,
    required this.themeMode,
    required this.themeColor,
    required this.fontFamily,
    this.username,
    this.password,
    this.isRememberMe = false,
  });

  final String? username;
  final String? password;
  final bool isRememberMe;

  @JsonKey(
    defaultValue: UserPreferences._defaultAccentColorScheme,
    fromJson: UserPreferences._accentColorSchemeFromJson,
    toJson: UserPreferences._accentColorSchemeToJson,
    readValue: UserPreferences._accentColorSchemeReadValue,
  )
  final AppColor themeColor;

  final String fontFamily;

  @JsonKey(
    defaultValue: UserPreferences._defaultLocaleValue,
    toJson: UserPreferences._localeToJson,
    fromJson: UserPreferences._localeFromJson,
    readValue: UserPreferences._localeReadValue,
  )
  final Locale locale;

  @JsonKey(
    defaultValue: ThemeMode.system,
    unknownEnumValue: ThemeMode.system,
  )
  final ThemeMode themeMode;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);

  static Locale _defaultLocaleValue() => L10n.all.first;

  static Locale _localeFromJson(Map<String, dynamic> json) {
    return Locale(json['languageCode'], json['countryCode']);
  }

  static Map<String, dynamic> _localeToJson(Locale locale) {
    return {
      'languageCode': locale.languageCode,
      'countryCode': locale.countryCode,
    };
  }

  static Map<String, dynamic>? _localeReadValue(
      Map<dynamic, dynamic> json, String key) {
    if (json[key] is String) {
      final map = jsonDecode(json[key]);
      return {
        'languageCode': map['lc'],
        'countryCode': map['cc'],
      };
    }

    return json[key] as Map<String, dynamic>?;
  }

  static AppColor _accentColorSchemeFromJson(Map<String, dynamic> json) {
    return AppColor.fromString(json['color']);
  }

  static Map<String, dynamic>? _accentColorSchemeReadValue(
      Map<dynamic, dynamic> json, String key) {
    if (json[key] is String) {
      return {'color': json[key]};
    }

    return json[key] as Map<String, dynamic>?;
  }

  static Map<String, dynamic> _accentColorSchemeToJson(AppColor color) {
    return {'color': color.toString()};
  }

  static AppColor _defaultAccentColorScheme() => AppTheme.supportColors.first;

  UserPreferences copyWith({
    Locale? locale,
    AppColor? themeColor,
    String? fontFamily,
    ThemeMode? themeMode,
    String? username,
    String? password,
    bool? isRememberMe,
  }) {
    return UserPreferences(
      locale: locale ?? this.locale,
      themeColor: themeColor ?? this.themeColor,
      fontFamily: fontFamily ?? this.fontFamily,
      themeMode: themeMode ?? this.themeMode,
      username: username ?? this.username,
      password: password ?? this.password,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }

  factory UserPreferences.withDefaults() {
    return UserPreferences(
      locale: _defaultLocaleValue(),
      themeColor: _defaultAccentColorScheme(),
      fontFamily: 'Roboto',
      themeMode: ThemeMode.system,
    );
  }
}
