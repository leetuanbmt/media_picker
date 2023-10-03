import '../../../core/config.dart';
import '../../../routes/app_routes.gr.dart';
import '../../../widgets/commons/app_bar_custom.dart';

@RoutePage()
class UsageGuideScreen extends StatelessWidget {
  const UsageGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: const AppBarCustom(
        title: '利用ガイド',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.lightGray,
                  ),
                ),
              ),
              child: ListTile(
                title: const Text('利用の流れ'),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppTheme.fontGray,
                ),
                onTap: () {
                  context.navigator(const UsageFlowRoute());
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.lightGray,
                    width: 1,
                  ),
                ),
              ),
              child: ListTile(
                title: const Text('遊び方ガイド'),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppTheme.fontGray,
                ),
                onTap: () {
                  context.navigator(const UsagePlayRoute());
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.lightGray,
                  ),
                ),
              ),
              child: const ListTile(
                title: Text('お問い合わせ'),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: AppTheme.fontGray,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.lightGray,
                  ),
                ),
              ),
              child: const ListTile(
                title: Text('利用規約'),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: AppTheme.fontGray,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const ListTile(
                title: Text('プライバシーポリシー'),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: AppTheme.fontGray,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
