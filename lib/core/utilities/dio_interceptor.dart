import 'dart:io';

import 'package:dio/dio.dart';

import 'logger.dart';

class DioInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final msg = 'REQUEST[${options.method}] => PATH: ${options.uri.toString()}';
    Logger.log(msg);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final msg =
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}';
    Logger.log(msg);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final msg =
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}';

    final client = err.requestOptions.extra['client'];
    Logger.log(msg, tag: client.toString());

    // retry if the request is unauthorized

    if (isUnauthorized(err.response?.statusCode ?? 0)) {
      final options = err.requestOptions;
      final refreshToken = await _refreshToken();
      options.headers['Authorization'] = 'Bearer $refreshToken';
      final response = await Dio().fetch(options);
      return handler.resolve(response);
    }

    super.onError(err, handler);
  }

  Future<String> _refreshToken() async {
    return 'refresh_token';
  }

  bool isSuccessful(int statusCode) => statusCode >= 200 && statusCode < 300;

  bool isBadRequest(int statusCode) => statusCode >= 400 && statusCode < 500;

  bool isServerError(int statusCode) => statusCode >= 500;

  bool isNotFound(int statusCode) => statusCode == 404;

  bool isUnauthorized(int statusCode) => statusCode == 401;

  bool isForbidden(int statusCode) => statusCode == 403;

  bool isRequestTimeout(int statusCode) => statusCode == 408;

  bool isConflict(int statusCode) => statusCode == 409;

  bool isUnprocessableEntity(int statusCode) => statusCode == 422;

  bool isTooManyRequests(int statusCode) => statusCode == 429;

  bool isInternalServerError(int statusCode) => statusCode == 500;

  bool isBadGateway(int statusCode) => statusCode == 502;

  bool isServiceUnavailable(int statusCode) => statusCode == 503;

  bool isGatewayTimeout(int statusCode) => statusCode == 504;

  bool isNoInternetConnection(DioException error) =>
      error.type == DioExceptionType.connectionError ||
      error.type == DioExceptionType.sendTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.connectionTimeout ||
      error.error is SocketException;
}
