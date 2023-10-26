part of '../chat_screen.dart';

class ChartList extends ConsumerWidget {
  const ChartList(this.chatId, {super.key});
  final String chatId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageAsync = ref.watch(chartProvider(chatId));
    return messageAsync.maybeWhen(
      orElse: () => Dimensions.empty,
      loading: () => const Loading(),
      success: (messages) {
        return ListView.builder(
          itemCount: messages.length,
          reverse: true,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            final message = messages.elementAt(index);
            return ChartListItem(message: message, chatId: chatId);
          },
        );
      },
    );
  }
}
