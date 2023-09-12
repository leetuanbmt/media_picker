// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'creator_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreatorModel _$CreatorModelFromJson(Map<String, dynamic> json) {
  return _CreatorModel.fromJson(json);
}

/// @nodoc
mixin _$CreatorModel {
  int get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'sur_name')
  String get surName => throw _privateConstructorUsedError;
  @JsonKey(name: 'middle_name')
  String get middleName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;
  String get birthDay => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  List<String> get listUsage => throw _privateConstructorUsedError;
  List<String> get listCategory => throw _privateConstructorUsedError;
  String? get agencyCode => throw _privateConstructorUsedError;
  String? get anotherName => throw _privateConstructorUsedError;
  UserType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatorModelCopyWith<CreatorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatorModelCopyWith<$Res> {
  factory $CreatorModelCopyWith(
          CreatorModel value, $Res Function(CreatorModel) then) =
      _$CreatorModelCopyWithImpl<$Res, CreatorModel>;
  @useResult
  $Res call(
      {int id,
      String email,
      String password,
      @JsonKey(name: 'sur_name') String surName,
      @JsonKey(name: 'middle_name') String middleName,
      @JsonKey(name: 'last_name') String lastName,
      String birthDay,
      String gender,
      String phoneNumber,
      List<String> listUsage,
      List<String> listCategory,
      String? agencyCode,
      String? anotherName,
      UserType type});
}

/// @nodoc
class _$CreatorModelCopyWithImpl<$Res, $Val extends CreatorModel>
    implements $CreatorModelCopyWith<$Res> {
  _$CreatorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? password = null,
    Object? surName = null,
    Object? middleName = null,
    Object? lastName = null,
    Object? birthDay = null,
    Object? gender = null,
    Object? phoneNumber = null,
    Object? listUsage = null,
    Object? listCategory = null,
    Object? agencyCode = freezed,
    Object? anotherName = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      surName: null == surName
          ? _value.surName
          : surName // ignore: cast_nullable_to_non_nullable
              as String,
      middleName: null == middleName
          ? _value.middleName
          : middleName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      birthDay: null == birthDay
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      listUsage: null == listUsage
          ? _value.listUsage
          : listUsage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listCategory: null == listCategory
          ? _value.listCategory
          : listCategory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      agencyCode: freezed == agencyCode
          ? _value.agencyCode
          : agencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      anotherName: freezed == anotherName
          ? _value.anotherName
          : anotherName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreatorModelCopyWith<$Res>
    implements $CreatorModelCopyWith<$Res> {
  factory _$$_CreatorModelCopyWith(
          _$_CreatorModel value, $Res Function(_$_CreatorModel) then) =
      __$$_CreatorModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String email,
      String password,
      @JsonKey(name: 'sur_name') String surName,
      @JsonKey(name: 'middle_name') String middleName,
      @JsonKey(name: 'last_name') String lastName,
      String birthDay,
      String gender,
      String phoneNumber,
      List<String> listUsage,
      List<String> listCategory,
      String? agencyCode,
      String? anotherName,
      UserType type});
}

