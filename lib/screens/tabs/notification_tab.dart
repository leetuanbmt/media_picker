import '../../core/config.dart';
import '../contact_list.dart';

@RoutePage()
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ContactList();
  }
}
