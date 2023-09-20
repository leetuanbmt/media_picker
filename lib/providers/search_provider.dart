import '../core/config.dart';
import '../core/models/creator/creator_model.dart';
import 'firebase_provider.dart';

final searchNotifier =
    StateNotifierProvider.autoDispose<SearchNotifier, List<CreatorModel>>(
  (ref) => SearchNotifier(ref)..initialize(),
);

class SearchNotifier extends StateNotifier<List<CreatorModel>> {
  SearchNotifier(this.ref) : super([]);
  final Ref ref;

  // list of all creators
  List<CreatorModel> items = [];

  void initialize() async {
    final list = await ref.read(firestoreProvider).collection('creators').get();
    items = list.docs.map((e) => CreatorModel.fromJson(e.data())).toList();
    state = items;
  }

  void searchCreator(String val) {
    if (val.isEmpty) {
      state = items;
      return;
    }
    // search by name
    state = items.where((element) => element.name.contains(val)).toList();
  }
}
