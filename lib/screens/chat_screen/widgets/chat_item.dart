part of '../chat_screen.dart';

const tagPattern = r"\[(@[^:]+):([^\]]+)\]";
final customRegExp = RegExp(tagPattern);

class ChartListItem extends ConsumerWidget {
  const ChartListItem({super.key, required this.message, required this.chatId});
  final Message message;
  final String chatId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = context.bodyMedium;
    final globalKey = GlobalKey();
    return Container(
      constraints: BoxConstraints(maxWidth: context.screenWidth * .8),
      margin: const EdgeInsets.only(bottom: 15.0),
      child: RepaintBoundary(
        key: globalKey,
        child: GestureDetector(
          onLongPress: () => _bottomSheetActions(context, ref, globalKey),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CacheImage(
                isZoom: true,
                image: message.avatar,
                dimension: const Size.square(40),
                radius: 100,
              ),
              Dimensions.width10,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: message.name,
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Text(
                              ' ${message.timestamp.timeAgo()}',
                              style: context.labelSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 20, 5),
                      child: ParsedText(
                        text: message.message,
                        style: context.bodyMedium,
                        parse: [
                          MatchText(
                            pattern: tagPattern,
                            style: style?.copyWith(color: context.primary),
                            renderText: renderTextTagUser,
                            onTap: (String str) {
                              final match = customRegExp.firstMatch(str)!;
                              context.toast("User ${match[2]}");
                            },
                          ),
                          MatchText(
                            type: ParsedType.EMAIL,
                            style: style?.copyWith(color: Colors.blue),
                            onTap: (String email) {
                              context.toast("Email $email");
                            },
                          ),
                          MatchText(
                            type: ParsedType.URL,
                            style: style?.copyWith(color: Colors.blue),
                            onTap: (String url) {
                              context.toast("Url $url");
                            },
                          ),
                          MatchText(
                            type: ParsedType.PHONE,
                            style: style?.copyWith(color: Colors.amber),
                            onTap: (String phone) {
                              context.toast("Phone $phone");
                            },
                          ),
                          MatchText(
                            pattern: r"\B#+([\w]+)\b",
                            style: style?.copyWith(color: Colors.indigo),
                            onTap: (String tag) {
                              context.toast("Tag $tag");
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// show bottom sheet actions for message
  void _bottomSheetActions(
    BuildContext context,
    WidgetRef ref,
    GlobalKey globalKey,
  ) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      builder: (ctx) => ChatBottomActions(
        onDeleted: () {
          ref.read(chartProvider(chatId).notifier).removeItem(message);
        },
        onShare: () async {
          AppUtils.cropAndShareByKey(globalKey);
        },
      ),
    );
  }

  Map<String, String> renderTextTagUser({
    required String str,
    required String pattern,
  }) {
    final match = customRegExp.firstMatch(str)!;
    return {'display': match[1]!};
  }
}

class ChatBottomActions extends StatelessWidget {
  const ChatBottomActions({
    super.key,
    this.onDeleted,
    this.onShare,
  });
  final VoidCallback? onDeleted, onShare;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Wrap(
        children: [
          Center(
            child: Container(
              height: Dimensions.size5,
              width: Dimensions.size80,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_border),
            title: const Text("Save post"),
            onTap: () {
              Navigator.maybePop(context);
              onShare?.call();
            },
          ),
          ListTile(
            leading: const Icon(Icons.circle_notifications),
            title: const Text("Turn on notification"),
            onTap: () {
              Navigator.maybePop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Share"),
            onTap: () {
              Navigator.maybePop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("Delete"),
            onTap: () {
              Navigator.maybePop(context);
              onDeleted?.call();
            },
          ),
        ],
      ),
    );
  }
}
