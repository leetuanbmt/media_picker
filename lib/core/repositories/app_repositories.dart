part of repositories;

abstract class AppRepositories {
  Future<Result<dynamic>> getExample(Map<String, dynamic> queryParameters);
}

class AppRepositoriesImpl extends BaseRepository implements AppRepositories {
  late final RestClient restClient = RestClient(dio);

  @override
  Future<Result> getExample(Map<String, dynamic> queryParameters) {
    return request(restClient.getExample(queryParameters));
  }
}
