import '../../../core/config.dart';
import '../../../providers/firebase_provider.dart';
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
            context.navigator(SearchCreatorRoute());
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
                      title: context.tr(LocaleKeys.online),
                      users: result,
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
                return ref.watch(categoriesProvider).when(
                      data: (categories) {
                        return Column(
                          children: categories
                              .map((e) => UserListByCategory(category: e))
                              .toList(),
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

class UserListByCategory extends ConsumerWidget {
  const UserListByCategory({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userByCategory(category));
    return userAsync.maybeWhen(
      data: (users) {
        if (users.isEmpty) return Dimensions.empty;
        return ListCreator(
          title: category,
          users: users,
        );
      },
      orElse: () {
        return Dimensions.empty;
      },
    );
  }
}
