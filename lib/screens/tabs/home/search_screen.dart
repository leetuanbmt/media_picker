import '../../../../core/config.dart';
import '../../../providers/search_provider.dart';
import '../../../routes/app_routes.gr.dart';
import '../../../widgets/commons/commons.dart';
import '../../../widgets/creator_item.dart';
import '../../../widgets/search_app_bar.dart';

@RoutePage()
class SearchCreatorScreen extends HookConsumerWidget {
  const SearchCreatorScreen({super.key, this.category});
  final String? category;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBarCustom(
        searchAppBar: SearchAppBar(
          controller: searchController,
          onChanged: (String val) {
            ref.read(searchNotifier(category).notifier).searchCreator(val);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (category.isNotEmptyAndNotNull) ...[
            category!.text.semiBold.size(16.sp).make().p(16.w),
            const Divider(
              height: 1,
              color: AppTheme.lightGray,
            ),
          ],
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final searchAsync = ref.watch(searchNotifier(category));
                return searchAsync.when(
                  initial: () => const Loading(),
                  loading: () => const Loading(),
                  error: (message) => Center(child: Text(message)),
                  loaded: (users) {
                    if (users.isEmpty) {
                      return Center(
                        child: Text(
                          context.lang.noSearchResult,
                          style: context.bodyMedium,
                        ),
                      );
                    }

                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        color: AppTheme.lightGray,
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final creator = users[index];
                        return CreatorItem(
                          name: creator.name,
                          avatar: creator.avatar,
                          onPressed: () {
                            context.router.push(
                              MyProfileRoute(
                                id: creator.id,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
