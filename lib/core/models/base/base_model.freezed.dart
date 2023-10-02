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
    required TResult Function(T data) loaded,
    required TResult Function(String? message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String? message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? loading,
    TResult Function(T data)? loaded,
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
abstract class _$$InitialStateImplCopyWith<T, $Res> {
  factory _$$InitialStateImplCopyWith(_$InitialStateImpl<T> value,
          $Res Function(_$InitialStateImpl<T>) then) =
      __$$InitialStateImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InitialStateImplCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$InitialStateImpl<T>>
    implements _$$InitialStateImplCopyWith<T, $Res> {
  __$$InitialStateImplCopyWithImpl(
      _$InitialStateImpl<T> _value, $Res Function(_$InitialStateImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialStateImpl<T> implements InitialState<T> {
  const _$InitialStateImpl();

  @override
  String toString() {
    return 'BaseState<$T>()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialStateImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String? message) error,
  }) {
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String? message)? error,
  }) {
    return $default?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? loading,
    TResult Function(T data)? loaded,
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
  const factory InitialState() = _$InitialStateImpl<T>;
}

/// @nodoc
abstract class _$$LoadingStateImplCopyWith<T, $Res> {
  factory _$$LoadingStateImplCopyWith(_$LoadingStateImpl<T> value,
          $Res Function(_$LoadingStateImpl<T>) then) =
      __$$LoadingStateImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoadingStateImplCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$LoadingStateImpl<T>>
    implements _$$LoadingStateImplCopyWith<T, $Res> {
  __$$LoadingStateImplCopyWithImpl(
      _$LoadingStateImpl<T> _value, $Res Function(_$LoadingStateImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingStateImpl<T> implements LoadingState<T> {
  const _$LoadingStateImpl();

  @override
  String toString() {
    return 'BaseState<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingStateImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String? message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String? message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? loading,
    TResult Function(T data)? loaded,
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
  const factory LoadingState() = _$LoadingStateImpl<T>;
}

/// @nodoc
abstract class _$$SuccessStateImplCopyWith<T, $Res> {
  factory _$$SuccessStateImplCopyWith(_$SuccessStateImpl<T> value,
          $Res Function(_$SuccessStateImpl<T>) then) =
      __$$SuccessStateImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$SuccessStateImplCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$SuccessStateImpl<T>>
    implements _$$SuccessStateImplCopyWith<T, $Res> {
  __$$SuccessStateImplCopyWithImpl(
      _$SuccessStateImpl<T> _value, $Res Function(_$SuccessStateImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$SuccessStateImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$SuccessStateImpl<T> implements SuccessState<T> {
  const _$SuccessStateImpl(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'BaseState<$T>.loaded(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessStateImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessStateImplCopyWith<T, _$SuccessStateImpl<T>> get copyWith =>
      __$$SuccessStateImplCopyWithImpl<T, _$SuccessStateImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String? message) error,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String? message)? error,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data);
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
  const factory SuccessState(final T data) = _$SuccessStateImpl<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$SuccessStateImplCopyWith<T, _$SuccessStateImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorStateImplCopyWith<T, $Res> {
  factory _$$ErrorStateImplCopyWith(
          _$ErrorStateImpl<T> value, $Res Function(_$ErrorStateImpl<T>) then) =
      __$$ErrorStateImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ErrorStateImplCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$ErrorStateImpl<T>>
    implements _$$ErrorStateImplCopyWith<T, $Res> {
  __$$ErrorStateImplCopyWithImpl(
      _$ErrorStateImpl<T> _value, $Res Function(_$ErrorStateImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ErrorStateImpl<T>(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ErrorStateImpl<T> implements ErrorState<T> {
  const _$ErrorStateImpl({this.message});

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
            other is _$ErrorStateImpl<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorStateImplCopyWith<T, _$ErrorStateImpl<T>> get copyWith =>
      __$$ErrorStateImplCopyWithImpl<T, _$ErrorStateImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String? message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String? message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? loading,
    TResult Function(T data)? loaded,
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
  const factory ErrorState({final String? message}) = _$ErrorStateImpl<T>;

  String? get message;
  @JsonKey(ignore: true)
  _$$ErrorStateImplCopyWith<T, _$ErrorStateImpl<T>> get copyWith =>
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
abstract class _$$SuccessImplCopyWith<T, $Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl<T> value, $Res Function(_$SuccessImpl<T>) then) =
      __$$SuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T? data});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<T, $Res>
    extends _$ResultCopyWithImpl<T, $Res, _$SuccessImpl<T>>
    implements _$$SuccessImplCopyWith<T, $Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl<T> _value, $Res Function(_$SuccessImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$SuccessImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl<T> implements Success<T> {
  const _$SuccessImpl(this.data);

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
            other is _$SuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      __$$SuccessImplCopyWithImpl<T, _$SuccessImpl<T>>(this, _$identity);

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
  const factory Success(final T? data) = _$SuccessImpl<T>;

  T? get data;
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<T, $Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl<T> value, $Res Function(_$FailureImpl<T>) then) =
      __$$FailureImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({FailureException exception});

  $FailureExceptionCopyWith<$Res> get exception;
}

/// @nodoc
class __$$FailureImplCopyWithImpl<T, $Res>
    extends _$ResultCopyWithImpl<T, $Res, _$FailureImpl<T>>
    implements _$$FailureImplCopyWith<T, $Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl<T> _value, $Res Function(_$FailureImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$FailureImpl<T>(
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

class _$FailureImpl<T> implements Failure<T> {
  const _$FailureImpl(this.exception);

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
            other is _$FailureImpl<T> &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<T, _$FailureImpl<T>> get copyWith =>
      __$$FailureImplCopyWithImpl<T, _$FailureImpl<T>>(this, _$identity);

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
  const factory Failure(final FailureException exception) = _$FailureImpl<T>;

  FailureException get exception;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<T, _$FailureImpl<T>> get copyWith =>
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
abstract class _$$FailureExceptionImplCopyWith<$Res>
    implements $FailureExceptionCopyWith<$Res> {
  factory _$$FailureExceptionImplCopyWith(_$FailureExceptionImpl value,
          $Res Function(_$FailureExceptionImpl) then) =
      __$$FailureExceptionImplCopyWithImpl<$Res>;
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
class __$$FailureExceptionImplCopyWithImpl<$Res>
    extends _$FailureExceptionCopyWithImpl<$Res, _$FailureExceptionImpl>
    implements _$$FailureExceptionImplCopyWith<$Res> {
  __$$FailureExceptionImplCopyWithImpl(_$FailureExceptionImpl _value,
      $Res Function(_$FailureExceptionImpl) _then)
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
    return _then(_$FailureExceptionImpl(
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

class _$FailureExceptionImpl implements _FailureException {
  const _$FailureExceptionImpl(
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
            other is _$FailureExceptionImpl &&
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
  _$$FailureExceptionImplCopyWith<_$FailureExceptionImpl> get copyWith =>
      __$$FailureExceptionImplCopyWithImpl<_$FailureExceptionImpl>(
          this, _$identity);
}

abstract class _FailureException implements FailureException {
  const factory _FailureException(
      {final ErrorType? type,
      final Object? error,
      final StackTrace? stackTrace,
      final String? message,
      final int? code}) = _$FailureExceptionImpl;

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
  _$$FailureExceptionImplCopyWith<_$FailureExceptionImpl> get copyWith =>
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
abstract class _$$DataImplCopyWith<T, $Res> {
  factory _$$DataImplCopyWith(
          _$DataImpl<T> value, $Res Function(_$DataImpl<T>) then) =
      __$$DataImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> items});
}

/// @nodoc
class __$$DataImplCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$DataImpl<T>>
    implements _$$DataImplCopyWith<T, $Res> {
  __$$DataImplCopyWithImpl(
      _$DataImpl<T> _value, $Res Function(_$DataImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$DataImpl<T>(
      null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$DataImpl<T> implements _Data<T> {
  const _$DataImpl(final List<T> items) : _items = items;

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
            other is _$DataImpl<T> &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataImplCopyWith<T, _$DataImpl<T>> get copyWith =>
      __$$DataImplCopyWithImpl<T, _$DataImpl<T>>(this, _$identity);

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
  const factory _Data(final List<T> items) = _$DataImpl<T>;

  List<T> get items;
  @JsonKey(ignore: true)
  _$$DataImplCopyWith<T, _$DataImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<T, $Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl<T> value, $Res Function(_$ErrorImpl<T>) then) =
      __$$ErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({Object? e});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$ErrorImpl<T>>
    implements _$$ErrorImplCopyWith<T, $Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl<T> _value, $Res Function(_$ErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$ErrorImpl<T>(
      freezed == e ? _value.e : e,
    ));
  }
}

/// @nodoc

class _$ErrorImpl<T> implements _Error<T> {
  const _$ErrorImpl(this.e);

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
            other is _$ErrorImpl<T> &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      __$$ErrorImplCopyWithImpl<T, _$ErrorImpl<T>>(this, _$identity);

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
  const factory _Error(final Object? e) = _$ErrorImpl<T>;

  Object? get e;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<T, $Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl<T> value, $Res Function(_$LoadingImpl<T>) then) =
      __$$LoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$LoadingImpl<T>>
    implements _$$LoadingImplCopyWith<T, $Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl<T> _value, $Res Function(_$LoadingImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl<T> implements _Loading<T> {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'PaginationState<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl<T>);
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
  const factory _Loading() = _$LoadingImpl<T>;
}

/// @nodoc
abstract class _$$OnLoadMoreImplCopyWith<T, $Res> {
  factory _$$OnLoadMoreImplCopyWith(
          _$OnLoadMoreImpl<T> value, $Res Function(_$OnLoadMoreImpl<T>) then) =
      __$$OnLoadMoreImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> items});
}

/// @nodoc
class __$$OnLoadMoreImplCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$OnLoadMoreImpl<T>>
    implements _$$OnLoadMoreImplCopyWith<T, $Res> {
  __$$OnLoadMoreImplCopyWithImpl(
      _$OnLoadMoreImpl<T> _value, $Res Function(_$OnLoadMoreImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$OnLoadMoreImpl<T>(
      null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$OnLoadMoreImpl<T> implements _OnLoadMore<T> {
  const _$OnLoadMoreImpl(final List<T> items) : _items = items;

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
            other is _$OnLoadMoreImpl<T> &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnLoadMoreImplCopyWith<T, _$OnLoadMoreImpl<T>> get copyWith =>
      __$$OnLoadMoreImplCopyWithImpl<T, _$OnLoadMoreImpl<T>>(this, _$identity);

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
  const factory _OnLoadMore(final List<T> items) = _$OnLoadMoreImpl<T>;

  List<T> get items;
  @JsonKey(ignore: true)
  _$$OnLoadMoreImplCopyWith<T, _$OnLoadMoreImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMoreErrorImplCopyWith<T, $Res> {
  factory _$$LoadMoreErrorImplCopyWith(_$LoadMoreErrorImpl<T> value,
          $Res Function(_$LoadMoreErrorImpl<T>) then) =
      __$$LoadMoreErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> items, Object? e});
}

/// @nodoc
class __$$LoadMoreErrorImplCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$LoadMoreErrorImpl<T>>
    implements _$$LoadMoreErrorImplCopyWith<T, $Res> {
  __$$LoadMoreErrorImplCopyWithImpl(_$LoadMoreErrorImpl<T> _value,
      $Res Function(_$LoadMoreErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? e = freezed,
  }) {
    return _then(_$LoadMoreErrorImpl<T>(
      null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      freezed == e ? _value.e : e,
    ));
  }
}

/// @nodoc

class _$LoadMoreErrorImpl<T> implements _LoadMoreError<T> {
  const _$LoadMoreErrorImpl(final List<T> items, this.e) : _items = items;

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
            other is _$LoadMoreErrorImpl<T> &&
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
  _$$LoadMoreErrorImplCopyWith<T, _$LoadMoreErrorImpl<T>> get copyWith =>
      __$$LoadMoreErrorImplCopyWithImpl<T, _$LoadMoreErrorImpl<T>>(
          this, _$identity);

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
      _$LoadMoreErrorImpl<T>;

  List<T> get items;
  Object? get e;
  @JsonKey(ignore: true)
  _$$LoadMoreErrorImplCopyWith<T, _$LoadMoreErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