/// @nodoc
class __$$_CreatorModelCopyWithImpl<$Res>
    extends _$CreatorModelCopyWithImpl<$Res, _$_CreatorModel>
    implements _$$_CreatorModelCopyWith<$Res> {
  __$$_CreatorModelCopyWithImpl(
      _$_CreatorModel _value, $Res Function(_$_CreatorModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? password = null,
    Object? surName = null,
    Object? middleName = null,
    Object? lastName = null,
    Object? birthDay = null,
    Object? gender = null,
    Object? phoneNumber = null,
    Object? listUsage = null,
    Object? listCategory = null,
    Object? agencyCode = freezed,
    Object? anotherName = freezed,
    Object? type = null,
  }) {
    return _then(_$_CreatorModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      surName: null == surName
          ? _value.surName
          : surName // ignore: cast_nullable_to_non_nullable
              as String,
      middleName: null == middleName
          ? _value.middleName
          : middleName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      birthDay: null == birthDay
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      listUsage: null == listUsage
          ? _value._listUsage
          : listUsage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listCategory: null == listCategory
          ? _value._listCategory
          : listCategory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      agencyCode: freezed == agencyCode
          ? _value.agencyCode
          : agencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      anotherName: freezed == anotherName
          ? _value.anotherName
          : anotherName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreatorModel extends _CreatorModel {
  const _$_CreatorModel(
      {required this.id,
      required this.email,
      required this.password,
      @JsonKey(name: 'sur_name') required this.surName,
      @JsonKey(name: 'middle_name') required this.middleName,
      @JsonKey(name: 'last_name') required this.lastName,
      required this.birthDay,
      required this.gender,
      required this.phoneNumber,
      required final List<String> listUsage,
      required final List<String> listCategory,
      this.agencyCode,
      this.anotherName,
      this.type = UserType.creator})
      : _listUsage = listUsage,
        _listCategory = listCategory,
        super._();

  factory _$_CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$$_CreatorModelFromJson(json);

  @override
  final int id;
  @override
  final String email;
  @override
  final String password;
  @override
  @JsonKey(name: 'sur_name')
  final String surName;
  @override
  @JsonKey(name: 'middle_name')
  final String middleName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
  @override
  final String birthDay;
  @override
  final String gender;
  @override
  final String phoneNumber;
  final List<String> _listUsage;
  @override
  List<String> get listUsage {
    if (_listUsage is EqualUnmodifiableListView) return _listUsage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listUsage);
  }

  final List<String> _listCategory;
  @override
  List<String> get listCategory {
    if (_listCategory is EqualUnmodifiableListView) return _listCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listCategory);
  }

  @override
  final String? agencyCode;
  @override
  final String? anotherName;
  @override
  @JsonKey()
  final UserType type;

  @override
  String toString() {
    return 'CreatorModel(id: $id, email: $email, password: $password, surName: $surName, middleName: $middleName, lastName: $lastName, birthDay: $birthDay, gender: $gender, phoneNumber: $phoneNumber, listUsage: $listUsage, listCategory: $listCategory, agencyCode: $agencyCode, anotherName: $anotherName, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreatorModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.surName, surName) || other.surName == surName) &&
            (identical(other.middleName, middleName) ||
                other.middleName == middleName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.birthDay, birthDay) ||
                other.birthDay == birthDay) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            const DeepCollectionEquality()
                .equals(other._listUsage, _listUsage) &&
            const DeepCollectionEquality()
                .equals(other._listCategory, _listCategory) &&
            (identical(other.agencyCode, agencyCode) ||
                other.agencyCode == agencyCode) &&
            (identical(other.anotherName, anotherName) ||
                other.anotherName == anotherName) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      password,
      surName,
      middleName,
      lastName,
      birthDay,
      gender,
      phoneNumber,
      const DeepCollectionEquality().hash(_listUsage),
      const DeepCollectionEquality().hash(_listCategory),
      agencyCode,
      anotherName,
      type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreatorModelCopyWith<_$_CreatorModel> get copyWith =>
      __$$_CreatorModelCopyWithImpl<_$_CreatorModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatorModelToJson(
      this,
    );
  }
}

abstract class _CreatorModel extends CreatorModel {
  const factory _CreatorModel(
      {required final int id,
      required final String email,
      required final String password,
      @JsonKey(name: 'sur_name') required final String surName,
      @JsonKey(name: 'middle_name') required final String middleName,
      @JsonKey(name: 'last_name') required final String lastName,
      required final String birthDay,
      required final String gender,
      required final String phoneNumber,
      required final List<String> listUsage,
      required final List<String> listCategory,
      final String? agencyCode,
      final String? anotherName,
      final UserType type}) = _$_CreatorModel;
  const _CreatorModel._() : super._();

  factory _CreatorModel.fromJson(Map<String, dynamic> json) =
      _$_CreatorModel.fromJson;

  @override
  int get id;
  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(name: 'sur_name')
  String get surName;
  @override
  @JsonKey(name: 'middle_name')
  String get middleName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  String get birthDay;
  @override
  String get gender;
  @override
  String get phoneNumber;
  @override
  List<String> get listUsage;
  @override
  List<String> get listCategory;
  @override
  String? get agencyCode;
  @override
  String? get anotherName;
  @override
  UserType get type;
  @override
  @JsonKey(ignore: true)
  _$$_CreatorModelCopyWith<_$_CreatorModel> get copyWith =>
      throw _privateConstructorUsedError;
}
