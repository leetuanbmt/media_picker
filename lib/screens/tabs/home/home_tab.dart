import 'dart:developer';
import 'dart:math';

import '../../../core/config.dart';
import '../../../providers/firebase_provider.dart';
import '../../../widgets/commons/commons.dart';
import '../../../widgets/search_app_bar.dart';
import 'widgets/list_creator.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void headSort(List<int> list, int n) {
    for (int i = n ~/ 2 - 1; i >= 0; i--) {
      heapify(list, n, i);
    }
    for (int i = n - 1; i >= 0; i--) {
      int temp = list[0];
      list[0] = list[i];
      list[i] = temp;
      heapify(list, i, 0);
    }
  }

  void heapify(List<int> list, int n, int i) {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;
    if (l < n && list[l] > list[largest]) {
      largest = l;
    }
    if (r < n && list[r] > list[largest]) {
      largest = r;
    }
    if (largest != i) {
      int swap = list[i];
      list[i] = list[largest];
      list[largest] = swap;
      heapify(list, n, largest);
    }
  }

  void checkSortFunction() {
    Timeline.startSync('checkSortFunction');
    final List<int> numbers =
        List.generate(50000, (index) => Random().nextInt(10000)).toList();
    headSort(numbers, numbers.length);
    Logger.log(numbers);

    /// doSomething();
    Timeline.finishSync();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarCustom(
        leading: const QRLeading(),
        searchAppBar: SearchAppBar(
          readOnly: true,
          onTap: () {
            // context.navigator(SearchCreatorRoute());
            checkSortFunction();
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
                      loading: () => const Loading(),
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
          title: category.removeIcon,
          users: users,
        );
      },
      orElse: () {
        return Dimensions.empty;
      },
    );
  }
}
