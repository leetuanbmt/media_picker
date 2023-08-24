import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/models/models.dart';
import '../core/repositories/base_repository.dart';

final userNotifierProvider = StateNotifierProvider<UserNotifier, BaseState>(
  (ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<BaseState> {
  UserNotifier() : super(const BaseState()) {
    getUserInfo('1');
  }

  Future<void> getUserInfo(String userId) async {
    state = const BaseState.loading();
    (await Repositories.api.fetchUserInfo(userId)).when(
      success: (data) {
        state = BaseState.loaded(data);
      },
      failure: (error) {
        state = BaseState.error(message: error.message);
      },
    );
  }
}
