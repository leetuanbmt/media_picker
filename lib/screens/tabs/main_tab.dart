import '../../core/config.dart';
import '../../core/models/activity/activity.dart';
import '../../providers/activity_provider.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('Main'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final AsyncValue<Activity> activity = ref.watch(activityProvider);
          return Center(
            child: switch (activity) {
              AsyncData(:final value) => Text('Activity: ${value.activity}'),
              AsyncError() => const Text('Oops, something unexpected happened'),
              _ => const CircularProgressIndicator.adaptive(),
            },
          );
        },
      ),
    );
  }

  Widget errorWidget(Object error, Object stackTrace) {
    return Center(
      child: Text(error.toString()),
    );
  }
}
