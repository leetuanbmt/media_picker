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
      return Result.success(response);
    } on Exception catch (exception) {
      if (exception is DioException) {
        int? errorCode = exception.response?.statusCode;

        switch (exception.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.connectionError:
            return Result.error(
              ErrorType.timeOut,
              message: exception.message,
              code: errorCode,
            );
          case DioExceptionType.cancel:
            return Result.error(
              ErrorType.cancel,
              message: exception.message,
              code: errorCode,
            );
          default:
            return Result.error(
              ErrorType.other,
              message: exception.message,
              code: errorCode,
            );
        }
      }
      return Result.error(ErrorType.other, message: exception.toString());
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
