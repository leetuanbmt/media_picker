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

@freezed
abstract class PaginationState<T> with _$PaginationState<T> {
  const factory PaginationState.data(List<T> items) = _Data;
  const factory PaginationState.error(Object? e) = _Error;
  const factory PaginationState.loading() = _Loading;
  const factory PaginationState.loadMore(List<T> items) = _OnLoadMore;
  const factory PaginationState.loadMoreError(List<T> items, Object? e) =
      _LoadMoreError;
}

class BaseResponse<T> {
  final int total;
  final List<T> items;

  BaseResponse({required this.total, required this.items});
}
