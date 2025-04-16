import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gmo_media_picker/media_picker.dart';

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
    @Default('') String message,
    required DateTime timestamp,
    @Default(false) bool isRead,
    @Default(false) bool isMe,
    required UserModel sender,
    required UserModel receiver,
    @Default([]) List<String> images,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<AssetEntity> assets,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  String get avatar => isMe ? sender.avatar : receiver.avatar;
  String get name => isMe ? sender.name : receiver.name;
}
