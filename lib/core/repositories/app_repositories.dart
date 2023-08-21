part of repositories;

abstract class AppRepositories {
  Future<Result<dynamic>> getExample(Map<String, dynamic> queryParameters);
}

class AppRepositoriesImpl extends BaseRepository implements AppRepositories {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  )..interceptors.add(DioInterceptor());
  late final RestClient restClient = RestClient(dio);

  @override
  Future<Result> getExample(Map<String, dynamic> queryParameters) {
    return request(restClient.getExample(queryParameters));
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
