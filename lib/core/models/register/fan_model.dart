import 'dart:core';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/enum.dart';

part 'fan_model.freezed.dart';
part 'fan_model.g.dart';

@freezed
class FanModel with _$FanModel {
  const FanModel._();

  const factory FanModel({
    required int id,
    required String email,
    required String password,
    required String userName,
    required List<String> listUsage,
    required List<String> listCategory,
    @Default(UserType.fan) UserType type,
  }) = _FanModel;

  factory FanModel.fromJson(Map<String, dynamic> json) =>
      _$FanModelFromJson(json);

  static List<String> listUsages = [
    '‍🎤 配信',
    '‍📣 店舗',
  ];

  static List<String> listCategorys = [
    '🕺 ステージ',
    '🎵 音楽',
    '🔈 メディア',
    '😂 お笑い',
    '🎭 演技',
    '🎩 コスプレ',
    '📚 漫画',
    '🎮 ゲーム',
    '🤡 アニメ',
    '💅 美容',
    '⚾️ スポーツ',
    '🎨 アート',
    '👗 ファッション',
    '👥 コミュニティ',
    '🤝 チャリティ',
    '📊 経済',
    '‍🎓 教育',
  ];
}
