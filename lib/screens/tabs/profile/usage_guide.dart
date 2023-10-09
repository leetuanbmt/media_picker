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
      appBar: AppBarCustom(
        title: context.tr(LocaleKeys.usageGuide),
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
                title: Text(context.tr(LocaleKeys.usageFlow)),
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
                title: Text(context.tr(LocaleKeys.howToPlayGuide)),
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
              child: ListTile(
                title: Text(context.tr(LocaleKeys.inquiry)),
                trailing: const Icon(
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
              child: ListTile(
                title: Text(context.tr(LocaleKeys.termsOfService)),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppTheme.fontGray,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListTile(
                title: Text(context.tr(LocaleKeys.termsOfService)),
                trailing: const Icon(
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
