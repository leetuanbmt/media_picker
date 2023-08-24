// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../creator/creator_model.dart';
import 'following_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required int id,
    required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String avatar,
    List<FollowingModel>? following,
  }) = _UserModel;

  String get fullName => "$firstName $lastName";

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  static List<FollowingModel> listFollowing = const [
    FollowingModel(
      title: 'お笑い',
      listCreator: [
        CreatorModel(
          id: 1,
          firstName: 'ゆうこ',
          lastName: '',
          avatar:
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
          category: '👗ファッション',
        ),
      ],
    ),
    FollowingModel(
      title: 'お笑い',
      listCreator: [
        CreatorModel(
          id: 1,
          firstName: 'ゆうこ',
          lastName: '',
          avatar:
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
          category: '👗ファッション',
        ),
      ],
    ),
    FollowingModel(
      title: 'お笑い',
      listCreator: [
        CreatorModel(
          id: 1,
          firstName: 'ゆうこ',
          lastName: '',
          avatar:
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
          category: '👗ファッション',
        ),
      ],
    ),
  ];
}
