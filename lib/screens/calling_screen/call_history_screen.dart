import '../../core/config.dart';
import '../../core/models/call_history/call_history.dart';
import '../../core/utilities/utilities.dart';
import '../../providers/firebase_provider.dart';
import '../../widgets/commons/cache_image.dart';
import '../../widgets/commons/indicators/loading_manager.dart';

@RoutePage()
class CallHistoryScreen extends ConsumerWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call History'),
      ),
      body: ref.watch(callHistoryProvider).maybeWhen(
            data: (histories) {
              return ListView.builder(
                itemCount: histories.length,
                itemBuilder: (BuildContext context, int index) {
                  final history = histories[index];
                  return CallHistoryItem(history: history);
                },
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Text(error.toString()),
              );
            },
            orElse: () => const TurnLoading(),
          ),
    );
  }
}

class CallHistoryItem extends ConsumerWidget {
  const CallHistoryItem({
    super.key,
    required this.history,
  });

  final CallHistory history;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(firebaseAuthProvider).currentUser?.uid ?? '';
    String avatar = currentUser == history.callerId
        ? history.receiverPic
        : history.callerPic;
    String name = currentUser == history.callerId
        ? history.receiverName
        : history.callerName;
    return ListTile(
      leading: Stack(
        children: [
          CacheImage(
            image: avatar,
            dimension: 50,
            radius: 100,
          ),
          if (history.started != null && history.ended != null)
            TimeDuration(
              started: history.started!,
              ended: history.ended!,
            ),
        ],
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
          children: [
            Icon(
              history.type == DbKey.incoming
                  ? (history.started == null
                      ? Icons.call_missed
                      : Icons.call_received)
                  : Icons.call_made_rounded,
              size: 15,
              color: history.started == null
                  ? Colors.redAccent
                  : AppTheme.primaryColor,
            ),
            Dimensions.width10,
            Text(history.callTime.format('MMMM d, hh:mm')),
          ],
        ),
      ),
      trailing: const Icon(Icons.video_call),
    );
  }
}

class TimeDuration extends StatelessWidget {
  const TimeDuration({super.key, required this.started, required this.ended});
  final DateTime started;
  final DateTime ended;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: totalCall().text.size(10).white.make(),
      ),
    );
  }

  String totalCall() {
    return ended.difference(started).inMinutes < 1
        ? '${ended.difference(started).inSeconds}s'
        : '${ended.difference(started).inMinutes}m';
  }
}
