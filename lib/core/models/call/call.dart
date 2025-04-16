import 'package:freezed_annotation/freezed_annotation.dart';

part 'call.freezed.dart';
part 'call.g.dart';

@freezed
class Call with _$Call {
  const factory Call({
    required String callerId,
    required String callerName,
    required String callerPic,
    required String receiverId,
    required String receiverName,
    required String receiverPic,
    required String channelId,
    required bool hasDialled,
    required int timeepoch,
  }) = _Call;

  factory Call.fromJson(Map<String, dynamic> json) => _$CallFromJson(json);
}
