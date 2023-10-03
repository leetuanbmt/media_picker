import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utilities/utilities.dart';
import '../enum/enum.dart';

part 'call_history.g.dart';
part 'call_history.freezed.dart';

@freezed
class CallHistory with _$CallHistory {
  const factory CallHistory({
    required String callerId,
    required String callerName,
    required String callerPic,
    required String receiverId,
    required String receiverName,
    required String receiverPic,
    required String channelId,
    required bool hasDialled,
    required bool isCallMissed,
    required DateTime callTime,
    required CallStatus callStatus,
    required String type,
    @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
    DateTime? started,
    @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
    DateTime? ended,
  }) = _CallHistory;

  factory CallHistory.fromJson(Map<String, dynamic> json) =>
      _$CallHistoryFromJson(json);
}
