import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/profile_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';

class PointConfirmHeader extends HookWidget {
  const PointConfirmHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(
      initialPage: 0,
      viewportFraction: 0.7,
    );
    return SliverFixedExtentList(
      itemExtent: 180.h,
      delegate: SliverChildListDelegate(
        [
          ColoredBox(
            color: Colors.white,
            child: Consumer(
              builder: (context, ref, child) {
                final valueChange = ref.watch(pointConfirmChangeCardProvider);
                return Column(
                  children: [
                    SizedBox(
                      height: 140.h,
                      child: PageView.builder(
                        itemCount: 2,
                        pageSnapping: true,
                        padEnds: false,
                        controller: pageController,
                        onPageChanged: (value) {
                          ref
                              .read(pointConfirmChangeCardProvider.notifier)
                              .update((state) => state = value);
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 12.w, top: 18.h),
                            decoration: BoxDecoration(
                              color: const Color(0xffA0D7D4).withOpacity(.5),
                              borderRadius: BorderRadius.circular(10.r),
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
                                      Assets.iconsIcCoin.svg(
                                        height: 18.h,
                                      ),
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
                                              style:
                                                  context.titleSmall?.copyWith(
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
                                  width: 232.w,
                                  fontSize: 15.sp,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          2,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: CircleAvatar(
                              radius: 4.r,
                              backgroundColor: valueChange == index
                                  ? AppTheme.black
                                  : AppTheme.middleGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
