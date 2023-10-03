import 'package:freezed_annotation/freezed_annotation.dart';

import '../creator/creator_model.dart';
part 'following_model.freezed.dart';
part 'following_model.g.dart';

@freezed
class FollowingModel with _$FollowingModel {
  const FollowingModel._();

  const factory FollowingModel({
    required String title,
    required List<CreatorModel> listCreator,
  }) = _FollowingModel;

  factory FollowingModel.fromJson(Map<String, dynamic> json) =>
      _$FollowingModelFromJson(json);
}
