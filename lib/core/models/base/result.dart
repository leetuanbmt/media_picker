import 'error_type.dart';

class Result<T> with SealedResult<T> {
  bool get isSuccessful => this is Success<T>;
}

class Success<T> extends Result<T> {
  T? data;

  Success(this.data);
}

class Error<T> extends Result<T> {
  final String? message;
  final ErrorType type;
  final int? code;
  final String? result;

  Error({
    this.type = ErrorType.other,
    this.message,
    this.code,
    this.result,
  });

  bool get isTokenExpired => type == ErrorType.tokenExpired;

  bool get isTimeOut => type == ErrorType.timeOut;

  bool get isCancel => type == ErrorType.cancel;

  bool get noNetwork => type == ErrorType.noNetwork;

  Error<T> copyWith({
    String? message,
    ErrorType? type,
    int? code,
    String? result,
  }) =>
      Error<T>(
        type: type ?? this.type,
        message: message ?? this.message,
        code: code ?? this.code,
        result: result ?? this.result,
      );

  @override
  int get hashCode => Object.hash(type, message, code, result);

  @override
  bool operator ==(Object other) {
    return other is Error && other.hashCode == hashCode;
  }
}

mixin SealedResult<T> {
  R? when<R>({
    R Function(T?)? success,
    R Function(Error error)? error,
  }) {
    if (this is Success<T?>) {
      return success?.call(((this as Success).data));
    }
    if (this is Error<T>) {
      return error?.call(this as Error);
    } else {
      return error?.call(
        Error(
          type: ErrorType.other,
          message: toString(),
        ),
      );
    }
  }
}
