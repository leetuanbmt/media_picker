import '../../core/config.dart';
import '../../core/models/user/user_model.dart';
import '../../providers/call_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../routes/app_routes.gr.dart';
import '../../widgets/commons/cache_image.dart';
import '../../widgets/commons/indicators/loading_manager.dart';

@RoutePage()
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(LocaleKeys.notification)),
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
                orElse: () => const TurnLoading(),
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
      leading: CacheImage(
        image: user?.avatar,
        dimension: 50,
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
