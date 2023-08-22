library repositories;

import 'package:dio/dio.dart';

import '../config.dart';
import '../models/models.dart';
import '../services/rest_client.dart';
import '../utilities/logger.dart';
part 'app_repositories.dart';

typedef CallBack<Data> = Future Function(Data? data);

abstract class BaseRepository {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  )..interceptors.add(DioInterceptor());

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

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final msg = options.uri.toString();
    Logger.log(msg);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.log(response.data.toString());
    super.onResponse(response, handler);
  }
}

class Repositories {
  Repositories._();
  static final api = AppRepositoriesImpl();
}
