// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FanModel _$FanModelFromJson(Map<String, dynamic> json) {
  return _FanModel.fromJson(json);
}

/// @nodoc
mixin _$FanModel {
  int get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  List<String> get listUsage => throw _privateConstructorUsedError;
  List<String> get listCategory => throw _privateConstructorUsedError;
  UserType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FanModelCopyWith<FanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FanModelCopyWith<$Res> {
  factory $FanModelCopyWith(FanModel value, $Res Function(FanModel) then) =
      _$FanModelCopyWithImpl<$Res, FanModel>;
  @useResult
  $Res call(
      {int id,
      String email,
      String password,
      String userName,
      List<String> listUsage,
      List<String> listCategory,
      UserType type});
}

/// @nodoc
class _$FanModelCopyWithImpl<$Res, $Val extends FanModel>
    implements $FanModelCopyWith<$Res> {
  _$FanModelCopyWithImpl(this._value, this._then);

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
    Object? userName = null,
    Object? listUsage = null,
    Object? listCategory = null,
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
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      listUsage: null == listUsage
          ? _value.listUsage
          : listUsage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listCategory: null == listCategory
          ? _value.listCategory
          : listCategory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FanModelCopyWith<$Res> implements $FanModelCopyWith<$Res> {
  factory _$$_FanModelCopyWith(
          _$_FanModel value, $Res Function(_$_FanModel) then) =
      __$$_FanModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String email,
      String password,
      String userName,
      List<String> listUsage,
      List<String> listCategory,
      UserType type});
}

/// @nodoc
class __$$_FanModelCopyWithImpl<$Res>
    extends _$FanModelCopyWithImpl<$Res, _$_FanModel>
    implements _$$_FanModelCopyWith<$Res> {
  __$$_FanModelCopyWithImpl(
      _$_FanModel _value, $Res Function(_$_FanModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? password = null,
    Object? userName = null,
    Object? listUsage = null,
    Object? listCategory = null,
    Object? type = null,
  }) {
    return _then(_$_FanModel(
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
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      listUsage: null == listUsage
          ? _value._listUsage
          : listUsage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listCategory: null == listCategory
          ? _value._listCategory
          : listCategory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UserType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FanModel extends _FanModel {
  const _$_FanModel(
      {required this.id,
      required this.email,
      required this.password,
      required this.userName,
      required final List<String> listUsage,
      required final List<String> listCategory,
      this.type = UserType.fan})
      : _listUsage = listUsage,
        _listCategory = listCategory,
        super._();

  factory _$_FanModel.fromJson(Map<String, dynamic> json) =>
      _$$_FanModelFromJson(json);

  @override
  final int id;
  @override
  final String email;
  @override
  final String password;
  @override
  final String userName;
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
  @JsonKey()
  final UserType type;

  @override
  String toString() {
    return 'FanModel(id: $id, email: $email, password: $password, userName: $userName, listUsage: $listUsage, listCategory: $listCategory, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FanModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            const DeepCollectionEquality()
                .equals(other._listUsage, _listUsage) &&
            const DeepCollectionEquality()
                .equals(other._listCategory, _listCategory) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      password,
      userName,
      const DeepCollectionEquality().hash(_listUsage),
      const DeepCollectionEquality().hash(_listCategory),
      type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FanModelCopyWith<_$_FanModel> get copyWith =>
      __$$_FanModelCopyWithImpl<_$_FanModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FanModelToJson(
      this,
    );
  }
}

abstract class _FanModel extends FanModel {
  const factory _FanModel(
      {required final int id,
      required final String email,
      required final String password,
      required final String userName,
      required final List<String> listUsage,
      required final List<String> listCategory,
      final UserType type}) = _$_FanModel;
  const _FanModel._() : super._();

  factory _FanModel.fromJson(Map<String, dynamic> json) = _$_FanModel.fromJson;

  @override
  int get id;
  @override
  String get email;
  @override
  String get password;
  @override
  String get userName;
  @override
  List<String> get listUsage;
  @override
  List<String> get listCategory;
  @override
  UserType get type;
  @override
  @JsonKey(ignore: true)
  _$$_FanModelCopyWith<_$_FanModel> get copyWith =>
      throw _privateConstructorUsedError;
}
