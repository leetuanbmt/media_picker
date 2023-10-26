part of '../chat_screen.dart';

class ChartListItem extends ConsumerWidget {
  const ChartListItem({super.key, required this.message, required this.chatId});
  final Message message;
  final String chatId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = context.bodyMedium;
    return Container(
      constraints: BoxConstraints(maxWidth: context.screenWidth * .8),
      margin: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onLongPress: () => _bottomSheet(context, ref),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CacheImage(
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
                          pattern: r"\[(@[^:]+):([^\]]+)\]",
                          style: style?.copyWith(color: context.primary),
                          renderText: ({required str, required pattern}) {
                            final map = <String, String>{};
                            final customRegExp = RegExp(pattern);
                            final match = customRegExp.firstMatch(str);
                            map['display'] = match?.group(1) ?? '';
                            map['value'] = match?.group(2) ?? '';
                            return map;
                          },
                          onTap: (String userId) {
                            context.toast("User $userId");
                          },
                        ),
                        MatchText(
                          type: ParsedType.EMAIL,
                          style: style?.copyWith(color: Colors.blue),
                          onTap: (email) {
                            context.toast("Email $email");
                          },
                        ),
                        MatchText(
                          type: ParsedType.URL,
                          style: style?.copyWith(color: Colors.blue),
                          onTap: (url) {
                            context.toast("Url $url");
                          },
                        ),
                        MatchText(
                          type: ParsedType.PHONE,
                          style: style?.copyWith(color: Colors.amber),
                          onTap: (phone) {
                            context.toast("Phone $phone");
                          },
                        ),
                        MatchText(
                          pattern: r"\B#+([\w]+)\b",
                          style: style?.copyWith(color: Colors.indigo),
                          onTap: (tag) {
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
    );
  }

  _bottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      builder: (ctx) => ChatBottomActions(
        onDeleted: () {
          ref.read(chartProvider(chatId).notifier).removeItem(message);
        },
      ),
    );
  }
}

class ChatBottomActions extends StatelessWidget {
  const ChatBottomActions({super.key, this.onDeleted});
  final VoidCallback? onDeleted;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.all(12),
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
              height: 4,
              width: 40,
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_border),
            title: const Text("Save post"),
            onTap: () {
              Navigator.maybePop(context);
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
