import 'dart:math';

import 'package:gmo_media_picker/media_picker.dart';

import '../../core/config.dart';
import '../../core/models/models.dart';
import '../../screens/chat_screen/chat_screen.dart';
import 'chart_state.dart';

final chartProvider = StateNotifierProvider.autoDispose
    .family<ChatProvider, ChatState, String>((ref, chartId) {
  return ChatProvider(chartId);
});

class ChatProvider extends StateNotifier<ChatState> {
  ChatProvider(this.chatId) : super(const ChatState.initial()) {
    getMessageList();
  }
  final String chatId;
  int _page = 0;
  int _totalPage = 0;

  bool get _canLoadMore => _page < _totalPage;

  final messages = <Message>[];

  final listKey = GlobalKey<AnimatedListState>();

  final scroll = ScrollController();

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
    messages.addAll(
      [
        Message(
          type: MessageType.video,
          id: Random().nextInt(10000).toString(),
          sender: sender,
          receiver: receiver,
          timestamp: DateTime.now(),
        ),
        Message(
          type: MessageType.audio,
          id: Random().nextInt(10000).toString(),
          sender: sender,
          receiver: receiver,
          timestamp: DateTime.now(),
        ),
        Message(
          type: MessageType.image,
          id: Random().nextInt(10000).toString(),
          images: [
            'https://firebasestorage.googleapis.com/v0/b/codebase-57bc1.appspot.com/o/chat%2Fimages%2F1647478926922.png?alt=media&token=580fe80b-873b-4597-aabe-0c1cc39c2a2b',
            'https://firebasestorage.googleapis.com/v0/b/codebase-57bc1.appspot.com/o/chat%2Fimages%2F1647478932001.png?alt=media&token=fa0b5ca6-cea5-450e-b221-1f4bf09712dd',
            'https://firebasestorage.googleapis.com/v0/b/codebase-57bc1.appspot.com/o/chat%2Fimages%2F1647478936789.png?alt=media&token=5bc0369c-2494-4706-a120-e8a14b832b94',
          ],
          sender: sender,
          receiver: receiver,
          timestamp: DateTime.now(),
        ),
        Message(
          id: Random().nextInt(10000).toString(),
          message:
              'Using Azure DevOps pipelines, which uses Fastlane under the hood (which in turn uses xcodebuild), but as MS own Azure and GitHub both run off of the same agents. 🙃',
          sender: sender,
          receiver: receiver,
          timestamp: DateTime.now(),
        ),
        Message(
          id: Random().nextInt(10000).toString(),
          message: 'https://flutter.dev',
          sender: sender,
          receiver: receiver,
          type: MessageType.url,
          timestamp: DateTime.now(),
        ),
        Message(
          id: Random().nextInt(10000).toString(),
          message:
              '[@michael:51515151] Hello this is an example of the ParsedText, links like http://www.google.com or http://www.facebook.com are clickable and phone number 444-555-6666 can call too. But you can also do more with this package, for example Bob will change style and David too. foo@gmail.com And the magic number is 42! #react #react-native',
          sender: sender,
          receiver: receiver,
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
      message: text,
      timestamp: DateTime.now(),
      sender: sender,
      receiver: receiver,
    );
    messages.insert(0, message);
    listKey.currentState?.insertItem(0);
    state = ChatState.success(messages);
    scroll.animateTo(0, duration: 3.milliseconds, curve: Curves.easeOut);
  }

// remove message from list
  void removeItem(Message message) {
    listKey.currentState?.removeItem(
      messages.indexOf(message),
      (context, animation) => ChartListItem(
        animation,
        message: message,
        chatId: chatId,
      ),
    );
    messages.remove(message);
    state = ChatState.success(messages);
  }

  void chooseMedia(BuildContext context) {
    AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        requestType: RequestType.image,
      ),
    ).then((images) async {
      if (images == null) return;
      final message = Message(
        id: Random().nextInt(10000).toString(),
        timestamp: DateTime.now(),
        sender: sender,
        receiver: receiver,
        assets: images,
        type: MessageType.image,
      );
      messages.insert(0, message);
      listKey.currentState?.insertItem(0);
      state = ChatState.success(messages);
    });
  }
}
