import '../../../../core/config.dart';
import '../../../../providers/firebase_provider.dart';
import '../../../../providers/my_page_provider.dart';
import '../../../../widgets/commons/indicators/loading_manager.dart';
import 'widgets/my_page_app_bar.dart';
import 'widgets/user_offline.dart';
import 'widgets/user_online.dart';

@RoutePage()
class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: const MyPageLeading(),
        actions: const [
          UserStatus(),
          MyPageAction(),
        ],
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final creatorAsync = ref.watch(userChangeFirebase(id));
          final isBlocked =
              ref.watch(myPageProvider.select((value) => value.isBlocked));

          return creatorAsync.when(
            data: (creator) {
              return creator!.isOnline
                  ? UserOnline(
                      isBlocked: isBlocked,
                      creator: creator,
                    )
                  : UserOffline(
                      user: creator,
                    );
            },
            error: (error, stack) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const TurnLoading(),
          );
        },
      ),
    );
  }
}
