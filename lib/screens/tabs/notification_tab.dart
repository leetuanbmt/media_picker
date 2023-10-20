import 'package:flutter_slidable/flutter_slidable.dart';

import '../../core/config.dart';
import '../../widgets/commons/cache_image.dart';
import '../../widgets/commons/keep_alive_wrapper.dart';

final listKey = GlobalKey<AnimatedListState>();

AnimatedListState? get _animatedList => listKey.currentState;

@RoutePage()
class NotificationScreen extends StatefulHookConsumerWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    _initializeList();
    super.initState();
  }

  Future<void> _initializeList() async {
    _animatedList?.removeAllItems(
      (context, animation) => _NotificationItem(animation: animation),
    );
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      _animatedList?.insertItem(i);
    }
  }

  void removeItem(int index) {
    _animatedList?.removeItem(
      index,
      (context, animation) => _NotificationItem(animation: animation),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(context.tr(LocaleKeys.notification)),
      ),
      body: Column(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: AppTheme.lightGray,
                ),
              ),
            ),
            child: TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2,
                  color: AppTheme.primaryColor,
                ),
                insets: const EdgeInsets.fromLTRB(0.0, 0, 0, -1),
              ),
              labelPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppTheme.primaryColor,
              controller: tabController,
              tabs: [
                Tab(text: context.tr(LocaleKeys.delivery)),
                const Tab(text: '店舖'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                KeepAliveWrapper(
                  child: SlidableAutoCloseBehavior(
                    child: AnimatedList(
                      key: listKey,
                      itemBuilder: (context, index, animation) {
                        return _NotificationItem(
                          index: index,
                          animation: animation,
                          onDeleted: () {
                            removeItem(index);
                          },
                        );
                      },
                    ),
                  ),
                ),
                const Center(
                  child: Text("Maintenance"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({
    required this.animation,
    this.onDeleted,
    this.index,
  });
  final Animation<double> animation;
  final VoidCallback? onDeleted;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Slidable(
        groupTag: 'notification',
        key: index == null ? null : ValueKey("notification_$index"),
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onDeleted?.call(),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.only(left: 16, right: 8),
          leading: const CacheImage(
            image:
                'https://i.pinimg.com/1200x/12/97/75/12977525762d6a9dc87252202b5c5852.jpg',
            dimension: Size.square(50),
            isZoom: true,
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'ここにユーザーからフォローされたなどの情報が入ります',
              style: context.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.blackBold,
                fontSize: 15.sp,
              ),
            ),
          ),
          subtitle: Text(
            '30分前',
            style: context.bodySmall?.copyWith(
              color: AppTheme.fontGrayLead,
              fontSize: 13.sp,
            ),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppTheme.fontGrayLead,
          ),
        ),
      ),
    );
  }
}
