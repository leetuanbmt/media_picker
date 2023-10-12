import '../core/config.dart';
import '../core/utilities/utilities.dart';
import 'firebase_provider.dart';

final myPageProvider = ChangeNotifierProvider.autoDispose<MyPageProvider>(
  (ref) => MyPageProvider(ref),
);

class MyPageProvider extends ChangeNotifier {
  MyPageProvider(this.ref);

  final Ref ref;

  bool showAllBio = false;

  bool isFollowed = false;

  bool isBlocked = false;

  bool isDelaySetting = false;

  bool isAutoSetting = false;

  bool isSaveSetting = false;

  int coinSelected = -1;
  int chargeSelected = -1;

  final blockController = TextEditingController();
  final delayController = TextEditingController(text: '5秒');
  final autoController = TextEditingController(text: '5回');
  final coinInputController = TextEditingController();

  String get blockContent => blockController.text;
  String get settingItem => delayController.text;
  String get autoItem => autoController.text;
  String get coinInput => coinInputController.text;
  void showBio() {
    showAllBio = !showAllBio;
    notifyListeners();
  }

  void followUser() {
    isFollowed = !isFollowed;
    notifyListeners();
  }

  void blockUser() {
    isBlocked = !isBlocked;
    notifyListeners();
  }

  void changeDelaySetting(bool value) {
    isDelaySetting = value;
    notifyListeners();
  }

  void changeAutoSetting(bool value) {
    isAutoSetting = value;
    notifyListeners();
  }

  void chooseCoin(int value) {
    coinSelected = value;
    notifyListeners();
  }

  void chooseCharge(int value) {
    chargeSelected = value;
    notifyListeners();
  }

  void changeSaveSetting(bool value) {
    isSaveSetting = value;
    notifyListeners();
  }

  void changeAutoValue() {
    autoController.text;
    notifyListeners();
  }

  void changeDelayValue() {
    delayController.text;
    notifyListeners();
  }
}

final userRankingProvider = FutureProvider<List<String>>((ref) async {
  final userRanking = await ref
      .watch(firestoreProvider)
      .collection(DbCollection.users)
      .limit(5)
      .get();
  return userRanking.docs
      .map((e) => e.data()['profile_photo'] as String)
      .toList();
});

final userFollowProvider = FutureProvider<List<String>>((ref) async {
  final userFollow = await ref
      .watch(firestoreProvider)
      .collection(DbCollection.users)
      .limit(6)
      .get();
  return userFollow.docs
      .map((e) => e.data()['profile_photo'] as String)
      .toList();
});

// final creatorFirestoreProvider =
//     Provider.autoDispose.family<DocumentReference, String?>(
//   (ref, uid) =>
//       ref.watch(firestoreProvider).collection(DbCollection.creators).doc(uid),
// );

// final creatorChangeFirebase =
//     StreamProvider.autoDispose.family<CreatorModel, String?>(
//   (ref, uid) => ref.watch(creatorFirestoreProvider(uid)).snapshots().map(
//         (event) => CreatorModel.fromJson(event.data() as Json),
//       ),
// );
