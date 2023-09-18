import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utilities/utilities.dart';
import 'following_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String email,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'profile_photo') required String avatar,
    @Default(0) int followers,
    @Default(0) int follow,
    @Default(0) int points,
    @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
    DateTime? birthday,
    String? bio,
    List<FollowingModel>? following,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  int get old => DateTime.now().year - birthday!.year;

  static List<String> listCategory = const [
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
    '‍🎤 配信',
    '‍📣 店舗',
  ];
}
