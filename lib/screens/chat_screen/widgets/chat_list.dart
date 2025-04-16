part of '../chat_screen.dart';

class ChartList extends ConsumerWidget {
  const ChartList(this.chatId, {super.key});
  final String chatId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageAsync = ref.watch(chartProvider(chatId));
    return messageAsync.maybeWhen(
      orElse: () => const SizedBox.shrink(),
      loading: () => const Loading(),
      success: (messages) {
        return AnimatedList(
          controller: ref.read(chartProvider(chatId).notifier).scroll,
          padding: EdgeInsets.zero,
          key: ref.read(chartProvider(chatId).notifier).listKey,
          initialItemCount: messages.length,
          reverse: true,
          itemBuilder: (_, int index, Animation<double> animation) {
            final message = messages.elementAt(index);
            return ChartListItem(
              message: message,
              chatId: chatId,
              animation,
            );
          },
        );
      },
    );
  }
}
