// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BaseState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() loading,
    required TResult Function(T user) loaded,
    required TResult Function(String? message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? loading,
    TResult? Function(T user)? loaded,
    TResult? Function(String? message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? loading,
    TResult Function(T user)? loaded,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialState<T> value) $default, {
    required TResult Function(LoadingState<T> value) loading,
    required TResult Function(SuccessState<T> value) loaded,
    required TResult Function(ErrorState<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(InitialState<T> value)? $default, {
    TResult? Function(LoadingState<T> value)? loading,
    TResult? Function(SuccessState<T> value)? loaded,
    TResult? Function(ErrorState<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialState<T> value)? $default, {
    TResult Function(LoadingState<T> value)? loading,
    TResult Function(SuccessState<T> value)? loaded,
    TResult Function(ErrorState<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseStateCopyWith<T, $Res> {
  factory $BaseStateCopyWith(
          BaseState<T> value, $Res Function(BaseState<T>) then) =
      _$BaseStateCopyWithImpl<T, $Res, BaseState<T>>;
}

/// @nodoc
class _$BaseStateCopyWithImpl<T, $Res, $Val extends BaseState<T>>
    implements $BaseStateCopyWith<T, $Res> {
  _$BaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialStateCopyWith<T, $Res> {
  factory _$$InitialStateCopyWith(
          _$InitialState<T> value, $Res Function(_$InitialState<T>) then) =
      __$$InitialStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InitialStateCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$InitialState<T>>
    implements _$$InitialStateCopyWith<T, $Res> {
  __$$InitialStateCopyWithImpl(
      _$InitialState<T> _value, $Res Function(_$InitialState<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialState<T> implements InitialState<T> {
  const _$InitialState();

  @override
  String toString() {
    return 'BaseState<$T>()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialState<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() loading,
    required TResult Function(T user) loaded,
    required TResult Function(String? message) error,
  }) {
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? loading,
    TResult? Function(T user)? loaded,
    TResult? Function(String? message)? error,
  }) {
    return $default?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? loading,
    TResult Function(T user)? loaded,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialState<T> value) $default, {
    required TResult Function(LoadingState<T> value) loading,
    required TResult Function(SuccessState<T> value) loaded,
    required TResult Function(ErrorState<T> value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(InitialState<T> value)? $default, {
    TResult? Function(LoadingState<T> value)? loading,
    TResult? Function(SuccessState<T> value)? loaded,
    TResult? Function(ErrorState<T> value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialState<T> value)? $default, {
    TResult Function(LoadingState<T> value)? loading,
    TResult Function(SuccessState<T> value)? loaded,
    TResult Function(ErrorState<T> value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class InitialState<T> implements BaseState<T> {
  const factory InitialState() = _$InitialState<T>;
}

/// @nodoc
abstract class _$$LoadingStateCopyWith<T, $Res> {
  factory _$$LoadingStateCopyWith(
          _$LoadingState<T> value, $Res Function(_$LoadingState<T>) then) =
      __$$LoadingStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoadingStateCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$LoadingState<T>>
    implements _$$LoadingStateCopyWith<T, $Res> {
  __$$LoadingStateCopyWithImpl(
      _$LoadingState<T> _value, $Res Function(_$LoadingState<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingState<T> implements LoadingState<T> {
  const _$LoadingState();

  @override
  String toString() {
    return 'BaseState<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingState<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() loading,
    required TResult Function(T user) loaded,
    required TResult Function(String? message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? loading,
    TResult? Function(T user)? loaded,
    TResult? Function(String? message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? loading,
    TResult Function(T user)? loaded,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialState<T> value) $default, {
    required TResult Function(LoadingState<T> value) loading,
    required TResult Function(SuccessState<T> value) loaded,
    required TResult Function(ErrorState<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(InitialState<T> value)? $default, {
    TResult? Function(LoadingState<T> value)? loading,
    TResult? Function(SuccessState<T> value)? loaded,
    TResult? Function(ErrorState<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialState<T> value)? $default, {
    TResult Function(LoadingState<T> value)? loading,
    TResult Function(SuccessState<T> value)? loaded,
    TResult Function(ErrorState<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingState<T> implements BaseState<T> {
  const factory LoadingState() = _$LoadingState<T>;
}

/// @nodoc
abstract class _$$SuccessStateCopyWith<T, $Res> {
  factory _$$SuccessStateCopyWith(
          _$SuccessState<T> value, $Res Function(_$SuccessState<T>) then) =
      __$$SuccessStateCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T user});
}

/// @nodoc
class __$$SuccessStateCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$SuccessState<T>>
    implements _$$SuccessStateCopyWith<T, $Res> {
  __$$SuccessStateCopyWithImpl(
      _$SuccessState<T> _value, $Res Function(_$SuccessState<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$SuccessState<T>(
      freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$SuccessState<T> implements SuccessState<T> {
  const _$SuccessState(this.user);

  @override
  final T user;

  @override
  String toString() {
    return 'BaseState<$T>.loaded(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessState<T> &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessStateCopyWith<T, _$SuccessState<T>> get copyWith =>
      __$$SuccessStateCopyWithImpl<T, _$SuccessState<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() loading,
    required TResult Function(T user) loaded,
    required TResult Function(String? message) error,
  }) {
    return loaded(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? loading,
    TResult? Function(T user)? loaded,
    TResult? Function(String? message)? error,
  }) {
    return loaded?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? loading,
    TResult Function(T user)? loaded,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialState<T> value) $default, {
    required TResult Function(LoadingState<T> value) loading,
    required TResult Function(SuccessState<T> value) loaded,
    required TResult Function(ErrorState<T> value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(InitialState<T> value)? $default, {
    TResult? Function(LoadingState<T> value)? loading,
    TResult? Function(SuccessState<T> value)? loaded,
    TResult? Function(ErrorState<T> value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialState<T> value)? $default, {
    TResult Function(LoadingState<T> value)? loading,
    TResult Function(SuccessState<T> value)? loaded,
    TResult Function(ErrorState<T> value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SuccessState<T> implements BaseState<T> {
  const factory SuccessState(final T user) = _$SuccessState<T>;

  T get user;
  @JsonKey(ignore: true)
  _$$SuccessStateCopyWith<T, _$SuccessState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorStateCopyWith<T, $Res> {
  factory _$$ErrorStateCopyWith(
          _$ErrorState<T> value, $Res Function(_$ErrorState<T>) then) =
      __$$ErrorStateCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ErrorStateCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$ErrorState<T>>
    implements _$$ErrorStateCopyWith<T, $Res> {
  __$$ErrorStateCopyWithImpl(
      _$ErrorState<T> _value, $Res Function(_$ErrorState<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ErrorState<T>(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ErrorState<T> implements ErrorState<T> {
  const _$ErrorState({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'BaseState<$T>.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorState<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorStateCopyWith<T, _$ErrorState<T>> get copyWith =>
      __$$ErrorStateCopyWithImpl<T, _$ErrorState<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() loading,
    required TResult Function(T user) loaded,
    required TResult Function(String? message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? loading,
    TResult? Function(T user)? loaded,
    TResult? Function(String? message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? loading,
    TResult Function(T user)? loaded,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(InitialState<T> value) $default, {
    required TResult Function(LoadingState<T> value) loading,
    required TResult Function(SuccessState<T> value) loaded,
    required TResult Function(ErrorState<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(InitialState<T> value)? $default, {
    TResult? Function(LoadingState<T> value)? loading,
    TResult? Function(SuccessState<T> value)? loaded,
    TResult? Function(ErrorState<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(InitialState<T> value)? $default, {
    TResult Function(LoadingState<T> value)? loading,
    TResult Function(SuccessState<T> value)? loaded,
    TResult Function(ErrorState<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorState<T> implements BaseState<T> {
  const factory ErrorState({final String? message}) = _$ErrorState<T>;

  String? get message;
  @JsonKey(ignore: true)
  _$$ErrorStateCopyWith<T, _$ErrorState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Result<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T? data) success,
    required TResult Function(FailureException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T? data)? success,
    TResult? Function(FailureException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T? data)? success,
    TResult Function(FailureException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T> value) success,
    required TResult Function(Failure<T> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success<T> value)? success,
    TResult? Function(Failure<T> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T> value)? success,
    TResult Function(Failure<T> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCopyWith<T, $Res> {
  factory $ResultCopyWith(Result<T> value, $Res Function(Result<T>) then) =
      _$ResultCopyWithImpl<T, $Res, Result<T>>;
}

/// @nodoc
class _$ResultCopyWithImpl<T, $Res, $Val extends Result<T>>
    implements $ResultCopyWith<T, $Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SuccessCopyWith<T, $Res> {
  factory _$$SuccessCopyWith(
          _$Success<T> value, $Res Function(_$Success<T>) then) =
      __$$SuccessCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T? data});
}

/// @nodoc
class __$$SuccessCopyWithImpl<T, $Res>
    extends _$ResultCopyWithImpl<T, $Res, _$Success<T>>
    implements _$$SuccessCopyWith<T, $Res> {
  __$$SuccessCopyWithImpl(
      _$Success<T> _value, $Res Function(_$Success<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$Success<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

class _$Success<T> implements Success<T> {
  const _$Success(this.data);

  @override
  final T? data;

  @override
  String toString() {
    return 'Result<$T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Success<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessCopyWith<T, _$Success<T>> get copyWith =>
      __$$SuccessCopyWithImpl<T, _$Success<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T? data) success,
    required TResult Function(FailureException exception) failure,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T? data)? success,
    TResult? Function(FailureException exception)? failure,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T? data)? success,
    TResult Function(FailureException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T> value) success,
    required TResult Function(Failure<T> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success<T> value)? success,
    TResult? Function(Failure<T> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T> value)? success,
    TResult Function(Failure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success<T> implements Result<T> {
  const factory Success(final T? data) = _$Success<T>;

  T? get data;
  @JsonKey(ignore: true)
  _$$SuccessCopyWith<T, _$Success<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureCopyWith<T, $Res> {
  factory _$$FailureCopyWith(
          _$Failure<T> value, $Res Function(_$Failure<T>) then) =
      __$$FailureCopyWithImpl<T, $Res>;
  @useResult
  $Res call({FailureException exception});

  $FailureExceptionCopyWith<$Res> get exception;
}

/// @nodoc
class __$$FailureCopyWithImpl<T, $Res>
    extends _$ResultCopyWithImpl<T, $Res, _$Failure<T>>
    implements _$$FailureCopyWith<T, $Res> {
  __$$FailureCopyWithImpl(
      _$Failure<T> _value, $Res Function(_$Failure<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$Failure<T>(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as FailureException,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureExceptionCopyWith<$Res> get exception {
    return $FailureExceptionCopyWith<$Res>(_value.exception, (value) {
      return _then(_value.copyWith(exception: value));
    });
  }
}

/// @nodoc

class _$Failure<T> implements Failure<T> {
  const _$Failure(this.exception);

  @override
  final FailureException exception;

  @override
  String toString() {
    return 'Result<$T>.failure(exception: $exception)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Failure<T> &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureCopyWith<T, _$Failure<T>> get copyWith =>
      __$$FailureCopyWithImpl<T, _$Failure<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T? data) success,
    required TResult Function(FailureException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T? data)? success,
    TResult? Function(FailureException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T? data)? success,
    TResult Function(FailureException exception)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T> value) success,
    required TResult Function(Failure<T> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success<T> value)? success,
    TResult? Function(Failure<T> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T> value)? success,
    TResult Function(Failure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class Failure<T> implements Result<T> {
  const factory Failure(final FailureException exception) = _$Failure<T>;

  FailureException get exception;
  @JsonKey(ignore: true)
  _$$FailureCopyWith<T, _$Failure<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FailureException {
  ErrorType? get type => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  StackTrace? get stackTrace => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get code => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FailureExceptionCopyWith<FailureException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureExceptionCopyWith<$Res> {
  factory $FailureExceptionCopyWith(
          FailureException value, $Res Function(FailureException) then) =
      _$FailureExceptionCopyWithImpl<$Res, FailureException>;
  @useResult
  $Res call(
      {ErrorType? type,
      Object? error,
      StackTrace? stackTrace,
      String? message,
      int? code});
}

/// @nodoc
class _$FailureExceptionCopyWithImpl<$Res, $Val extends FailureException>
    implements $FailureExceptionCopyWith<$Res> {
  _$FailureExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? error = freezed,
    Object? stackTrace = freezed,
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ErrorType?,
      error: freezed == error ? _value.error : error,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FailureExceptionCopyWith<$Res>
    implements $FailureExceptionCopyWith<$Res> {
  factory _$$_FailureExceptionCopyWith(
          _$_FailureException value, $Res Function(_$_FailureException) then) =
      __$$_FailureExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ErrorType? type,
      Object? error,
      StackTrace? stackTrace,
      String? message,
      int? code});
}

/// @nodoc
class __$$_FailureExceptionCopyWithImpl<$Res>
    extends _$FailureExceptionCopyWithImpl<$Res, _$_FailureException>
    implements _$$_FailureExceptionCopyWith<$Res> {
  __$$_FailureExceptionCopyWithImpl(
      _$_FailureException _value, $Res Function(_$_FailureException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? error = freezed,
    Object? stackTrace = freezed,
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(_$_FailureException(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ErrorType?,
      error: freezed == error ? _value.error : error,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_FailureException implements _FailureException {
  const _$_FailureException(
      {this.type, this.error, this.stackTrace, this.message, this.code});

  @override
  final ErrorType? type;
  @override
  final Object? error;
  @override
  final StackTrace? stackTrace;
  @override
  final String? message;
  @override
  final int? code;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FailureException &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type,
      const DeepCollectionEquality().hash(error), stackTrace, message, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FailureExceptionCopyWith<_$_FailureException> get copyWith =>
      __$$_FailureExceptionCopyWithImpl<_$_FailureException>(this, _$identity);
}

abstract class _FailureException implements FailureException {
  const factory _FailureException(
      {final ErrorType? type,
      final Object? error,
      final StackTrace? stackTrace,
      final String? message,
      final int? code}) = _$_FailureException;

  @override
  ErrorType? get type;
  @override
  Object? get error;
  @override
  StackTrace? get stackTrace;
  @override
  String? get message;
  @override
  int? get code;
  @override
  @JsonKey(ignore: true)
  _$$_FailureExceptionCopyWith<_$_FailureException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaginationState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<T> items) data,
    required TResult Function(Object? e) error,
    required TResult Function() loading,
    required TResult Function(List<T> items) loadMore,
    required TResult Function(List<T> items, Object? e) loadMoreError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<T> items)? data,
    TResult? Function(Object? e)? error,
    TResult? Function()? loading,
    TResult? Function(List<T> items)? loadMore,
    TResult? Function(List<T> items, Object? e)? loadMoreError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<T> items)? data,
    TResult Function(Object? e)? error,
    TResult Function()? loading,
    TResult Function(List<T> items)? loadMore,
    TResult Function(List<T> items, Object? e)? loadMoreError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Data<T> value) data,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_OnLoadMore<T> value) loadMore,
    required TResult Function(_LoadMoreError<T> value) loadMoreError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Data<T> value)? data,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_OnLoadMore<T> value)? loadMore,
    TResult? Function(_LoadMoreError<T> value)? loadMoreError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Data<T> value)? data,
    TResult Function(_Error<T> value)? error,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_OnLoadMore<T> value)? loadMore,
    TResult Function(_LoadMoreError<T> value)? loadMoreError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationStateCopyWith<T, $Res> {
  factory $PaginationStateCopyWith(
          PaginationState<T> value, $Res Function(PaginationState<T>) then) =
      _$PaginationStateCopyWithImpl<T, $Res, PaginationState<T>>;
}

/// @nodoc
class _$PaginationStateCopyWithImpl<T, $Res, $Val extends PaginationState<T>>
    implements $PaginationStateCopyWith<T, $Res> {
  _$PaginationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_DataCopyWith<T, $Res> {
  factory _$$_DataCopyWith(_$_Data<T> value, $Res Function(_$_Data<T>) then) =
      __$$_DataCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> items});
}

/// @nodoc
class __$$_DataCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$_Data<T>>
    implements _$$_DataCopyWith<T, $Res> {
  __$$_DataCopyWithImpl(_$_Data<T> _value, $Res Function(_$_Data<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$_Data<T>(
      null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$_Data<T> implements _Data<T> {
  const _$_Data(final List<T> items) : _items = items;

  final List<T> _items;
  @override
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PaginationState<$T>.data(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Data<T> &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataCopyWith<T, _$_Data<T>> get copyWith =>
      __$$_DataCopyWithImpl<T, _$_Data<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<T> items) data,
    required TResult Function(Object? e) error,
    required TResult Function() loading,
    required TResult Function(List<T> items) loadMore,
    required TResult Function(List<T> items, Object? e) loadMoreError,
  }) {
    return data(items);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<T> items)? data,
    TResult? Function(Object? e)? error,
    TResult? Function()? loading,
    TResult? Function(List<T> items)? loadMore,
    TResult? Function(List<T> items, Object? e)? loadMoreError,
  }) {
    return data?.call(items);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<T> items)? data,
    TResult Function(Object? e)? error,
    TResult Function()? loading,
    TResult Function(List<T> items)? loadMore,
    TResult Function(List<T> items, Object? e)? loadMoreError,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(items);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Data<T> value) data,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_OnLoadMore<T> value) loadMore,
    required TResult Function(_LoadMoreError<T> value) loadMoreError,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Data<T> value)? data,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_OnLoadMore<T> value)? loadMore,
    TResult? Function(_LoadMoreError<T> value)? loadMoreError,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Data<T> value)? data,
    TResult Function(_Error<T> value)? error,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_OnLoadMore<T> value)? loadMore,
    TResult Function(_LoadMoreError<T> value)? loadMoreError,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _Data<T> implements PaginationState<T> {
  const factory _Data(final List<T> items) = _$_Data<T>;

  List<T> get items;
  @JsonKey(ignore: true)
  _$$_DataCopyWith<T, _$_Data<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<T, $Res> {
  factory _$$_ErrorCopyWith(
          _$_Error<T> value, $Res Function(_$_Error<T>) then) =
      __$$_ErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({Object? e});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$_Error<T>>
    implements _$$_ErrorCopyWith<T, $Res> {
  __$$_ErrorCopyWithImpl(_$_Error<T> _value, $Res Function(_$_Error<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$_Error<T>(
      freezed == e ? _value.e : e,
    ));
  }
}

/// @nodoc

class _$_Error<T> implements _Error<T> {
  const _$_Error(this.e);

  @override
  final Object? e;

  @override
  String toString() {
    return 'PaginationState<$T>.error(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error<T> &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorCopyWith<T, _$_Error<T>> get copyWith =>
      __$$_ErrorCopyWithImpl<T, _$_Error<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<T> items) data,
    required TResult Function(Object? e) error,
    required TResult Function() loading,
    required TResult Function(List<T> items) loadMore,
    required TResult Function(List<T> items, Object? e) loadMoreError,
  }) {
    return error(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<T> items)? data,
    TResult? Function(Object? e)? error,
    TResult? Function()? loading,
    TResult? Function(List<T> items)? loadMore,
    TResult? Function(List<T> items, Object? e)? loadMoreError,
  }) {
    return error?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<T> items)? data,
    TResult Function(Object? e)? error,
    TResult Function()? loading,
    TResult Function(List<T> items)? loadMore,
    TResult Function(List<T> items, Object? e)? loadMoreError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Data<T> value) data,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_OnLoadMore<T> value) loadMore,
    required TResult Function(_LoadMoreError<T> value) loadMoreError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Data<T> value)? data,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_OnLoadMore<T> value)? loadMore,
    TResult? Function(_LoadMoreError<T> value)? loadMoreError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Data<T> value)? data,
    TResult Function(_Error<T> value)? error,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_OnLoadMore<T> value)? loadMore,
    TResult Function(_LoadMoreError<T> value)? loadMoreError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error<T> implements PaginationState<T> {
  const factory _Error(final Object? e) = _$_Error<T>;

  Object? get e;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<T, _$_Error<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<T, $Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading<T> value, $Res Function(_$_Loading<T>) then) =
      __$$_LoadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$_Loading<T>>
    implements _$$_LoadingCopyWith<T, $Res> {
  __$$_LoadingCopyWithImpl(
      _$_Loading<T> _value, $Res Function(_$_Loading<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Loading<T> implements _Loading<T> {
  const _$_Loading();

  @override
  String toString() {
    return 'PaginationState<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<T> items) data,
    required TResult Function(Object? e) error,
    required TResult Function() loading,
    required TResult Function(List<T> items) loadMore,
    required TResult Function(List<T> items, Object? e) loadMoreError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<T> items)? data,
    TResult? Function(Object? e)? error,
    TResult? Function()? loading,
    TResult? Function(List<T> items)? loadMore,
    TResult? Function(List<T> items, Object? e)? loadMoreError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<T> items)? data,
    TResult Function(Object? e)? error,
    TResult Function()? loading,
    TResult Function(List<T> items)? loadMore,
    TResult Function(List<T> items, Object? e)? loadMoreError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Data<T> value) data,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_OnLoadMore<T> value) loadMore,
    required TResult Function(_LoadMoreError<T> value) loadMoreError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Data<T> value)? data,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_OnLoadMore<T> value)? loadMore,
    TResult? Function(_LoadMoreError<T> value)? loadMoreError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Data<T> value)? data,
    TResult Function(_Error<T> value)? error,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_OnLoadMore<T> value)? loadMore,
    TResult Function(_LoadMoreError<T> value)? loadMoreError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading<T> implements PaginationState<T> {
  const factory _Loading() = _$_Loading<T>;
}

/// @nodoc
abstract class _$$_OnLoadMoreCopyWith<T, $Res> {
  factory _$$_OnLoadMoreCopyWith(
          _$_OnLoadMore<T> value, $Res Function(_$_OnLoadMore<T>) then) =
      __$$_OnLoadMoreCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> items});
}

/// @nodoc
class __$$_OnLoadMoreCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$_OnLoadMore<T>>
    implements _$$_OnLoadMoreCopyWith<T, $Res> {
  __$$_OnLoadMoreCopyWithImpl(
      _$_OnLoadMore<T> _value, $Res Function(_$_OnLoadMore<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$_OnLoadMore<T>(
      null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$_OnLoadMore<T> implements _OnLoadMore<T> {
  const _$_OnLoadMore(final List<T> items) : _items = items;

  final List<T> _items;
  @override
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PaginationState<$T>.loadMore(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnLoadMore<T> &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OnLoadMoreCopyWith<T, _$_OnLoadMore<T>> get copyWith =>
      __$$_OnLoadMoreCopyWithImpl<T, _$_OnLoadMore<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<T> items) data,
    required TResult Function(Object? e) error,
    required TResult Function() loading,
    required TResult Function(List<T> items) loadMore,
    required TResult Function(List<T> items, Object? e) loadMoreError,
  }) {
    return loadMore(items);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<T> items)? data,
    TResult? Function(Object? e)? error,
    TResult? Function()? loading,
    TResult? Function(List<T> items)? loadMore,
    TResult? Function(List<T> items, Object? e)? loadMoreError,
  }) {
    return loadMore?.call(items);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<T> items)? data,
    TResult Function(Object? e)? error,
    TResult Function()? loading,
    TResult Function(List<T> items)? loadMore,
    TResult Function(List<T> items, Object? e)? loadMoreError,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(items);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Data<T> value) data,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_OnLoadMore<T> value) loadMore,
    required TResult Function(_LoadMoreError<T> value) loadMoreError,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Data<T> value)? data,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_OnLoadMore<T> value)? loadMore,
    TResult? Function(_LoadMoreError<T> value)? loadMoreError,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Data<T> value)? data,
    TResult Function(_Error<T> value)? error,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_OnLoadMore<T> value)? loadMore,
    TResult Function(_LoadMoreError<T> value)? loadMoreError,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class _OnLoadMore<T> implements PaginationState<T> {
  const factory _OnLoadMore(final List<T> items) = _$_OnLoadMore<T>;

  List<T> get items;
  @JsonKey(ignore: true)
  _$$_OnLoadMoreCopyWith<T, _$_OnLoadMore<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadMoreErrorCopyWith<T, $Res> {
  factory _$$_LoadMoreErrorCopyWith(
          _$_LoadMoreError<T> value, $Res Function(_$_LoadMoreError<T>) then) =
      __$$_LoadMoreErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> items, Object? e});
}

/// @nodoc
class __$$_LoadMoreErrorCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$_LoadMoreError<T>>
    implements _$$_LoadMoreErrorCopyWith<T, $Res> {
  __$$_LoadMoreErrorCopyWithImpl(
      _$_LoadMoreError<T> _value, $Res Function(_$_LoadMoreError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? e = freezed,
  }) {
    return _then(_$_LoadMoreError<T>(
      null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      freezed == e ? _value.e : e,
    ));
  }
}

/// @nodoc

class _$_LoadMoreError<T> implements _LoadMoreError<T> {
  const _$_LoadMoreError(final List<T> items, this.e) : _items = items;

  final List<T> _items;
  @override
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final Object? e;

  @override
  String toString() {
    return 'PaginationState<$T>.loadMoreError(items: $items, e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoadMoreError<T> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoadMoreErrorCopyWith<T, _$_LoadMoreError<T>> get copyWith =>
      __$$_LoadMoreErrorCopyWithImpl<T, _$_LoadMoreError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<T> items) data,
    required TResult Function(Object? e) error,
    required TResult Function() loading,
    required TResult Function(List<T> items) loadMore,
    required TResult Function(List<T> items, Object? e) loadMoreError,
  }) {
    return loadMoreError(items, e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<T> items)? data,
    TResult? Function(Object? e)? error,
    TResult? Function()? loading,
    TResult? Function(List<T> items)? loadMore,
    TResult? Function(List<T> items, Object? e)? loadMoreError,
  }) {
    return loadMoreError?.call(items, e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<T> items)? data,
    TResult Function(Object? e)? error,
    TResult Function()? loading,
    TResult Function(List<T> items)? loadMore,
    TResult Function(List<T> items, Object? e)? loadMoreError,
    required TResult orElse(),
  }) {
    if (loadMoreError != null) {
      return loadMoreError(items, e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Data<T> value) data,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_OnLoadMore<T> value) loadMore,
    required TResult Function(_LoadMoreError<T> value) loadMoreError,
  }) {
    return loadMoreError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Data<T> value)? data,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_OnLoadMore<T> value)? loadMore,
    TResult? Function(_LoadMoreError<T> value)? loadMoreError,
  }) {
    return loadMoreError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Data<T> value)? data,
    TResult Function(_Error<T> value)? error,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_OnLoadMore<T> value)? loadMore,
    TResult Function(_LoadMoreError<T> value)? loadMoreError,
    required TResult orElse(),
  }) {
    if (loadMoreError != null) {
      return loadMoreError(this);
    }
    return orElse();
  }
}

abstract class _LoadMoreError<T> implements PaginationState<T> {
  const factory _LoadMoreError(final List<T> items, final Object? e) =
      _$_LoadMoreError<T>;

  List<T> get items;
  Object? get e;
  @JsonKey(ignore: true)
  _$$_LoadMoreErrorCopyWith<T, _$_LoadMoreError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
