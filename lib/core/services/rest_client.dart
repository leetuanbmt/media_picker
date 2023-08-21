import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../config.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/api/v1/example")
  Future<dynamic> getExample(
    @QueryParam() Map<String, dynamic> queryParameters,
  );
}
