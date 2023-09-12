import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../providers/user_provider.dart';
import '../config.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("users/{userId}")
  Future<dynamic> fetchUserInfo(
    @Path() String userId,
    @CancelRequest() CancelToken? cancelToken,
  );
  @GET("users")
  Future<UserResultState> getUserList(
    @Query("page") int page,
    @Query("per_page") int perPage,
    @CancelRequest() CancelToken? cancelToken,
  );
  @POST("register")
  Future<dynamic> registerUser(
    @CancelRequest() CancelToken? cancelToken,
  );
}
