part of '../chat_screen.dart';

class ChatControls extends HookConsumerWidget {
  const ChatControls(this.chatId, {super.key});
  final String chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(chartProvider(chatId).notifier);
    final loading = useState(false);
    final textCtl = useTextEditingController();
    return Material(
      elevation: 10,
      type: MaterialType.card,
      child: Container(
        padding: const EdgeInsets.all(10).copyWith(
          bottom: context.screenPadding.bottom,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Icon(CupertinoIcons.photo, color: context.primary),
                ),
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: textCtl,
                maxLines: 5,
                minLines: 1,
                decoration: const InputDecoration(
                  hintText: "Type a message",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 5, 40, 5),
                  filled: true,
                  enabled: true,
                ),
              ),
            ),
            Container(
              width: 40.r,
              height: 40.r,
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: context.primary,
                shape: BoxShape.circle,
              ),
              child: loading.value
                  ? const LoadingIndicator()
                  : IconButton(
                      icon: const Icon(
                        Icons.send,
                        size: 15,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        final text = textCtl.text;
                        textCtl.clear();
                        loading.value = true;
                        provider.sendMessage(text).whenComplete(
                              () => loading.value = false,
                            );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
