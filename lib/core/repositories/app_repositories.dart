part of repositories;

abstract class AppRepositories {
  Future<Result<dynamic>> fetchUserInfo({
    required String userId,
    CancelToken? cancelToken,
  });
}

class AppRepositoriesImpl extends BaseRepository implements AppRepositories {
  late final RestClient restClient = RestClient(dio);

  @override
  Future<Result<UserModel>> fetchUserInfo({
    required String userId,
    CancelToken? cancelToken,
  }) async {
    final data = await request(restClient.fetchUserInfo(userId, cancelToken));
    return data.when(
      success: (data) {
        return Result.success(UserModel.fromJson(data['data']));
      },
      failure: (error) => Result.failure(error),
    );
  }
}
