import 'package:hooks_riverpod/hooks_riverpod.dart';

final creatorCategoryProvider =
    StateNotifierProvider<CreatorCategory, List<String>>(
  (ref) => CreatorCategory(),
);

class CreatorCategory extends StateNotifier<List<String>> {
  CreatorCategory() : super(['お笑い', 'アート', 'メディア']);

  Future<void> getListCreateCategory(String userId) async {
    state = ['お笑い', 'アート', 'メディア'];

    ///  fetch API get category
  }
}
