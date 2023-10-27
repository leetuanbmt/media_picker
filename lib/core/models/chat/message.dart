import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/enum.dart';
import '../user/user_model.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const Message._();
  const factory Message({
    required String id,
    @Default(MessageType.text) MessageType type,
    required String message,
    required DateTime timestamp,
    @Default(false) bool isRead,
    @Default(false) bool isMe,
    required UserModel sender,
    required UserModel receiver,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  String get avatar => isMe ? sender.avatar : receiver.avatar;
  String get name => isMe ? sender.name : receiver.name;
}
