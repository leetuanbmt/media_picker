import 'dart:math' as math;

import '../../../../../core/config.dart';
import '../../../../../widgets/commons/button_custom.dart';

class PointConfirmDetail extends StatelessWidget {
  const PointConfirmDetail({
    super.key,
    required this.tabController,
    required this.context,
  });
  final TabController tabController;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 130.h,
        maxHeight: 130.h,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.h, right: 16.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ButtonCustom(
                    context.lang.toDay,
                    onPressed: () {},
                    fontSize: 12.sp,
                    type: ButtonType.outline,
                    height: 23.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    borderWidth: 2,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    elevation: 0,
                    shape: CircleBorder(
                      side: BorderSide(
                        color: context.primaryColor,
                        width: 2.w,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 15.sp,
                      color: context.primaryColor,
                    ),
                  ),
                  Text(
                    context.lang.thisMonth,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: 0,
                    duration: const Duration(milliseconds: 500),
                    child: MaterialButton(
                      onPressed: () {},
                      elevation: 0,
                      shape: CircleBorder(
                        side: BorderSide(
                          color: context.primaryColor,
                          width: 2.w,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15.sp,
                        color: context.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: AppTheme.lightGray,
                    ),
                  ),
                ),
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2,
                      color: context.primaryColor,
                    ),
                    insets: const EdgeInsets.fromLTRB(0.0, 0, 0, -.5),
                  ),
                  labelPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: context.primaryColor,
                  controller: tabController,
                  tabs: [
                    Tab(text: context.lang.chipHistory),
                    Tab(text: context.lang.purchaseHistory),
                    Tab(text: context.lang.transferHistory),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
