import 'package:freezed_annotation/freezed_annotation.dart';

import 'message.dart';

part 'state.freezed.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState.initial() = ChartInitial;
  const factory ChatState.loading() = ChatLoading;
  const factory ChatState.success(List<Message> messages) = ChartSuccess;
  const factory ChatState.error({String? message}) = ChatFailure;
}
