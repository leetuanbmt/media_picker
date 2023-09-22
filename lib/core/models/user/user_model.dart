import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utilities/utilities.dart';
import '../enum/enum.dart';
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
    required UserType type,
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

  int get old => birthday == null ? 0 : DateTime.now().year - birthday!.year;
}
