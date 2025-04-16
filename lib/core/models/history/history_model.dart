import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/enum.dart';
part 'history_model.freezed.dart';

@freezed
class HistoryModel with _$HistoryModel {
  const factory HistoryModel({
    @Default('') String suffix,
    required String title,
    required int point,
    required DateTime date,
    @Default(HistoryType.tip) HistoryType type,
  }) = _HistoryModel;
}
