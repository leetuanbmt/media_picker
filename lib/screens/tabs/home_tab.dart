import '../../core/config.dart';
import '../../notifiers/home_notifier.dart';
import '../../routes/app_routes.gr.dart';
import '../../widgets/commons/app_bar_custom.dart';
import '../../widgets/search_app_bar.dart';
import 'widgets/list_creator.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        searchAppBar: SearchAppBar(
          readOnly: true,
          onTap: () {
            context.router.push(const SearchCreatorRoute());
          },
        ),
        leading: const QRLeading(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Consumer(
                  builder: (context, ref, _) {
                    final listOnline = ref.watch(creatorOnlineProvider);
                    return listOnline.when(
                      () => const Text('Initial'),
                      loading: () => const CircularProgressIndicator.adaptive(),
                      loaded: (list) {
                        return ListCreator(
                          title: 'オンライン',
                          onlineList: true,
                          showMore: false,
                          listCreator: list,
                        );
                      },
                      error: (error) => Text('Error: $error'),
                    );
                  },
                ),
                Divider(color: AppTheme.surface, thickness: 8.h),
                SizedBox(height: 20.h),
                Consumer(
                  builder: (context, ref, _) {
                    final listFollowing = ref.watch(userFollowingProvider);
                    return listFollowing.when(
                      () => const Text('Initial'),
                      loading: () => const CircularProgressIndicator.adaptive(),
                      loaded: (list) {
                        return Column(
                          children: [
                            ...list
                                .map(
                                  (e) => ListCreator(
                                    title: e.title,
                                    listCreator: e.listCreator,
                                  ),
                                )
                                .toList(),
                          ],
                        );
                      },
                      error: (error) => Text('Error: $error'),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
