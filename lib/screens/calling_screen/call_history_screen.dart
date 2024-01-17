import '../../core/config.dart';
import '../../core/models/call_history/call_history.dart';
import '../../core/utilities/utilities.dart';
import '../../providers/call_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../widgets/commons/commons.dart';

@RoutePage()
class CallHistoryScreen extends ConsumerWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.lang.callHistory),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              try {
                final authState = ref.watch(authStateChangesProvider);
                final res = await ref
                    .read(firestoreProvider)
                    .collection(DbCollection.users)
                    .doc(authState.value?.uid)
                    .collection(DbCollection.callHistories)
                    .get();
                for (var element in res.docs) {
                  element.reference.delete();
                }
              } catch (e) {
                Logger.log(e);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            return ref.refresh(callHistoryProvider);
          },
          child: ref.watch(callHistoryProvider).when(
                data: (histories) {
                  if (histories.isEmpty) {
                    return context.buildEmptyList(
                      context.lang.noCallHistory,
                    );
                  }
                  return ListView.builder(
                    itemCount: histories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final history = histories[index];
                      return CallHistoryItem(history: history);
                    },
                  );
                },
                loading: () => const Loading(),
                error: context.buildError,
              ),
        ),
      ),
    );
  }
}

class CallHistoryItem extends ConsumerWidget {
  const CallHistoryItem({super.key, required this.history});
  final CallHistory history;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      leading: Stack(
        children: [
          CacheImage(
            image: history.image,
            dimension: const Size.square(50),
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
        history.name,
        style: context.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            history.type == DbKeys.incoming
                ? (history.started == null
                    ? Icons.call_missed
                    : Icons.call_received)
                : Icons.call_made_rounded,
            size: 15,
            color: history.started == null
                ? Colors.redAccent
                : const Color(0xff47C3BE),
          ),
          Dimensions.width5,
          Text(
            history.time,
            style: context.labelMedium?.copyWith(
              color: AppTheme.fontGrayLead,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.call),
        onPressed: () {
          ref.read(callUtils).dial(
                receiverId: history.uid,
                receiverName: history.name,
                receiverPic: history.image,
              );
        },
      ),
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
          color: context.primaryColor,
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
