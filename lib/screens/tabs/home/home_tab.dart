import '../../../core/config.dart';
import '../../../notifiers/home_notifier.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import '../../../widgets/search_app_bar.dart';
import 'search_screen.dart';
import 'widgets/list_creator.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        leading: const QRLeading(),
        searchAppBar: SearchAppBar(
          readOnly: true,
          onTap: () {
            context.nextPage(const SearchCreatorScreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, _) {
                final listOnline = ref.watch(creatorOnlineProvider);
                return listOnline.when(
                  () => const Text('Initial'),
                  loading: () => const CircularProgressIndicator.adaptive(),
                  loaded: (result) {
                    return ListCreator(
                      title: 'オンライン',
                      onlineList: true,
                      showMore: false,
                      listCreator: result,
                    );
                  },
                  error: (error) => Text('Error: $error'),
                );
              },
            ),
            Divider(color: AppTheme.surface, thickness: 8.h),
            SizedBox(height: 5.h),
            Consumer(
              builder: (context, ref, _) {
                final listFollowing = ref.watch(userFollowingProvider);
                return listFollowing.when(
                  () => const Text('Initial'),
                  loading: () => const CircularProgressIndicator.adaptive(),
                  loaded: (result) {
                    return Column(
                      children: [
                        ...result
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
    );
  }
}
