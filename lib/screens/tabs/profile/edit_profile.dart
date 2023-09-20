import '../../../core/config.dart';
import '../../../providers/firebase_provider.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import '../../../widgets/commons/indicators/loading_manager.dart';
import 'widgets/edit_profile/edit_detail.dart';
import 'widgets/edit_profile/edit_profile_header.dart';

@RoutePage()
class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(firebaseAuthProvider).currentUser!.uid;
    final userFuture = ref.watch(userChangeFirebase(userId));

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: const AppBarCustom(
        title: 'プロフィール設定',
      ),
      body: SingleChildScrollView(
        child: userFuture.when(
          loading: () => const TurnLoading(),
          error: (error, stack) => Center(
            child: Text(error.toString()),
          ),
          data: (user) {
            return Column(
              children: [
                EditProfileHeader(user: user),
                EditProfileDetail(user: user),
              ],
            );
          },
        ),
      ),
    );
  }
}
