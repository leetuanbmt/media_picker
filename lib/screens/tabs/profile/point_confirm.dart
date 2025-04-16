import '../../../core/config.dart';
import '../../../core/models/models.dart';
import '../../../core/providers/history_provider.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import 'widgets/point_confirm/point_confirm_detail.dart';
import 'widgets/point_confirm/point_confirm_header.dart';

@RoutePage()
class PointConfirmScreen extends HookConsumerWidget {
  const PointConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tips = ref.watch(historyProvider.select((value) => value.tips));
    final purchase =
        ref.watch(historyProvider.select((value) => value.purchase));
    final transfer =
        ref.watch(historyProvider.select((value) => value.transfer));
    final tabController = useTabController(initialLength: 3);
    return Scaffold(
      appBar: AppBarCustom(
        title: context.lang.checkPoints,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const PointConfirmHeader(),
            SliverToBoxAdapter(
              child: Container(
                color: AppTheme.background,
                height: 10.h,
              ),
            ),
            PointConfirmDetail(
              context: context,
              tabController: tabController,
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            _listHistory(tips),
            _listHistory(purchase),
            _listHistory(transfer),
          ],
        ),
      ),
    );
  }

  Widget _listHistory(List<HistoryModel> histories) {
    return ListView.separated(
      itemCount: histories.length,
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
          height: 1,
          color: AppTheme.lightGray,
        );
      },
      itemBuilder: (context, index) {
        final history = histories[index];
        return HistoryItem(history: history);
      },
    );
  }
}

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.history});
  final HistoryModel history;
  @override
  Widget build(BuildContext context) {
    Color pointColor = switch (history.type) {
      HistoryType.tip => const Color(0xffF4BF1A),
      HistoryType.purchase => const Color(0xffFF9687),
      _ => context.primaryColor,
    };
    return InkWell(
      onTap: () {},
      child: SizedBox(
        height: 80.h,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  if (history.type == HistoryType.tip) ...[
                    Assets.iconsIcCoin.svg(width: 20.r),
                    SizedBox(width: 8.w),
                  ],
                  RichText(
                    text: TextSpan(
                      text: '${history.point}',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: pointColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: MyFontFamily.poppins,
                      ),
                      children: [
                        TextSpan(
                          text: history.suffix,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.fontBoldLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: history.title,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                history.date.format('d/M H:s'),
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: AppTheme.fontGrayLead,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
