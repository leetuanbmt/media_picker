import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/models/creator/creator_model.dart';
import '../core/models/models.dart';
import '../core/models/user/following_model.dart';

final userFollowingProvider =
    StateNotifierProvider<UserFollowing, BaseState<List<FollowingModel>>>(
  (ref) => UserFollowing(),
);
final creatorOnlineProvider =
    StateNotifierProvider<CreatorOnline, BaseState<List<CreatorModel>>>(
  (ref) => CreatorOnline(),
);

class UserFollowing extends StateNotifier<BaseState<List<FollowingModel>>> {
  UserFollowing() : super(const BaseState()) {
    getListFollowing();
  }
  Future<void> getListFollowing() async {
    state = BaseState.loaded(UserModel.listFollowing);
  }
}

class CreatorOnline extends StateNotifier<BaseState<List<CreatorModel>>> {
  CreatorOnline() : super(const BaseState()) {
    getListOnline();
  }
  Future<void> getListOnline() async {
    state = BaseState.loaded(UserModel.listOnline);
  }
}
