import '../../core/config.dart';
import '../../core/utilities/navigator.dart';
import '../../providers/firebase_provider.dart';
import '../../routes/app_routes.gr.dart';
import '../../widgets/commons/cache_image.dart';
import '../../widgets/commons/indicators/loading_manager.dart';

@RoutePage()
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userListFirestore);
    final callerID = ref.read(firebaseAuthProvider).currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: AppTheme.lightStatusBar,
        backgroundColor: AppTheme.primaryColor,
        title: const Text('Notification'),
      ),
      body: SafeArea(
        child: asyncUser.maybeWhen(
          data: (data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final user = data[index];
              return ListTile(
                leading: CacheImage(
                  image: user.avatar,
                  dimension: 50,
                  radius: 100,
                ),
                title: Text(
                  user.name,
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  user.email,
                  style: context.labelMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppTheme.fontGrayLead,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () {
                    AppNavigator.instance.appRouter.navigate(
                      CallRoute(
                        callerId: callerID!,
                        calleeId: user.id,
                      ),
                    );
                  },
                ),
              );
            },
          ),
          orElse: () => const TurnLoading(),
        ),
      ),
    );
  }
}
