part of '../chat_screen.dart';

class ChatControls extends HookConsumerWidget {
  const ChatControls(this.chatId, {super.key});
  final String chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FlutterMentionsState>();
    final provider = ref.read(chartProvider(chatId).notifier);
    final loading = useState(false);
    const users = [
      UserModel(
        id: 'id',
        email: 'email',
        name: 'Flutter Parsed text',
        avatar:
            'https://afamilycdn.com/150157425591193600/2023/10/12/photo-8-1697085570941464931779-1697097873648-1697097874897831840782.jpg',
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(1, -1),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 10.w,
      ).copyWith(bottom: (context.screenPadding.bottom / 2) + 10.h),
      child: FlutterMentions(
        key: key,
        leading: [
          IconButtonCustom(
            iconData: CupertinoIcons.photo,
            color: context.primary,
            onTap: () {
              AssetPicker.pickAssets(
                context,
              ).then((List<AssetEntity>? assets) {
                Logger.log(
                  assets?.map((e) => e.relativePath).toList().toString(),
                  tag: "assets",
                );
              });
            },
          ),
        ],
        suggestionPosition: SuggestionPosition.Top,
        decoration: const InputDecoration(
          hintText: "Type a message",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 5, 40, 5),
          filled: true,
          enabled: true,
        ),
        maxLines: 5,
        minLines: 1,
        mentions: [
          Mention(
            trigger: "@",
            style: TextStyle(color: context.primary),
            suggestionBuilder: (Map<String, dynamic> data) {
              return Container(
                color: context.colorScheme.surface,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: ExtendedNetworkImageProvider(
                        data['photo'],
                        cache: true,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Text(data['display']),
                  ],
                ),
              );
            },
            data: users.map((UserModel e) {
              final Map<String, dynamic> res = <String, dynamic>{
                'id': e.id,
                'display': e.name,
                'photo': e.avatar,
              };
              return res;
            }).toList(),
          ),
        ],
        trailing: [
          Container(
            width: 40.r,
            height: 40.r,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: context.primary,
              shape: BoxShape.circle,
            ),
            child: loading.value
                ? const LoadingIndicator(color: Colors.white)
                : IconButton(
                    icon: const Icon(
                      Icons.send,
                      size: 15,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Logger.log(key.currentState!.controller!.markupText);
                      final text =
                          key.currentState!.controller!.markupText.trim();
                      if (text.isEmptyOrNull) return;
                      key.currentState!.controller!.clear();
                      loading.value = true;
                      provider
                          .sendMessage(text)
                          .whenComplete(() => loading.value = false);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
