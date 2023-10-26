library chat_module;

import 'package:flutter/cupertino.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

import '../../core/config.dart';
import '../../core/models/models.dart';
import '../../core/utilities/utilities.dart';
import '../../providers/chart/chat_provider.dart';
import '../../widgets/commons/cache_image.dart';
import '../../widgets/commons/indicators/loading.dart';
import '../../widgets/commons/indicators/loading_indicator.dart';

part 'widgets/chat_controls.dart';
part 'widgets/chat_item.dart';
part 'widgets/chat_list.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatId});
  final String chatId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String get chatId => widget.chatId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const AuthAvatar(Size.square(40)),
              Dimensions.width10,
              Text(context.tr(LocaleKeys.announcementDistribution)),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(child: ChartList(chatId)),
            ChatControls(chatId),
          ],
        ),
      ),
    );
  }
}
