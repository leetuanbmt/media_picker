import '../../core/config.dart';
import '../core/models/creator/creator_model.dart';
import '../providers/search_provider.dart';
import '../widgets/commons/app_bar_custom.dart';
import '../widgets/commons/button_custom.dart';
import '../widgets/search_app_bar.dart';

@RoutePage()
class SearchCreatorScreen extends HookConsumerWidget {
  const SearchCreatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final searchController = useTextEditingController();
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBarCustom(
          searchAppBar: SearchAppBar(
            controller: searchController,
            focusNode: focusNode,
            onChanged: (String val) {
              ref.read(searchNotifier.notifier).searchByName(val);
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
                            return _SearchItem(
                              model: searchList[index],
                              name: searchList[index].firstName,
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                    ],
                  );
          },
        ),
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
          backgroundImage: NetworkImage(
            model?.avatar ??
                'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
          ),
        ),
        horizontalTitleGap: 5.w,
        title: Text(
          model?.firstName ?? 'いちろう',
          style: context.titleMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: ButtonCustom(
          'フォロー',
          height: 33,
          onPressed: onTap,
        ),
      ),
    );
  }
}
