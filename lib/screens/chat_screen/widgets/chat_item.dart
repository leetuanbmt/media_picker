part of '../chat_screen.dart';

const tagPattern = r"\[(@[^:]+):([^\]]+)\]";
final customRegExp = RegExp(tagPattern);

class ChartListItem extends ConsumerWidget {
  const ChartListItem(
    this.animation, {
    super.key,
    required this.message,
    required this.chatId,
  });
  final Message message;
  final String chatId;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalKey = GlobalKey();
    return SizeTransition(
      sizeFactor: animation,
      child: RepaintBoundary(
        key: globalKey,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
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
                        child: switch (message.type) {
                          MessageType.url => ChatUrl(message),
                          MessageType.image => ChatImage(message),
                          MessageType.video => ChatVideo(message),
                          MessageType.audio => ChatAudio(message),
                          _ => ChatTextWidget(message),
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
}
