import '../../core/config.dart';

@RoutePage()
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(LocaleKeys.notification)),
      ),
      body: const Center(
        child: Text("Notification Screen"),
      ),
    );
  }
}
