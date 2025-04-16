part of 'base_repository.dart';

sealed class AppRepositories {
  Future<Result<dynamic>> fetchUserInfo({
    required String userId,
    CancelToken? cancelToken,
  });
  Future<Result<PaginationResponse<UserM>>> getUserList({
    required int page,
    int perPage = 10,
    CancelToken? cancelToken,
  });
}

class AppRepositoriesImpl extends BaseRepository implements AppRepositories {
  AppRepositoriesImpl({required this.clientProvider});
  final Dio clientProvider;
  late final RestClient restClient = RestClient(clientProvider);

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
  Future<Result<PaginationResponse<UserM>>> getUserList({
    required int page,
    int perPage = 10,
    CancelToken? cancelToken,
  }) async {
    final data = await request(
      restClient.getUserList(page, perPage, cancelToken),
    );
    try {
      return data.when(
        success: (data) {
          return Result.success(
              PaginationResponse.fromJson(data, UserM.fromJson));
        },
        failure: (error) => Result.failure(error),
      );
    } catch (e) {
      Logger.log(e);
      return Result.failure(
        FailureException(
          message: e.toString(),
        ),
      );
    }
  }
}
