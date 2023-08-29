import '../core/config.dart';
import '../core/models/models.dart';
import '../providers/user_provider.dart';

@RoutePage()
class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: AppTheme.lightStatusBar,
        title: const Text('User Screen'),
      ),
      body: const SafeArea(
        child: UserListScreen(),
      ),
    );
  }
}

class UserListScreen extends StatefulHookConsumerWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  final _controller = ScrollController();
  @override
  void initState() {
    _controller.addListener(_listener);

    super.initState();
  }

  void _listener() {
    if (_controller.offset >= _controller.position.maxScrollExtent - 50) {
      ref.read(userListProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_listener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userListProvider);
    final isLoadMore = ref.watch(userListProvider.notifier).isLoadMore;
    return RefreshIndicator.adaptive(
      onRefresh: ref.read(userListProvider.notifier).onRefresh,
      child: Column(
        children: [
          Expanded(
            child: userAsync.when(
              data: (data) => ListView.builder(
                controller: _controller,
                itemCount: data.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = data.data[index];
                  return UserDetailScreen(user: user);
                },
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
            ),
          ),
          if (isLoadMore)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key, required this.user});
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
