// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'creator_model.freezed.dart';
part 'creator_model.g.dart';

@freezed
class CreatorModel with _$CreatorModel {
  const CreatorModel._();

  const factory CreatorModel({
    required String id,
    required String email,
    required String category,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'profile_photo') required String avatar,
    @Default(false) bool isOnline,
    @Default(0) int? follow,
    @Default(0) int? followers,
    @Default(0) int? points,
    String? bio,
  }) = _CreatorModel;

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);
}
