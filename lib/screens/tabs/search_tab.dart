import '../../core/config.dart';
import '../../core/providers/firebase_provider.dart';
import '../../core/routes/app_routes.gr.dart';
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
            context.navigator(SearchCreatorRoute());
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
                  context.lang.recommendation,
                  style: context.textTheme.titleSmall?.copyWith(
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
                  context.lang.searchByCategory,
                  style: context.textTheme.titleSmall?.copyWith(
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
                          return CategoryItem(category: category);
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

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushRoute(SearchCreatorRoute(category: category));
      },
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
                  category.split(' ').first,
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
            ),
          ),
          Gap(5.h),
          Text(
            category.split(' ').last,
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
