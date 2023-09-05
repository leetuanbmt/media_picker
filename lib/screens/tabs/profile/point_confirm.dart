// ignore_for_file: unused_import

import 'package:flutter_svg/svg.dart';

import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';
import '../../../widgets/commons/app_bar_custom.dart';
import '../../../widgets/commons/button_custom.dart';
import 'widgets/point_confirm/point_confirm_detail.dart';
import 'widgets/point_confirm/point_confirm_header.dart';

@RoutePage()
class PointConfirmScreen extends HookWidget {
  const PointConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 3);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: const AppBarCustom(
        title: 'ポイント確認',
      ),
      body: CustomScrollView(
        slivers: [
          /// Header
          const PointConfirmHeader(),
          SliverFixedExtentList(
            itemExtent: 10.h,
            delegate: SliverChildListDelegate(
              [SizedBox(height: 8.h)],
            ),
          ),

          /// Appbar Pinned
          PointConfirmDetail(
            context: context,
            tabController: tabController,
          ),

          /// Tabbar View with listview
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                controller: tabController,
                children: [
                  _listHistoryBuilder(
                    itemBuilder: const _TipHistoryItem(),
                  ),
                  _listHistoryBuilder(
                    itemBuilder: const _PurchaseHistoryItem(),
                  ),
                  _listHistoryBuilder(
                    itemBuilder: const _PurchaseHistoryItem(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listHistoryBuilder({
    required Widget itemBuilder,
  }) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: 5,
        itemExtent: 80.h,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 20.h,
        ),
        itemBuilder: (context, index) {
          return itemBuilder;
        },
      ),
    );
  }
}

class _PurchaseHistoryItem extends StatelessWidget {
  const _PurchaseHistoryItem();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: '1000',
                style: context.titleLarge?.copyWith(
                  color: AppTheme.fontBlue,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: 'ポイント',
                    style: context.titleSmall?.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: 'を獲得しました',
                    style: context.titleSmall?.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
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
          '3/3 18:00 ',
          style: context.labelSmall?.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
            color: AppTheme.fontGrayLead,
          ),
        ),
      ],
    );
  }
}

class _TipHistoryItem extends StatelessWidget {
  const _TipHistoryItem();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Assets.iconsIcCoin.svg(),
            SizedBox(width: 7.w),
            RichText(
              text: TextSpan(
                text: '1000',
                style: context.titleLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: 'ポイント',
                    style: context.titleSmall?.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: 'を獲得しました',
                    style: context.titleSmall?.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
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
          '3/3 18:00 ',
          style: context.labelSmall?.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
            color: AppTheme.fontGrayLead,
          ),
        ),
      ],
    );
  }
}
