import '../core/config.dart';
import '../core/models/models.dart';
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
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(userNotifierProvider);
            return Column(
              children: [
                Expanded(
                  child: state.when(
                    () => const Text('Initial'),
                    loading: () => const Text('Loading'),
                    loaded: (user) => UserInfo(user: user),
                    error: (error) => Text('Error: $error'),
                  ),
                ),
                Center(
                  child: TextButton(
                    child: const Text('Load user'),
                    onPressed: () {
                      ref.read(userNotifierProvider.notifier).getUserInfo('1');
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('ID: ${user.id}'),
        Text('Email: ${user.email}'),
        Text('Full name: ${user.fullName}'),
        Text('Avatar: ${user.avatar}'),
      ],
    );
  }
}
