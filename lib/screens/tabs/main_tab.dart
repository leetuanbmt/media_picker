import '../../core/config.dart';
import '../../core/models/activity/activity.dart';
import '../../providers/activity_provider.dart';
import '../../widgets/commons/commons.dart';

@RoutePage()
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activity = ref.watch(activityProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        title: const Text('Main'),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () => ref.refresh(activityProvider.future),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            switch (activity) {
              AsyncValue<Activity>(:final valueOrNull?) =>
                Text(valueOrNull.activity),
              AsyncValue(:final error?) => Text('Oops: $error'),
              _ => const Loading(),
            },
          ],
        ),
        // Consumer(
        //   builder: (context, ref, child) {
        //     final AsyncValue<Activity> activity = ref.watch(activityProvider);
        //     return Center(
        //       child: switch (activity) {
        //         AsyncData(:final value) => Text('Activity: ${value.activity}'),
        //         AsyncError() =>
        //           const Text('Oops, something unexpected happened'),
        //         _ => const CircularProgressIndicator.adaptive(),
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }

  Widget errorWidget(Object error, Object stackTrace) {
    return Center(
      child: Text(error.toString()),
    );
  }
}
