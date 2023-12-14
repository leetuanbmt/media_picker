part of '../chat_screen.dart';

class ChatControls extends HookConsumerWidget {
  const ChatControls(this.chatId, {super.key});
  final String chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FlutterMentionsState>();

    final provider = ref.read(chartProvider(chatId).notifier);

    final loading = useState(false);

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
      child: ref.watch(userListFirestore).maybeWhen(
            orElse: () => Dimensions.empty,
            data: (users) {
              return FlutterMentions(
                key: key,
                leading: [
                  IconButtonCustom(
                    iconData: CupertinoIcons.photo,
                    color: context.primary,
                    onTap: () => provider.chooseMedia(context),
                  ),
                ],
                suggestionPosition: SuggestionPosition.Top,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
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
                    trigger: '@',
                    style: TextStyle(color: context.primary),
                    markupBuilder: (trigger, mention, value) {
                      return '[@$value:$mention]';
                    },
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
                            Text(
                              data['display'],
                              style: context.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    data: users.map((UserModel e) {
                      final res = <String, dynamic>{
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
                              final markupText =
                                  key.currentState!.controller!.markupText;
                              if (markupText.isEmptyOrNull) return;
                              key.currentState!.controller!.clear();
                              loading.value = true;
                              provider
                                  .sendMessage(markupText)
                                  .whenComplete(() => loading.value = false);
                            },
                          ),
                  ),
                ],
              );
            },
          ),
    );
  }
}

class ChooseActionPicker extends StatelessWidget {
  const ChooseActionPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
