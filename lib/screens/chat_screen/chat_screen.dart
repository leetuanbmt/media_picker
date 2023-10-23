import '../../core/config.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatId});
  final String chatId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(LocaleKeys.announcementDistribution)),
      ),
    );
  }
}

class VideoState extends InheritedWidget {
  const VideoState({
    super.key,
    required super.child,
  });

  static VideoState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoState>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
