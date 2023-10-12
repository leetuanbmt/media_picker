import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/config.dart';
import '../core/models/models.dart';
import '../core/utilities/utilities.dart';
import 'firebase_provider.dart';
part 'search_provider.freezed.dart';

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.loaded(List<UserModel> items) = _Loaded;
  const factory SearchState.error(String message) = _Error;
}

final searchNotifier = StateNotifierProvider.autoDispose
    .family<SearchNotifier, SearchState, String?>(
  (ref, category) => SearchNotifier(ref, category),
);

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier(this.ref, this.category) : super(const SearchState.initial()) {
    initialize();
  }
  final Ref ref;
  final String? category;
  // list of all creators
  List<UserModel> items = [];

  bool isLoading = true;

  void initialize() async {
    try {
      state = const SearchState.loading();
      final collection = ref
          .read(firestoreProvider)
          .collection(DbCollection.users)
          .where(DbKey.type, isEqualTo: UserType.creator.value);
      final snapshot = await (category.isNotEmptyAndNotNull
              ? collection.where('listCategory', arrayContainsAny: [category])
              : collection)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) {
              return UserModel.fromJson(snapshot.data()!);
            },
            toFirestore: (user, _) => user.toJson(),
          )
          .get();
      items = snapshot.docs.map((e) => e.data()).toList();
      state = SearchState.loaded(items);
      isLoading = false;
    } catch (e) {
      Logger.log(e);
    }
  }

  void searchCreator(String val) {
    if (val.isEmpty) {
      state = SearchState.loaded(items);
      return;
    }
    // search by name
    state = SearchState.loaded(
      items.where((element) => element.name.contains(val)).toList(),
    );
  }
}
