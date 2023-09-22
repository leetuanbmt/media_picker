import '../../../core/config.dart';
import '../../../providers/home_provider.dart';
import '../../../routes/app_routes.gr.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import '../../../widgets/commons/indicators/loading_manager.dart';
import '../../../widgets/search_app_bar.dart';
import 'widgets/list_creator.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarCustom(
        leading: const QRLeading(),
        searchAppBar: SearchAppBar(
          readOnly: true,
          onTap: () {
            AutoRouter.of(context).push(const SearchCreatorRoute());
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
                return listOnline.maybeWhen(
                  data: (result) {
                    return ListCreator(
                      title: 'Online',
                      listCreator: result,
                      onlineList: true,
                      showMore: false,
                    );
                  },
                  orElse: () => Dimensions.empty,
                );
              },
            ),
            Divider(color: AppTheme.surface, thickness: 8.h),
            SizedBox(height: 5.h),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(creatorByCategory).when(
                      data: (result) {
                        return Column(
                          children: [
                            ...result.entries
                                .map(
                                  (e) => ListCreator(
                                    title: e.key,
                                    listCreator: e.value,
                                    showMore: true,
                                  ),
                                )
                                .toList(),
                          ],
                        );
                      },
                      loading: () => const TurnLoading(),
                      error: (error, stackTrace) => Text('Error: $error'),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
