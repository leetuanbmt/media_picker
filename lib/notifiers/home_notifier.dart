import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/models/user/following_model.dart';
import '../core/models/user/user_model.dart';

final creatorCategoryProvider =
    StateNotifierProvider<CreatorCategory, List<FollowingModel>>(
  (ref) => CreatorCategory(),
);

class CreatorCategory extends StateNotifier<List<FollowingModel>> {
  CreatorCategory() : super(UserModel.listFollowing);

  Future<void> getListFollowing() async {
    ///  fetch API get listFollowing
  }
}
