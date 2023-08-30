import '../../../core/config.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import 'widgets/edit_profile/edit_detail.dart';
import 'widgets/edit_profile/edit_profile_header.dart';

@RoutePage()
class EditProfileScreen extends HookWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: const AppBarCustom(
          title: 'プロフィール設定',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const EditProfileHeader(),
              EditProfileDetail(focusNode: focusNode),
            ],
          ),
        ),
      ),
    );
  }
}
