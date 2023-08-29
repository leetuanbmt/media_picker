import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/models/models.dart';
import 'global_provider.dart';

part 'user_provider.g.dart';
part 'user_provider.freezed.dart';

@riverpod
Future<UserModel> getUserDetail(
  GetUserDetailRef ref,
  String userId,
) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  final result = await ref.read(appProvider).fetchUserInfo(
        userId: userId,
        cancelToken: cancelToken,
      );
  return result.when(
    success: (data) {
      return data;
    },
    failure: (error) {
      throw error.message ?? 'Error';
    },
  );
}

final userProvider =
    FutureProvider.family<UserModel, String>((ref, userId) async {
  // access the provider above
  final repository = ref.watch(appProvider);

  // use it to return a Future
  final result = await repository.fetchUserInfo(userId: userId);
  return result.when(
    success: (data) {
      return data;
    },
    failure: (error) {
      throw error.message ?? 'Error';
    },
  );
});

@freezed
class UserResultState with _$UserResultState {
  const factory UserResultState({
    required String query,
    required int page,
    required int? nextPage,
    required List<UserModel> list,
  }) = _UserResultState;
}

@riverpod
class UserProvider extends _$UserProvider {
  int page = 0;

  int total = 0;

  bool isLoadMore = false;

  bool get isHasMore => page < total;

  @override
  Future<UserResultState> build() async {
    final result = await ref.read(appProvider).fetchUserInfo(
          userId: "1",
        );

    return result.when(
      success: (data) {
        return UserResultState(
          query: "query",
          page: 1,
          nextPage: 1,
          list: [data],
        );
      },
      failure: (error) {
        throw error.message ?? 'Error';
      },
    );
  }

  Future<void> loadMore() async {}
}
