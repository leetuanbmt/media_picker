// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'following_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FollowingModel _$FollowingModelFromJson(Map<String, dynamic> json) {
  return _FollowingModel.fromJson(json);
}

/// @nodoc
mixin _$FollowingModel {
  String get title => throw _privateConstructorUsedError;
  List<CreatorModel> get listCreator => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FollowingModelCopyWith<FollowingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowingModelCopyWith<$Res> {
  factory $FollowingModelCopyWith(
          FollowingModel value, $Res Function(FollowingModel) then) =
      _$FollowingModelCopyWithImpl<$Res, FollowingModel>;
  @useResult
  $Res call({String title, List<CreatorModel> listCreator});
}

/// @nodoc
class _$FollowingModelCopyWithImpl<$Res, $Val extends FollowingModel>
    implements $FollowingModelCopyWith<$Res> {
  _$FollowingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? listCreator = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      listCreator: null == listCreator
          ? _value.listCreator
          : listCreator // ignore: cast_nullable_to_non_nullable
              as List<CreatorModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FollowingModelCopyWith<$Res>
    implements $FollowingModelCopyWith<$Res> {
  factory _$$_FollowingModelCopyWith(
          _$_FollowingModel value, $Res Function(_$_FollowingModel) then) =
      __$$_FollowingModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, List<CreatorModel> listCreator});
}

/// @nodoc
class __$$_FollowingModelCopyWithImpl<$Res>
    extends _$FollowingModelCopyWithImpl<$Res, _$_FollowingModel>
    implements _$$_FollowingModelCopyWith<$Res> {
  __$$_FollowingModelCopyWithImpl(
      _$_FollowingModel _value, $Res Function(_$_FollowingModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? listCreator = null,
  }) {
    return _then(_$_FollowingModel(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      listCreator: null == listCreator
          ? _value._listCreator
          : listCreator // ignore: cast_nullable_to_non_nullable
              as List<CreatorModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FollowingModel extends _FollowingModel {
  const _$_FollowingModel(
      {required this.title, required final List<CreatorModel> listCreator})
      : _listCreator = listCreator,
        super._();

  factory _$_FollowingModel.fromJson(Map<String, dynamic> json) =>
      _$$_FollowingModelFromJson(json);

  @override
  final String title;
  final List<CreatorModel> _listCreator;
  @override
  List<CreatorModel> get listCreator {
    if (_listCreator is EqualUnmodifiableListView) return _listCreator;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listCreator);
  }

  @override
  String toString() {
    return 'FollowingModel(title: $title, listCreator: $listCreator)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FollowingModel &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._listCreator, _listCreator));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, title, const DeepCollectionEquality().hash(_listCreator));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FollowingModelCopyWith<_$_FollowingModel> get copyWith =>
      __$$_FollowingModelCopyWithImpl<_$_FollowingModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FollowingModelToJson(
      this,
    );
  }
}

abstract class _FollowingModel extends FollowingModel {
  const factory _FollowingModel(
      {required final String title,
      required final List<CreatorModel> listCreator}) = _$_FollowingModel;
  const _FollowingModel._() : super._();

  factory _FollowingModel.fromJson(Map<String, dynamic> json) =
      _$_FollowingModel.fromJson;

  @override
  String get title;
  @override
  List<CreatorModel> get listCreator;
  @override
  @JsonKey(ignore: true)
  _$$_FollowingModelCopyWith<_$_FollowingModel> get copyWith =>
      throw _privateConstructorUsedError;
}
