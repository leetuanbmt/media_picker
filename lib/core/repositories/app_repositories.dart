part of repositories;

sealed class AppRepositories {
  Future<Result<dynamic>> fetchUserInfo({
    required String userId,
    CancelToken? cancelToken,
  });
  Future<Result<UserResultState>> getUserList({
    required int page,
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

  @override
  Future<Result<UserResultState>> getUserList({
    required int page,
    CancelToken? cancelToken,
  }) {
    return request(restClient.getUserList(page, 10, cancelToken));
  }
}

base class Demo {
  void setData() {}
}
