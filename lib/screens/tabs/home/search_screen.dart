import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/config.dart';
import '../../../core/models/creator/creator_model.dart';
import '../../../providers/search_provider.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import '../../../widgets/commons/button_custom.dart';
import '../../../widgets/search_app_bar.dart';

@RoutePage()
class SearchCreatorScreen extends HookConsumerWidget {
  const SearchCreatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final searchController = useTextEditingController();
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBarCustom(
        searchAppBar: SearchAppBar(
          controller: searchController,
          focusNode: focusNode,
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
                          return _SearchItem(
                            model: creator,
                            name: creator.name,
                            onTap: () {},
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

class _SearchItem extends StatelessWidget {
  const _SearchItem({
    required this.name,
    this.onTap,
    this.model,
  });
  final String name;
  final VoidCallback? onTap;
  final CreatorModel? model;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(16.w, 16.h, 18.w, 16.h),
        leading: CircleAvatar(
          radius: 30.r,
          backgroundImage: CachedNetworkImageProvider(
            model?.avatar ?? '',
          ),
        ),
        horizontalTitleGap: 5.w,
        title: Text(
          model?.name ?? 'いちろう',
          style: context.titleMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: ButtonCustom(
          'フォロー',
          height: 33.h,
          onPressed: onTap,
        ),
      ),
    );
  }
}
