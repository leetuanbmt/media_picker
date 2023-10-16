import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/config.dart';
import '../core/models/models.dart';
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

  void followUsers() {
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

  CollectionReference users =
      FirebaseFirestore.instance.collection(DbCollection.users);

  Future<void> updateUser() {
    return users
        .doc('TxQHXq13rmbDtEW4kbCseMSepI23')
        .update({'following': []})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    //return users.doc('41AV2ifXGiTYAiOO20ye4kLmeM73').snapshots().first;
  }

  Future<void> followUser(String userID) async {
    final currentUser = ref.read(firebaseAuthProvider).currentUser!.uid;
    await ref
        .watch(firestoreProvider)
        .collection(DbCollection.users)
        .doc(currentUser)
        .update({
      'following': FieldValue.arrayUnion([userID]),
    });

    notifyListeners();
  }

  Future<void> unFollowUser(String userID) async {
    final currentUser = ref.read(firebaseAuthProvider).currentUser!.uid;
    return ref
        .watch(firestoreProvider)
        .collection(DbCollection.users)
        .doc(currentUser)
        .update({
      'following': FieldValue.arrayRemove([userID]),
    });
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

final userCheckFollow = StreamProvider.autoDispose((ref) {
  final currentUser = ref.read(firebaseAuthProvider).currentUser!.uid;
  final userSnapshot = ref
      .watch(firestoreProvider)
      .collection(DbCollection.users)
      .doc(currentUser)
      .snapshots()
      .map((event) => UserModel.fromJson(event.data() as Json));
  print(userSnapshot);
  return userSnapshot;
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
