// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserResultState _$UserResultStateFromJson(Map<String, dynamic> json) {
  return _UserResultState.fromJson(json);
}

/// @nodoc
mixin _$UserResultState {
  @JsonKey(name: "total_pages")
  int get total => throw _privateConstructorUsedError;
  bool get isLoadMore => throw _privateConstructorUsedError;
  List<UserModel> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserResultStateCopyWith<UserResultState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserResultStateCopyWith<$Res> {
  factory $UserResultStateCopyWith(
          UserResultState value, $Res Function(UserResultState) then) =
      _$UserResultStateCopyWithImpl<$Res, UserResultState>;
  @useResult
  $Res call(
      {@JsonKey(name: "total_pages") int total,
      bool isLoadMore,
      List<UserModel> data});
}

/// @nodoc
class _$UserResultStateCopyWithImpl<$Res, $Val extends UserResultState>
    implements $UserResultStateCopyWith<$Res> {
  _$UserResultStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? isLoadMore = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      isLoadMore: null == isLoadMore
          ? _value.isLoadMore
          : isLoadMore // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserResultStateCopyWith<$Res>
    implements $UserResultStateCopyWith<$Res> {
  factory _$$_UserResultStateCopyWith(
          _$_UserResultState value, $Res Function(_$_UserResultState) then) =
      __$$_UserResultStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "total_pages") int total,
      bool isLoadMore,
      List<UserModel> data});
}

/// @nodoc
class __$$_UserResultStateCopyWithImpl<$Res>
    extends _$UserResultStateCopyWithImpl<$Res, _$_UserResultState>
    implements _$$_UserResultStateCopyWith<$Res> {
  __$$_UserResultStateCopyWithImpl(
      _$_UserResultState _value, $Res Function(_$_UserResultState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? isLoadMore = null,
    Object? data = null,
  }) {
    return _then(_$_UserResultState(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      isLoadMore: null == isLoadMore
          ? _value.isLoadMore
          : isLoadMore // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserResultState implements _UserResultState {
  const _$_UserResultState(
      {@JsonKey(name: "total_pages") required this.total,
      this.isLoadMore = false,
      required final List<UserModel> data})
      : _data = data;

  factory _$_UserResultState.fromJson(Map<String, dynamic> json) =>
      _$$_UserResultStateFromJson(json);

  @override
  @JsonKey(name: "total_pages")
  final int total;
  @override
  @JsonKey()
  final bool isLoadMore;
  final List<UserModel> _data;
  @override
  List<UserModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'UserResultState(total: $total, isLoadMore: $isLoadMore, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserResultState &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.isLoadMore, isLoadMore) ||
                other.isLoadMore == isLoadMore) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, total, isLoadMore,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserResultStateCopyWith<_$_UserResultState> get copyWith =>
      __$$_UserResultStateCopyWithImpl<_$_UserResultState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserResultStateToJson(
      this,
    );
  }
}

abstract class _UserResultState implements UserResultState {
  const factory _UserResultState(
      {@JsonKey(name: "total_pages") required final int total,
      final bool isLoadMore,
      required final List<UserModel> data}) = _$_UserResultState;

  factory _UserResultState.fromJson(Map<String, dynamic> json) =
      _$_UserResultState.fromJson;

  @override
  @JsonKey(name: "total_pages")
  int get total;
  @override
  bool get isLoadMore;
  @override
  List<UserModel> get data;
  @override
  @JsonKey(ignore: true)
  _$$_UserResultStateCopyWith<_$_UserResultState> get copyWith =>
      throw _privateConstructorUsedError;
}
