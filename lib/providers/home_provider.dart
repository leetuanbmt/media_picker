import '../core/config.dart';
import '../core/models/creator/creator_model.dart';
import 'firebase_provider.dart';

final creatorOnlineProvider = StreamProvider.autoDispose<List<CreatorModel>>(
  (ref) => ref
      .watch(firestoreProvider)
      .collection('creators')
      .where('isOnline', isEqualTo: true)
      .snapshots()
      .map(
        (e) => e.docs.map((e) => CreatorModel.fromJson(e.data())).toList(),
      ),
);

final creatorByCategory =
    StreamProvider.autoDispose<Map<String, List<CreatorModel>>>(
  (ref) => ref
      .watch(firestoreProvider)
      .collection('creators')
      .snapshots()
      .map((e) => e.docs.map((e) => CreatorModel.fromJson(e.data())))
      .map((event) => event.groupBy((element) => element.category)),
);
