library repositories;

import 'dart:async';

import 'package:dio/dio.dart';

import '../config.dart';
import '../models/models.dart';
import '../services/rest_client.dart';
import '../utilities/pagination/pagination.dart';

part 'app_repositories.dart';

typedef CallBack<Data> = Future Function(Data? data);

sealed class BaseRepository {
  Future<Result<Data>> request<Data>(Future<Data> call) async {
    try {
      final response = await call;
      return Result.success(response);
    } on Exception catch (exception) {
      Logger.log(exception);
      if (exception is DioException) {
        int? errorCode = exception.response?.statusCode;
        final failure = FailureException(
          type: ErrorType.other,
          error: exception.error,
          stackTrace: exception.stackTrace,
          message: exception.message,
          code: errorCode,
        );
        switch (exception.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.connectionError:
            return Result.failure(failure.copyWith(type: ErrorType.timeOut));
          case DioExceptionType.cancel:
            return Result.failure(failure.copyWith(type: ErrorType.cancel));
          default:
            return Result.failure(failure);
        }
      }
      return Result.failure(
        FailureException(
          type: ErrorType.other,
          message: exception.toString(),
        ),
      );
    }
  }
}
