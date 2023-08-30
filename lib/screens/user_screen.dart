import '../core/config.dart';
import '../core/models/models.dart';
import '../providers/user_provider.dart';
import '../widgets/commons/indicators/loading_manager.dart';

@RoutePage()
class UserScreen extends ConsumerWidget {
  const UserScreen({super.key, required this.userId});
  final int userId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider(userId.toString()));
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: AppTheme.lightStatusBar,
        title: const Text('User Screen'),
      ),
      body: SafeArea(
        child: userAsync.when(
          data: (data) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(data.avatar),
                ),
                Text(data.fullName),
                Text(data.email),
              ],
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(child: TurnLoading()),
        ),
      ),
    );
  }
}

class UserListScreen extends HookConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scroll = useScrollController();
    onLoadMore() {
      if (scroll.offset >= scroll.position.maxScrollExtent - 50) {
        ref.read(userListProvider.notifier).loadMore();
      }
    }

    useEffect(
      () {
        scroll.addListener(onLoadMore);
        return () => scroll.removeListener(onLoadMore);
      },
      [scroll],
    );
    final userAsync = ref.watch(userListProvider);

    final isLoadMore = userAsync.maybeWhen(
      data: (data) => data.isLoadMore,
      orElse: () => false,
    );
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: AppTheme.lightStatusBar,
        title: const Text('List User'),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: ref.read(userListProvider.notifier).onRefresh,
        child: Column(
          children: [
            Expanded(
              child: userAsync.when(
                data: (data) => ListView.builder(
                  controller: scroll,
                  itemCount: data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = data.data[index];
                    return UserDetailScreen(user: user);
                  },
                ),
                loading: () => const Center(child: TurnLoading()),
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
      ),
    );
  }
}

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatar),
      ),
      title: Text(user.fullName),
      subtitle: Text(user.email),
      trailing: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.primaries[user.id % Colors.primaries.length],
        ),
        child: SizedBox.square(
          dimension: 30,
          child: Center(
            child: Text(
              user.id.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      onTap: () {
        context.nextPage(UserScreen(userId: user.id));
      },
    );
  }
}
