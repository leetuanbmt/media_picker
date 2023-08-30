import 'package:hooks_riverpod/hooks_riverpod.dart';

final pointConfirmChangeCardProvider =
    StateNotifierProvider<PointConfirmChangeCard, int>(
  (ref) => PointConfirmChangeCard(),
);

class PointConfirmChangeCard extends StateNotifier<int> {
  PointConfirmChangeCard() : super(0);
  void onChangeCard(int value) {
    state = value;
  }
}
