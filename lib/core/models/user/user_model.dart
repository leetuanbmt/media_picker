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
    @Default(UserType.fan) UserType type,
    @Default([]) List<String> listTopic,
    @Default([]) List<String> listCategory,
    @Default(0) int followers,
    @Default(0) int follow,
    @Default(0) int points,
    @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
    DateTime? birthday,
    String? bio,
    List<FollowingModel>? following,
    @Default(false) bool isOnline,
    String? firstName,
    String? middleName,
    String? lastName,
    String? anotherName,
    String? agencyCode,
    String? phoneNumber,
    String? gender,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  int get old => birthday == null ? 0 : DateTime.now().year - birthday!.year;

  String get firstCategory => listCategory.firstOrNull ?? '';

  static UserModel get defaultUser => const UserModel(
        id: '',
        email: 'example.com',
        name: 'User Name',
        avatar: 'https://zpsocial-f49-org.zadn.vn/488ad1115de1b2bfebf0.jpg',
        type: UserType.fan,
        listTopic: [],
        listCategory: [],
        followers: 0,
        follow: 0,
        points: 0,
        bio: '',
        following: [],
        isOnline: true,
      );
}
