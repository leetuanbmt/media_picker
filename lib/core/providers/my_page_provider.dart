import '../config.dart';
import '../models/enum/enum.dart';
import '../models/user/user_model.dart';
import '../utilities/utilities.dart';
import 'firebase_provider.dart';

final myPageProvider = ChangeNotifierProvider.autoDispose<MyPageProvider>(
  (ref) => MyPageProvider(ref),
);

class MyPageProvider extends ChangeNotifier {
  MyPageProvider(this.ref);

  final Ref ref;

// MY PAGE SCREEN

  List<String> listUserFollowing = [
    '41AV2ifXGiTYAiOO20ye4kLmeM73',
    '475VB9gMMDhyZpp3zvLdwit5yZn2',
    'Mb5UokqqQjPr6SWREfDeZz2cBgg2',
  ];

  bool showAllBio = false;

  bool isBlocked = false;

  bool isShowTimeRemaining = false;

  final blockController = TextEditingController();

  String get blockContent => blockController.text;

  void showBio() {
    showAllBio = !showAllBio;
    notifyListeners();
  }

  void blockUser() {
    isBlocked = !isBlocked;
    notifyListeners();
  }

  void followUser(String id) {
    listUserFollowing.add(id);
    checkFollowUser(id);
    notifyListeners();
  }

  bool checkFollowUser(String id) {
    return listUserFollowing.contains(id);
  }

  void showTimeRemaining() {
    isShowTimeRemaining = !isShowTimeRemaining;
    notifyListeners();
  }

// SEND POINTS

  bool isDelaySetting = false;

  bool isAutoSetting = false;

  bool isSaveSetting = false;

  int coinSelected = -1;
  int chargeSelected = -1;

  final List<DropdownMenuEntry<String>> autoItems = [
    const DropdownMenuEntry(value: '5回', label: '5回'),
    const DropdownMenuEntry(value: '10回', label: '10回'),
    const DropdownMenuEntry(value: '15回', label: '15回'),
    const DropdownMenuEntry(value: '20回', label: '20回'),
  ];

  final List<DropdownMenuEntry<String>> delayItems = [
    const DropdownMenuEntry(value: '5秒', label: '5秒'),
    const DropdownMenuEntry(value: '10秒', label: '10秒'),
    const DropdownMenuEntry(value: '15秒', label: '15秒'),
    const DropdownMenuEntry(value: '20秒', label: '20秒'),
  ];

  final delayController = TextEditingController(text: '5秒');
  final autoController = TextEditingController(text: '5回');
  final coinInputController = TextEditingController();

  String get settingItem => delayController.text;
  String get autoItem => autoController.text;
  String get coinInput => coinInputController.text;

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

  void changeAutoValue(String value) {
    autoController.text = value;
    notifyListeners();
  }

  void changeDelayValue(String value) {
    delayController.text = value;
    notifyListeners();
  }

  void updateValueSetting(TextEditingController controller, String value) {
    controller.text = value;
    notifyListeners();
  }

//CONNECTED DEVICES

  bool validControlRequest = true;
  final controlRequestController = TextEditingController();
  String get controlRequest => controlRequestController.text;

  RequestControlStatus requestStatus = RequestControlStatus.requestControl;

  bool showDeviceControlling = false;

  bool checkValidControlRequest() {
    validControlRequest = validateControlRequest();
    notifyListeners();
    return validControlRequest;
  }

  bool validateControlRequest() {
    if (controlRequestController.text.isNotEmpty) {
      return int.tryParse(controlRequestController.text)! < 10000;
    } else {
      return true;
    }
  }

  void updateShowDeviceControlling() {
    showDeviceControlling = !showDeviceControlling;
    notifyListeners();
  }

  void updateRequestStatus(RequestControlStatus value) {
    requestStatus = value;
    notifyListeners();
  }

//
}

final userRankingProvider = FutureProvider<List<UserModel>>((ref) async {
  final userRanking = await ref
      .watch(firestoreProvider)
      .collection(DbCollection.users)
      .orderBy(DbKeys.followers, descending: true)
      .where(DbKeys.type, isEqualTo: UserType.creator.value)
      .limit(10)
      .get();
  return userRanking.docs.map((e) => UserModel.fromJson(e.data())).toList();
});

final userFollowProvider = FutureProvider<List<UserModel>>((ref) async {
  final userFollow = await ref
      .watch(firestoreProvider)
      .collection(DbCollection.users)
      .limit(6)
      .get();
  return userFollow.docs.map((e) => UserModel.fromJson(e.data())).toList();
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
