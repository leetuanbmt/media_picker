import '../core/config.dart';
import '../core/models/creator/creator_model.dart';

final searchFuture = FutureProvider.autoDispose<List<CreatorModel>>((ref) {
  final listCategory = ['お笑い', 'アート', 'メディア', 'b', 'a', 'c', 'aaaa', 'abc'];
  return listCategory
      .map(
        (e) => CreatorModel(
          id: 1,
          firstName: e,
          lastName: e,
          avatar:
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
          category: e,
        ),
      )
      .toList();
});

final searchNotifier =
    StateNotifierProvider.autoDispose<SearchNotifier, List<CreatorModel>>(
  (_) => SearchNotifier(),
);

class SearchNotifier extends StateNotifier<List<CreatorModel>> {
  final listCategory = ['お笑い', 'アート', 'メディア', 'b', 'a', 'c', 'aaaa', 'abc'];
  SearchNotifier() : super([]) {
    state = listCategory
        .map(
          (e) => CreatorModel(
            id: 1,
            firstName: e,
            lastName: e,
            avatar:
                'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
            category: e,
          ),
        )
        .toList();
  }
  void searchByName(String name) {
    if (name.isEmpty) {
      state = listCategory
          .map(
            (e) => CreatorModel(
              id: 1,
              firstName: e,
              lastName: e,
              avatar:
                  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
              category: e,
            ),
          )
          .toList();
      return;
    }
    final list =
        listCategory.where((element) => element.contains(name)).toList();
    state = list
        .map(
          (e) => CreatorModel(
            id: 1,
            firstName: e,
            lastName: e,
            avatar:
                'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
            category: e,
          ),
        )
        .toList();
  }
}
