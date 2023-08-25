import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/models/models.dart';
import '../core/repositories/base_repository.dart';

// final userNotifierProvider = StateNotifierProvider<BaseState>(
//   (ref) => ref.watch(userProvider).when(
//         data: (data) => BaseState.loaded(data),
//         loading: () => const BaseState.loading(),
//         error: (error, stackTrace) => BaseState.error(message: error.message),
//       ),
// );

final userProvider = FutureProvider.autoDispose.family<UserModel, String>(
  (ref, userId) async {
    final cancelToken = CancelToken();
    final result = await Repositories.api.fetchUserInfo(
      userId: userId,
      cancelToken: cancelToken,
    );
    ref.onDispose(() => cancelToken.cancel());
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

// class UserNotifier extends StateNotifier<BaseState> {
//   UserNotifier() : super(const BaseState()) {
//     getUserInfo('1');
//   }

//   Future<void> getUserInfo(String userId) async {
//     state = const BaseState.loading();
//     (await Repositories.api.fetchUserInfo(userId)).when(
//       success: (data) {
//         state = BaseState.loaded(data);
//       },
//       failure: (error) {
//         state = BaseState.error(message: error.message);
//       },
//     );
//   }
// }
