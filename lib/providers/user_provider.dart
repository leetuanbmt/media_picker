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

final userProvider = FutureProvider.autoDispose.family<UserModel, String>(
  (ref, userId) async {
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
  },
);

@freezed
class UserResultState with _$UserResultState {
  const factory UserResultState({
    required int page,
    @JsonKey(name: "total_pages") required int total,
    required List<UserModel> data,
    @Default(true) isLoading,
    @Default(false) isLoadMore,
  }) = _UserResultState;

  factory UserResultState.fromJson(Map<String, dynamic> json) =>
      _$UserResultStateFromJson(json);
}

@riverpod
class UserList extends _$UserList {
  int page = 1;

  int total = 0;

  bool isLoadMore = false;

  bool get isHasMore => page < total;

  @override
  Future<UserResultState> build() async {
    final result = await ref.read(appProvider).getUserList(page: page);
    return result.when(
      success: (data) {
        total = data.total;
        return data;
      },
      failure: (error) {
        throw error.message ?? 'Error';
      },
    );
  }

  Future<void> loadMore() async {
    if (!isLoadMore && isHasMore) {
      isLoadMore = true;
      page++;
      final result = await ref.read(appProvider).getUserList(page: page);
      isLoadMore = false;
      result.when(
        success: (data) {
          final newState = state.value!.copyWith(
            data: [...state.value!.data, ...data.data],
          );
          state = AsyncData(newState);
        },
        failure: (error) {
          throw error.message ?? 'Error';
        },
      );
    }
  }

  Future<void> onRefresh() async {
    page = 1;
    final result = await ref.read(appProvider).getUserList(page: page);
    result.when(
      success: (data) {
        final newState = state.value!.copyWith(
          data: data.data,
        );
        state = AsyncData(newState);
      },
      failure: (error) {
        throw error.message ?? 'Error';
      },
    );
  }
}
