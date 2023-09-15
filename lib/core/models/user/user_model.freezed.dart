// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_photo')
  String get avatar => throw _privateConstructorUsedError;
  int get followers => throw _privateConstructorUsedError;
  int get follow => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
  DateTime? get birthday => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  List<FollowingModel>? get following => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String email,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'profile_photo') String avatar,
      int followers,
      int follow,
      int points,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      DateTime? birthday,
      String? bio,
      List<FollowingModel>? following});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? avatar = null,
    Object? followers = null,
    Object? follow = null,
    Object? points = null,
    Object? birthday = freezed,
    Object? bio = freezed,
    Object? following = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as int,
      follow: null == follow
          ? _value.follow
          : follow // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      following: freezed == following
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as List<FollowingModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'profile_photo') String avatar,
      int followers,
      int follow,
      int points,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      DateTime? birthday,
      String? bio,
      List<FollowingModel>? following});
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$_UserModel>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? avatar = null,
    Object? followers = null,
    Object? follow = null,
    Object? points = null,
    Object? birthday = freezed,
    Object? bio = freezed,
    Object? following = freezed,
  }) {
    return _then(_$_UserModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as int,
      follow: null == follow
          ? _value.follow
          : follow // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      following: freezed == following
          ? _value._following
          : following // ignore: cast_nullable_to_non_nullable
              as List<FollowingModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel extends _UserModel {
  const _$_UserModel(
      {required this.id,
      required this.email,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'profile_photo') required this.avatar,
      this.followers = 0,
      this.follow = 0,
      this.points = 0,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      this.birthday,
      this.bio,
      final List<FollowingModel>? following})
      : _following = following,
        super._();

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'profile_photo')
  final String avatar;
  @override
  @JsonKey()
  final int followers;
  @override
  @JsonKey()
  final int follow;
  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
  final DateTime? birthday;
  @override
  final String? bio;
  final List<FollowingModel>? _following;
  @override
  List<FollowingModel>? get following {
    final value = _following;
    if (value == null) return null;
    if (_following is EqualUnmodifiableListView) return _following;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, avatar: $avatar, followers: $followers, follow: $follow, points: $points, birthday: $birthday, bio: $bio, following: $following)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.followers, followers) ||
                other.followers == followers) &&
            (identical(other.follow, follow) || other.follow == follow) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality()
                .equals(other._following, _following));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      name,
      avatar,
      followers,
      follow,
      points,
      birthday,
      bio,
      const DeepCollectionEquality().hash(_following));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel(
      {required final String id,
      required final String email,
      @JsonKey(name: 'name') required final String name,
      @JsonKey(name: 'profile_photo') required final String avatar,
      final int followers,
      final int follow,
      final int points,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      final DateTime? birthday,
      final String? bio,
      final List<FollowingModel>? following}) = _$_UserModel;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'profile_photo')
  String get avatar;
  @override
  int get followers;
  @override
  int get follow;
  @override
  int get points;
  @override
  @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
  DateTime? get birthday;
  @override
  String? get bio;
  @override
  List<FollowingModel>? get following;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
