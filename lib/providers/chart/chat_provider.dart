import 'dart:math';

import '../../core/config.dart';
import '../../core/models/models.dart';

final chartProvider = StateNotifierProvider.autoDispose
    .family<ChatProvider, ChatState, String>((ref, chartId) {
  return ChatProvider();
});

class ChatProvider extends StateNotifier<ChatState> {
  ChatProvider() : super(const ChatState.initial()) {
    getMessageList();
  }

  int _page = 0;
  int _totalPage = 0;

  bool get _canLoadMore => _page < _totalPage;

  final messages = <Message>[];

  final sender = const UserModel(
    id: 'id',
    email: 'email',
    name: 'Flutter Parsed text',
    avatar:
        'https://afamilycdn.com/150157425591193600/2023/10/12/photo-8-1697085570941464931779-1697097873648-1697097874897831840782.jpg',
  );
  final receiver = const UserModel(
    id: 'id',
    email: 'email',
    name: 'Flutter Parsed text',
    avatar:
        'https://afamilycdn.com/150157425591193600/2023/10/12/photo-8-1697085570941464931779-1697097873648-1697097874897831840782.jpg',
  );
  Future<void> getMessageList() async {
    _page = 0;
    state = const ChatState.loading();
    await Future.delayed(1.seconds);
    messages.addAll(
      [
        Message(
          id: Random().nextInt(10000).toString(),
          message:
              'Using Azure DevOps pipelines, which uses Fastlane under the hood (which in turn uses xcodebuild), but as MS own Azure and GitHub both run off of the same agents. 🙃',
          sender: sender,
          receiver: receiver,
          type: 'text',
          timestamp: DateTime.now(),
        ),
        Message(
          id: Random().nextInt(10000).toString(),
          message:
              "[@michael:51515151] Hello this is an example of the ParsedText, links like http://www.google.com or http://www.facebook.com are clickable and phone number 444-555-6666 can call too. But you can also do more with this package, for example Bob will change style and David too. foo@gmail.com And the magic number is 42! #react #react-native",
          sender: sender,
          receiver: receiver,
          type: 'text',
          timestamp: DateTime.now(),
        ),
      ],
    );
    _totalPage = 1;
    state = ChatState.success(messages);
  }

  Future<void> loadMore() async {
    if (!_canLoadMore) return;
    _page++;
  }

  Future<void> sendMessage(String text) async {
    final message = Message(
      id: Random().nextInt(10000).toString(),
      type: 'text',
      message: text,
      timestamp: DateTime.now(),
      sender: sender,
      receiver: receiver,
    );
    messages.insert(0, message);
    state = ChatState.success(messages);
  }

// remove message from list
  void removeItem(Message message) {
    messages.remove(message);
    state = ChatState.success(messages);
  }
}
