import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';

part 'creator_model.freezed.dart';
part 'creator_model.g.dart';

@freezed
class CreatorModel with _$CreatorModel {
  const CreatorModel._();

  const factory CreatorModel({
    required int id,
    required String email,
    required String password,
    @JsonKey(name: 'sur_name') required String surName,
    @JsonKey(name: 'middle_name') required String middleName,
    @JsonKey(name: 'last_name') required String lastName,
    required String birthDay,
    required String gender,
    required String phoneNumber,
    required List<String> listUsage,
    required List<String> listCategory,
    String? agencyCode,
    String? anotherName,
    @Default(UserType.creator) UserType type,
  }) = _CreatorModel;

  String get fulName => "$surName $middleName $lastName";

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);
}
