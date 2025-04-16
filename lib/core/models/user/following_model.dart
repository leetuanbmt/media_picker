import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';
part 'following_model.freezed.dart';
part 'following_model.g.dart';

@freezed
class FollowingModel with _$FollowingModel {
  const FollowingModel._();

  const factory FollowingModel({
    required String title,
    required List<UserModel> users,
  }) = _FollowingModel;

  factory FollowingModel.fromJson(Map<String, dynamic> json) =>
      _$FollowingModelFromJson(json);
}
