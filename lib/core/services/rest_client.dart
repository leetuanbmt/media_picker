import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../config.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: AppConfigs.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('users/{userId}')
  Future<dynamic> fetchUserInfo(
    @Path() String userId,
    @CancelRequest() CancelToken? cancelToken,
  );
  @GET('users')
  Future<dynamic> getUserList(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @CancelRequest() CancelToken? cancelToken,
  );
}
