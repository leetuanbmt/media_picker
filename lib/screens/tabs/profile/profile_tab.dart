import '../../../core/config.dart';
import '../../../routes/app_routes.gr.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import 'widgets/profile_body.dart';
import 'widgets/profile_header.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBarCustom(
        title: 'マイページ',
        titleSpacing: 16,
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
                context.router.push(const EditProfileRoute());
              },
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }
}
