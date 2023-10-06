import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../extensions/date_extension.dart';
import '../../utilities/utilities.dart';

part 'call_history.g.dart';
part 'call_history.freezed.dart';

@freezed
class CallHistory with _$CallHistory {
  const CallHistory._();
  const factory CallHistory({
    required String callerId,
    required String callerName,
    required String callerPic,
    required String receiverId,
    required String receiverName,
    required String receiverPic,
    required String channelId,
    required bool hasDialled,
    required DateTime callTime,
    required String type,
    @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
    DateTime? started,
    @JsonKey(fromJson: AppUtils.fromJsonTime, toJson: AppUtils.toJsonTime)
    DateTime? ended,
  }) = _CallHistory;

  factory CallHistory.fromJson(Map<String, dynamic> json) =>
      _$CallHistoryFromJson(json);

  String get name => hasDialled ? receiverName : callerName;
  String get image => hasDialled ? receiverPic : callerPic;
  String get uid => hasDialled ? receiverId : callerId;

  String get time => callTime.format('MMMM d, hh:mm');

  String get totalCall => started != null && ended != null
      ? '${started!.format('hh:mm')} - ${ended!.format('hh:mm')}'
      : 'Missed Call';
}
