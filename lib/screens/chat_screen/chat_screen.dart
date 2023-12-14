library chat_module;

import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart' hide Size;
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../core/config.dart';
import '../../core/models/models.dart';
import '../../core/utilities/utilities.dart';
import '../../gen/assets.gen.dart';
import '../../providers/chart/chat_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../widgets/commons/commons.dart';
import '../../widgets/commons/zoom_builder/media_builder_preview.dart';

part 'widgets/chat_bottom_actions.dart';
part 'widgets/chat_controls.dart';
part 'widgets/chat_item.dart';
part 'widgets/chat_list.dart';
part 'widgets/chat_text.dart';
part 'widgets/chat_url.dart';
part 'widgets/chat_video.dart';
part 'widgets/chat_audio.dart';
part 'widgets/chat_image.dart';

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
          titleSpacing: 0,
          title: Row(
            children: [
              const AuthAvatar(Size.square(40)),
              Dimensions.width10,
              Flexible(
                child: Text(
                  context.tr(LocaleKeys.announcementDistribution),
                  style: context.titleMedium?.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
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
