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
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: "total_pages")
  int get total => throw _privateConstructorUsedError;
  List<UserModel> get data => throw _privateConstructorUsedError;
  dynamic get isLoading => throw _privateConstructorUsedError;
  dynamic get isLoadMore => throw _privateConstructorUsedError;

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
      {int page,
      @JsonKey(name: "total_pages") int total,
      List<UserModel> data,
      dynamic isLoading,
      dynamic isLoadMore});
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
    Object? page = null,
    Object? total = null,
    Object? data = null,
    Object? isLoading = freezed,
    Object? isLoadMore = freezed,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isLoadMore: freezed == isLoadMore
          ? _value.isLoadMore
          : isLoadMore // ignore: cast_nullable_to_non_nullable
              as dynamic,
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
      {int page,
      @JsonKey(name: "total_pages") int total,
      List<UserModel> data,
      dynamic isLoading,
      dynamic isLoadMore});
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
    Object? page = null,
    Object? total = null,
    Object? data = null,
    Object? isLoading = freezed,
    Object? isLoadMore = freezed,
  }) {
    return _then(_$_UserResultState(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
      isLoadMore: freezed == isLoadMore ? _value.isLoadMore! : isLoadMore,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserResultState implements _UserResultState {
  const _$_UserResultState(
      {required this.page,
      @JsonKey(name: "total_pages") required this.total,
      required final List<UserModel> data,
      this.isLoading = true,
      this.isLoadMore = false})
      : _data = data;

  factory _$_UserResultState.fromJson(Map<String, dynamic> json) =>
      _$$_UserResultStateFromJson(json);

  @override
  final int page;
  @override
  @JsonKey(name: "total_pages")
  final int total;
  final List<UserModel> _data;
  @override
  List<UserModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  @JsonKey()
  final dynamic isLoadMore;

  @override
  String toString() {
    return 'UserResultState(page: $page, total: $total, data: $data, isLoading: $isLoading, isLoadMore: $isLoadMore)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserResultState &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.isLoadMore, isLoadMore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      total,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isLoadMore));

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
      {required final int page,
      @JsonKey(name: "total_pages") required final int total,
      required final List<UserModel> data,
      final dynamic isLoading,
      final dynamic isLoadMore}) = _$_UserResultState;

  factory _UserResultState.fromJson(Map<String, dynamic> json) =
      _$_UserResultState.fromJson;

  @override
  int get page;
  @override
  @JsonKey(name: "total_pages")
  int get total;
  @override
  List<UserModel> get data;
  @override
  dynamic get isLoading;
  @override
  dynamic get isLoadMore;
  @override
  @JsonKey(ignore: true)
  _$$_UserResultStateCopyWith<_$_UserResultState> get copyWith =>
      throw _privateConstructorUsedError;
}
