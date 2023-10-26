import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/config.dart';
import '../../../providers/firebase_provider.dart';
import '../../../widgets/commons/commons.dart';
import 'widgets/edit_profile/edit_detail.dart';
import 'widgets/edit_profile/edit_profile_header.dart';

@RoutePage()
class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userFuture = ref.watch(userChangeFirebase(userId));

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBarCustom(
        title: context.tr(LocaleKeys.profileSettings),
      ),
      body: SingleChildScrollView(
        child: userFuture.when(
          loading: () => const Loading(),
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
