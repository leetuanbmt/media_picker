import '../config.dart';
import '../models/models.dart';

final historyProvider = Provider.autoDispose<HistoryNotify>((ref) {
  return HistoryNotify();
});

class HistoryNotify extends ChangeNotifier {
  final List<HistoryModel> tips = [
    for (var i = 0; i < 10; i++)
      HistoryModel(
        point: 1000,
        title: 'を獲得しました',
        suffix: 'ポイント',
        date: DateTime.now(),
        type: HistoryType.tip,
      ),
  ];
  final List<HistoryModel> purchase = [
    for (var i = 0; i < 10; i++)
      HistoryModel(
        point: 1000,
        title: 'を消費しました',
        suffix: 'ポイント',
        date: DateTime.now(),
        type: HistoryType.purchase,
      ),
  ];
  final List<HistoryModel> transfer = [
    for (var i = 0; i < 10; i++)
      HistoryModel(
        point: 1000,
        suffix: '円（2000ポイント分）',
        title: 'が振り込まれました。',
        date: DateTime.now(),
        type: HistoryType.transfer,
      ),
  ];
}
