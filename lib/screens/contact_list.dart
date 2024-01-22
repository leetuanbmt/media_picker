import '../core/config.dart';
import '../core/models/models.dart';
import '../core/providers/call_provider.dart';
import '../core/providers/firebase_provider.dart';
import '../core/routes/app_routes.gr.dart';
import '../widgets/commons/commons.dart';

class ContactList extends ConsumerWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              context.pushRoute(const CallHistoryRoute());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            return ref.refresh(userListFirestore);
          },
          child: ref.watch(userListFirestore).maybeWhen(
                data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = data[index];
                    return _UserItem(user: user);
                  },
                ),
                error: (error, stackTrace) {
                  return Center(
                    child: Text(
                      error.toString(),
                      style: context.titleMedium,
                    ),
                  );
                },
                orElse: () => const Loading(),
              ),
        ),
      ),
    );
  }
}

class _UserItem extends StatelessWidget {
  const _UserItem({this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      leading: CacheImage(
        image: user?.avatar,
        dimension: const Size.square(50),
        radius: 100,
      ),
      title: Text(
        user?.name ?? '',
        style: context.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        user?.email ?? '',
        style: context.labelMedium?.copyWith(
          fontStyle: FontStyle.italic,
          color: AppTheme.fontGrayLead,
        ),
      ),
      trailing: Consumer(
        builder: (context, ref, child) {
          return IconButton(
            icon: const Icon(Icons.call),
            onPressed: user == null
                ? null
                : () {
                    ref.read(callUtils).dial(
                          receiverId: user!.id,
                          receiverName: user!.name,
                          receiverPic: user!.avatar,
                        );
                  },
          );
        },
      ),
    );
  }
}
