// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'creator_model.freezed.dart';
part 'creator_model.g.dart';

@freezed
class CreatorModel with _$CreatorModel {
  const CreatorModel._();

  const factory CreatorModel({
    required int id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String avatar,
    required String category,
  }) = _CreatorModel;

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);
}
