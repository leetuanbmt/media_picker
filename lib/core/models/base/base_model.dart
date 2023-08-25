import 'package:freezed_annotation/freezed_annotation.dart';

import 'error_type.dart';

part 'base_model.freezed.dart';

@freezed
abstract class BaseState<T> with _$BaseState {
  const factory BaseState() = InitialState;
  const factory BaseState.loading() = LoadingState;
  const factory BaseState.loaded(T user) = SuccessState<T>;
  const factory BaseState.error({String? message}) = ErrorState;
}

@freezed
abstract class Result<T> with _$Result {
  const factory Result.success(T? data) = Success<T>;
  const factory Result.failure(FailureException exception) = Failure<T>;
}

@freezed
class FailureException with _$FailureException {
  const factory FailureException({
    ErrorType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
    int? code,
  }) = _FailureException;

  @override
  String toString() {
    return 'FailureException(type: $type, error: $error, stackTrace: $stackTrace, message: $message, code: $code)';
  }
}

// @freezed
// abstract class Result<Success, Failure extends Object>
//     with _$Result<Success, Failure> {
//   const Result._();
//   const factory Result.success(Success data) = Success<Success, Failure>;
//   const factory Result.failure(Failure error) = Failure<Success, Failure>;

//   static FutureOr<Result<T, E>> catching<T, E extends Object>(
//       FutureOr<T> Function() closure) async {
//     try {
//       final value = await closure();
//       return Result.success(value);
//     } on E catch (e) {
//       return Result.failure(e);
//     }
//   }

//   /// `true` if the result is a [success], `false`
//   /// otherwise.
//   bool get isSuccess;

//   /// `true` if the result is a [failure], `false`
//   /// otherwise.
//   bool get isFailure => !isSuccess;
// }
