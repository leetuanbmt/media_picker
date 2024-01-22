import '../../../core/config.dart';
import '../../../core/models/models.dart';
import '../../../core/routes/app_routes.gr.dart';
import '../../../widgets/creator_item.dart';

@RoutePage()
class ListUserScreen extends StatelessWidget {
  const ListUserScreen({super.key, required this.items, required this.title});
  final List<UserModel> items;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text(
                  '${items.length}${context.lang.people}',
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Divider(
              color: AppTheme.dividerColor,
              height: 1,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  color: AppTheme.lightGray,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final creator = items[index];
                  return CreatorItem(
                    name: creator.name,
                    avatar: creator.avatar,
                    onPressed: () {
                      context.router.push(MyProfileRoute(id: creator.id));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
