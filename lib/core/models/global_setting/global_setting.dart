import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_setting.freezed.dart';

@freezed
class GlobalSetting with _$GlobalSetting {
  const factory GlobalSetting({
    Color? themeColor,
    String? fontFamily,
    String? languageCode,
  }) = _GlobalSetting;
}
