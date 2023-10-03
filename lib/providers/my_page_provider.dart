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

  final blockController = TextEditingController();

  String get blockContent => blockController.text;

  void showBio() {
    showAllBio = !showAllBio;
    notifyListeners();
  }

  double getTextHeight(String text, TextStyle textStyle, double textWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: textWidth);
    return textPainter.height;
  }

  void followUser() {
    isFollowed = !isFollowed;
    notifyListeners();
  }

  void blockUser() {
    isBlocked = !isBlocked;
    notifyListeners();
  }

  void showOptions(BuildContext context) {}
}

final userRankingProvider = FutureProvider<List<String>>((ref) async {
  final userRanking = await ref
      .watch(firestoreProvider)
      .collection(DbCollection.creators)
      .limit(5)
      .get();
  return userRanking.docs
      .map((e) => e.data()['profile_photo'] as String)
      .toList();
});

final userFollowProvider = FutureProvider<List<String>>((ref) async {
  final userFollow = await ref
      .watch(firestoreProvider)
      .collection(DbCollection.creators)
      .limit(6)
      .get();
  return userFollow.docs
      .map((e) => e.data()['profile_photo'] as String)
      .toList();
});
