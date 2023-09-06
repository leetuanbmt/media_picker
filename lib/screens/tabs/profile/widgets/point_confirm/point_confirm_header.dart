import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/commons/button_custom.dart';

class PointConfirmHeader extends HookWidget {
  const PointConfirmHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 3);
    final pageController = usePageController(
      initialPage: 0,
      viewportFraction: 0.7,
    );

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 180.h,
        child: ColoredBox(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 132.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                  ),
                  child: PageView.builder(
                    itemCount: 3,
                    pageSnapping: true,
                    padEnds: false,
                    controller: pageController,
                    onPageChanged: tabController.animateTo,
                    itemBuilder: (context, index) {
                      final int itemIndex = index ~/ 2;
                      return Row(
                        children: [
                          const Expanded(child: _PointSlider()),
                          if (itemIndex.isEven) SizedBox(width: 10.w),
                        ],
                      );
                    },
                  ),
                ),
              ),
              TabPageSelector(controller: tabController),
            ],
          ),
        ),
      ),
    );
  }
}

class _PointSlider extends StatelessWidget {
  const _PointSlider();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.primaryColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.iconsIconApp.svg(
                  colorFilter: const ColorFilter.mode(
                    AppTheme.pink,
                    BlendMode.srcATop,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  '保有獲得ポイント',
                  style: context.titleSmall?.copyWith(
                    color: AppTheme.fontGrayLead,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.iconsIcCoin.svg(height: 18.h),
                  SizedBox(width: 5.w),
                  RichText(
                    text: TextSpan(
                      text: '2000',
                      style: context.titleLarge?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: 'pt',
                          style: context.titleSmall?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ButtonCustom(
              'チップ用ポイントに変換',
              height: 36.h,
              width: double.infinity,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
