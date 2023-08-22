part of repositories;

abstract class AppRepositories {
  Future<Result<dynamic>> fetchUserInfo(String userId);
}

class AppRepositoriesImpl extends BaseRepository implements AppRepositories {
  late final RestClient restClient = RestClient(dio);

  @override
  Future<Result<UserModel>> fetchUserInfo(String userId) async {
    final data = await request(restClient.fetchUserInfo(userId));
    return data.when(
      success: (data) {
        return Result.success(UserModel.fromJson(data['data']));
      },
      error: (type, message, code, result) => Result.error(
        type,
        message: message,
        code: code,
        result: result,
      ),
    );
  }
}
