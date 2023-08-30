import '../../../core/config.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import 'edit_profile.dart';
import 'widgets/profile_tab/profile_detail.dart';
import 'widgets/profile_tab/profile_header.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBarCustom(
        title: 'マイページ',
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
                context.nextPage(const EditProfileScreen());
              },
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            ProfileDetail(),
          ],
        ),
      ),
    );
  }
}
