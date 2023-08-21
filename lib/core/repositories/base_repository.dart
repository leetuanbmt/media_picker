library repositories;

import 'package:dio/dio.dart';

import '../config.dart';
import '../models/models.dart';
import '../services/rest_client.dart';
import '../utilities/logger.dart';
part 'app_repositories.dart';

typedef CallBack<Data> = Future Function(Data? data);

abstract class BaseRepository {
  Future<Result<Data>> request<Data>(Future<Data> call) async {
    try {
      final response = await call;
      return Success(response);
    } on Exception catch (exception) {
      if (exception is DioException) {
        int? errorCode = exception.response?.statusCode;
        final error = Error<Data>(
          type: ErrorType.other,
          message: exception.message,
          code: errorCode,
        );
        if (errorCode != null && errorCode >= 500 && errorCode < 600) {
          return error.copyWith(message: exception.response?.statusMessage);
        }
        switch (exception.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.connectionError:
            return error.copyWith(type: ErrorType.timeOut);
          case DioExceptionType.cancel:
            return error.copyWith(type: ErrorType.cancel);
          default:
            if (errorCode == 401) {
              return error.copyWith(type: ErrorType.tokenExpired);
            }
            return error.copyWith(type: ErrorType.other);
        }
      }
      return Error(type: ErrorType.other, message: exception.toString());
    }
  }
}

class Repositories {
  Repositories._();
  static final api = AppRepositoriesImpl();
}
