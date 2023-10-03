import '../../../../core/config.dart';
import '../../../providers/search_provider.dart';
import '../../../routes/app_routes.gr.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import '../../../widgets/creator_item.dart';
import '../../../widgets/search_app_bar.dart';

@RoutePage()
class SearchCreatorScreen extends HookConsumerWidget {
  const SearchCreatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBarCustom(
        searchAppBar: SearchAppBar(
          controller: searchController,
          onChanged: (String val) {
            ref.read(searchNotifier.notifier).searchCreator(val);
          },
        ),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final searchList = ref.watch(searchNotifier);
          return searchList.isEmpty
              ? const Center(child: Text('No data found'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          height: 1,
                          color: AppTheme.lightGray,
                        ),
                        itemCount: searchList.length,
                        itemBuilder: (context, index) {
                          final creator = searchList[index];
                          return CreatorItem(
                            creator: creator,
                            onPressed: () {
                              context.router
                                  .push(MyProfileRoute(creator: creator));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
