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
  UserType get type => throw _privateConstructorUsedError;
  List<String> get listTopic => throw _privateConstructorUsedError;
  List<String> get listCategory => throw _privateConstructorUsedError;
  int get followers => throw _privateConstructorUsedError;
  int get follow => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
  DateTime? get birthday => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  List<FollowingModel>? get following => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get middleName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get anotherName => throw _privateConstructorUsedError;
  String? get agencyCode => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;

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
      UserType type,
      List<String> listTopic,
      List<String> listCategory,
      int followers,
      int follow,
      int points,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      DateTime? birthday,
      String? bio,
      List<FollowingModel>? following,
      bool isOnline,
      String? firstName,
      String? middleName,
      String? lastName,
      String? anotherName,
      String? agencyCode,
      String? phoneNumber,
      String? gender});
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
    Object? type = null,
    Object? listTopic = null,
    Object? listCategory = null,
    Object? followers = null,
    Object? follow = null,
    Object? points = null,
    Object? birthday = freezed,
    Object? bio = freezed,
    Object? following = freezed,
    Object? isOnline = null,
    Object? firstName = freezed,
    Object? middleName = freezed,
    Object? lastName = freezed,
    Object? anotherName = freezed,
    Object? agencyCode = freezed,
    Object? phoneNumber = freezed,
    Object? gender = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
      listTopic: null == listTopic
          ? _value.listTopic
          : listTopic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listCategory: null == listCategory
          ? _value.listCategory
          : listCategory // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      middleName: freezed == middleName
          ? _value.middleName
          : middleName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      anotherName: freezed == anotherName
          ? _value.anotherName
          : anotherName // ignore: cast_nullable_to_non_nullable
              as String?,
      agencyCode: freezed == agencyCode
          ? _value.agencyCode
          : agencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'profile_photo') String avatar,
      UserType type,
      List<String> listTopic,
      List<String> listCategory,
      int followers,
      int follow,
      int points,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      DateTime? birthday,
      String? bio,
      List<FollowingModel>? following,
      bool isOnline,
      String? firstName,
      String? middleName,
      String? lastName,
      String? anotherName,
      String? agencyCode,
      String? phoneNumber,
      String? gender});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? avatar = null,
    Object? type = null,
    Object? listTopic = null,
    Object? listCategory = null,
    Object? followers = null,
    Object? follow = null,
    Object? points = null,
    Object? birthday = freezed,
    Object? bio = freezed,
    Object? following = freezed,
    Object? isOnline = null,
    Object? firstName = freezed,
    Object? middleName = freezed,
    Object? lastName = freezed,
    Object? anotherName = freezed,
    Object? agencyCode = freezed,
    Object? phoneNumber = freezed,
    Object? gender = freezed,
  }) {
    return _then(_$UserModelImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
      listTopic: null == listTopic
          ? _value._listTopic
          : listTopic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listCategory: null == listCategory
          ? _value._listCategory
          : listCategory // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      middleName: freezed == middleName
          ? _value.middleName
          : middleName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      anotherName: freezed == anotherName
          ? _value.anotherName
          : anotherName // ignore: cast_nullable_to_non_nullable
              as String?,
      agencyCode: freezed == agencyCode
          ? _value.agencyCode
          : agencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl extends _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.email,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'profile_photo') required this.avatar,
      required this.type,
      required final List<String> listTopic,
      required final List<String> listCategory,
      this.followers = 0,
      this.follow = 0,
      this.points = 0,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      this.birthday,
      this.bio,
      final List<FollowingModel>? following,
      this.isOnline = false,
      this.firstName,
      this.middleName,
      this.lastName,
      this.anotherName,
      this.agencyCode,
      this.phoneNumber,
      this.gender})
      : _listTopic = listTopic,
        _listCategory = listCategory,
        _following = following,
        super._();

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

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
  final UserType type;
  final List<String> _listTopic;
  @override
  List<String> get listTopic {
    if (_listTopic is EqualUnmodifiableListView) return _listTopic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listTopic);
  }

  final List<String> _listCategory;
  @override
  List<String> get listCategory {
    if (_listCategory is EqualUnmodifiableListView) return _listCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listCategory);
  }

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
  @JsonKey()
  final bool isOnline;
  @override
  final String? firstName;
  @override
  final String? middleName;
  @override
  final String? lastName;
  @override
  final String? anotherName;
  @override
  final String? agencyCode;
  @override
  final String? phoneNumber;
  @override
  final String? gender;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, avatar: $avatar, type: $type, listTopic: $listTopic, listCategory: $listCategory, followers: $followers, follow: $follow, points: $points, birthday: $birthday, bio: $bio, following: $following, isOnline: $isOnline, firstName: $firstName, middleName: $middleName, lastName: $lastName, anotherName: $anotherName, agencyCode: $agencyCode, phoneNumber: $phoneNumber, gender: $gender)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._listTopic, _listTopic) &&
            const DeepCollectionEquality()
                .equals(other._listCategory, _listCategory) &&
            (identical(other.followers, followers) ||
                other.followers == followers) &&
            (identical(other.follow, follow) || other.follow == follow) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality()
                .equals(other._following, _following) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.middleName, middleName) ||
                other.middleName == middleName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.anotherName, anotherName) ||
                other.anotherName == anotherName) &&
            (identical(other.agencyCode, agencyCode) ||
                other.agencyCode == agencyCode) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        email,
        name,
        avatar,
        type,
        const DeepCollectionEquality().hash(_listTopic),
        const DeepCollectionEquality().hash(_listCategory),
        followers,
        follow,
        points,
        birthday,
        bio,
        const DeepCollectionEquality().hash(_following),
        isOnline,
        firstName,
        middleName,
        lastName,
        anotherName,
        agencyCode,
        phoneNumber,
        gender
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
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
      required final UserType type,
      required final List<String> listTopic,
      required final List<String> listCategory,
      final int followers,
      final int follow,
      final int points,
      @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
      final DateTime? birthday,
      final String? bio,
      final List<FollowingModel>? following,
      final bool isOnline,
      final String? firstName,
      final String? middleName,
      final String? lastName,
      final String? anotherName,
      final String? agencyCode,
      final String? phoneNumber,
      final String? gender}) = _$UserModelImpl;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

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
  UserType get type;
  @override
  List<String> get listTopic;
  @override
  List<String> get listCategory;
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
  bool get isOnline;
  @override
  String? get firstName;
  @override
  String? get middleName;
  @override
  String? get lastName;
  @override
  String? get anotherName;
  @override
  String? get agencyCode;
  @override
  String? get phoneNumber;
  @override
  String? get gender;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
