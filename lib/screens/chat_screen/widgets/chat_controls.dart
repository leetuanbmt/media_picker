part of '../chat_screen.dart';

class ChatControls extends HookConsumerWidget {
  const ChatControls(this.chatId, {super.key});
  final String chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(chartProvider(chatId).notifier);
    final loading = useState(false);
    final textCtl = useTextEditingController();

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.h, right: 5.w),
            child: IconButtonCustom(
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
          ),
          Expanded(
            child: TextFormField(
              controller: textCtl,
              maxLines: 5,
              minLines: 1,
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
                ? const LoadingIndicator(color: Colors.white)
                : IconButton(
                    icon: const Icon(
                      Icons.send,
                      size: 15,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      final text = textCtl.text.trim();
                      if (text.isEmptyOrNull) return;
                      textCtl.clear();
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
