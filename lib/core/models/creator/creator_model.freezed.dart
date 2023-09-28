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
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_photo')
  String get avatar => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;

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
      {String id,
      String email,
      String category,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'profile_photo') String avatar,
      bool isOnline});
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
    Object? category = null,
    Object? name = null,
    Object? avatar = null,
    Object? isOnline = null,
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatorModelImplCopyWith<$Res>
    implements $CreatorModelCopyWith<$Res> {
  factory _$$CreatorModelImplCopyWith(
          _$CreatorModelImpl value, $Res Function(_$CreatorModelImpl) then) =
      __$$CreatorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String category,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'profile_photo') String avatar,
      bool isOnline});
}

/// @nodoc
class __$$CreatorModelImplCopyWithImpl<$Res>
    extends _$CreatorModelCopyWithImpl<$Res, _$CreatorModelImpl>
    implements _$$CreatorModelImplCopyWith<$Res> {
  __$$CreatorModelImplCopyWithImpl(
      _$CreatorModelImpl _value, $Res Function(_$CreatorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? category = null,
    Object? name = null,
    Object? avatar = null,
    Object? isOnline = null,
  }) {
    return _then(_$CreatorModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatorModelImpl extends _CreatorModel {
  const _$CreatorModelImpl(
      {required this.id,
      required this.email,
      required this.category,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'profile_photo') required this.avatar,
      this.isOnline = false})
      : super._();

  factory _$CreatorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatorModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String category;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'profile_photo')
  final String avatar;
  @override
  @JsonKey()
  final bool isOnline;

  @override
  String toString() {
    return 'CreatorModel(id: $id, email: $email, category: $category, name: $name, avatar: $avatar, isOnline: $isOnline)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatorModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, email, category, name, avatar, isOnline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatorModelImplCopyWith<_$CreatorModelImpl> get copyWith =>
      __$$CreatorModelImplCopyWithImpl<_$CreatorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatorModelImplToJson(
      this,
    );
  }
}

abstract class _CreatorModel extends CreatorModel {
  const factory _CreatorModel(
      {required final String id,
      required final String email,
      required final String category,
      @JsonKey(name: 'name') required final String name,
      @JsonKey(name: 'profile_photo') required final String avatar,
      final bool isOnline}) = _$CreatorModelImpl;
  const _CreatorModel._() : super._();

  factory _CreatorModel.fromJson(Map<String, dynamic> json) =
      _$CreatorModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get category;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'profile_photo')
  String get avatar;
  @override
  bool get isOnline;
  @override
  @JsonKey(ignore: true)
  _$$CreatorModelImplCopyWith<_$CreatorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
