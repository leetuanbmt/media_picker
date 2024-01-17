import '../../../../core/config.dart';
import '../../../../providers/firebase_provider.dart';
import '../../../../providers/my_page_provider.dart';
import '../../../../widgets/commons/commons.dart';
import 'widgets/my_page_app_bar.dart';
import 'widgets/user_offline.dart';
import 'widgets/user_online.dart';

@RoutePage()
class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creatorAsync = ref.watch(userChangeFirebase(id));

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: const MyPageLeading(),
        leadingWidth: 82.w,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return creatorAsync.when(
                data: (creator) {
                  return Row(
                    children: [
                      UserStatus(
                        isOnline: creator!.isOnline,
                      ),
                      MyPageAction(
                        isOnline: creator.isOnline,
                      ),
                    ],
                  );
                },
                error: (error, stack) => const SizedBox(),
                loading: () => const SizedBox(),
              );
            },
          ),
        ],
        backgroundColor: context.primaryColor,
      ),
      body: Consumer(
        builder: (context, ref, child) {
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
            loading: () => const Loading(),
          );
        },
      ),
    );
  }
}
