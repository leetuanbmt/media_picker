import '../core/config.dart';
import '../notifiers/user_notifier.dart';

@RoutePage()
class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Screen'),
      ),
      body: const SafeArea(
        child: UserDetailScreen(userId: "1"),
      ),
    );
  }
}

class UserDetailScreen extends ConsumerWidget {
  const UserDetailScreen({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(getUserDetailProvider(userId));
    return userAsync.when(
      data: (user) => Column(
        children: [
          Text('ID: ${user.id}'),
          Text('Email: ${user.email}'),
          Text('Full name: ${user.fullName}'),
          Text('Avatar: ${user.avatar}'),
        ],
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}
