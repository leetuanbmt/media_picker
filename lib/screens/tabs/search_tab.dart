import '../../core/config.dart';
import '../../providers/firebase_provider.dart';
import '../../routes/app_routes.gr.dart';
import '../../widgets/commons/app_bar_custom.dart';
import '../../widgets/search_app_bar.dart';
import 'home/widgets/following_item.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        leading: const QRLeading(),
        searchAppBar: SearchAppBar(
          readOnly: true,
          onTap: () {
            context.navigator(const SearchCreatorRoute());
          },
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: Text(
                  context.tr(LocaleKeys.recommendation),
                  style: context.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Consumer(
                builder: (context, ref, child) {
                  final listCreator = ref.watch(creatorOnlineProvider);
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: SizedBox(
                      height: 164.h,
                      child: listCreator.maybeWhen(
                        data: (items) => ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return FollowingItem(
                              creator: items.elementAt(index),
                              onPressed: () async {},
                            );
                          },
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                color: AppTheme.surface,
                height: 10,
                thickness: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: Text(
                  context.tr(LocaleKeys.searchByCategory),
                  style: context.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(categoriesProvider).maybeWhen(
                      data: (categories) => SliverGrid.builder(
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (_, index) {
                          final category = categories[index];
                          return InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                SizedBox.square(
                                  dimension: 64.r,
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                      color: AppTheme.lightGray,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        category.split(" ").first,
                                        style: TextStyle(fontSize: 24.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                HeightBox(5.h),
                                Text(
                                  category.split(" ").last,
                                  style: context.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      orElse: () => const SliverToBoxAdapter(),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
