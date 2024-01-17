import '../../../core/config.dart';
import '../../../providers/user_provider.dart';
import '../../../routes/app_routes.gr.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import 'widgets/profile_tab/profile_detail.dart';
import 'widgets/profile_tab/profile_header.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: context.lang.myPage,
        titleSpacing: 16.w,
        actions: [
          IconButtonCustom(
            iconData: Icons.more_horiz,
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: IconButtonCustom(
              iconData: Icons.edit,
              onTap: () {
                context.navigator(const EditProfileRoute());
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(userProvider.select((value) => value.user));
            return Column(
              children: [
                ProfileHeader(user: user),
                ProfileDetail(userType: user?.type),
              ],
            );
          },
        ),
      ),
    );
  }
}
