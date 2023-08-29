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

/// @nodoc
mixin _$UserResultState {
  String get query => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int? get nextPage => throw _privateConstructorUsedError;
  List<UserModel> get list => throw _privateConstructorUsedError;

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
  $Res call({String query, int page, int? nextPage, List<UserModel> list});
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
    Object? query = null,
    Object? page = null,
    Object? nextPage = freezed,
    Object? list = null,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      nextPage: freezed == nextPage
          ? _value.nextPage
          : nextPage // ignore: cast_nullable_to_non_nullable
              as int?,
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
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
  $Res call({String query, int page, int? nextPage, List<UserModel> list});
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
    Object? query = null,
    Object? page = null,
    Object? nextPage = freezed,
    Object? list = null,
  }) {
    return _then(_$_UserResultState(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      nextPage: freezed == nextPage
          ? _value.nextPage
          : nextPage // ignore: cast_nullable_to_non_nullable
              as int?,
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ));
  }
}

/// @nodoc

class _$_UserResultState implements _UserResultState {
  const _$_UserResultState(
      {required this.query,
      required this.page,
      required this.nextPage,
      required final List<UserModel> list})
      : _list = list;

  @override
  final String query;
  @override
  final int page;
  @override
  final int? nextPage;
  final List<UserModel> _list;
  @override
  List<UserModel> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'UserResultState(query: $query, page: $page, nextPage: $nextPage, list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserResultState &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.nextPage, nextPage) ||
                other.nextPage == nextPage) &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, page, nextPage,
      const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserResultStateCopyWith<_$_UserResultState> get copyWith =>
      __$$_UserResultStateCopyWithImpl<_$_UserResultState>(this, _$identity);
}

abstract class _UserResultState implements UserResultState {
  const factory _UserResultState(
      {required final String query,
      required final int page,
      required final int? nextPage,
      required final List<UserModel> list}) = _$_UserResultState;

  @override
  String get query;
  @override
  int get page;
  @override
  int? get nextPage;
  @override
  List<UserModel> get list;
  @override
  @JsonKey(ignore: true)
  _$$_UserResultStateCopyWith<_$_UserResultState> get copyWith =>
      throw _privateConstructorUsedError;
}
