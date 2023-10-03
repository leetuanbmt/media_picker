import 'package:flutter_svg/svg.dart';

import '../../../../../core/config.dart';
import '../../../../../core/models/creator/creator_model.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';
import '../../../../../widgets/commons/cache_image.dart';
import '../../../../../widgets/commons/indicators/loading_manager.dart';

class DeviceConnected extends StatelessWidget {
  const DeviceConnected({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> deviceConnected = ['ぬいぐるみ', '扇風機'];

    final style = context.titleMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
    return Container(
      height: 190.2.h,
      width: 343.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
        border: Border.all(color: const Color(0xffFCF9F9)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff555E58).withOpacity(0.09),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18.h,
          ),
          Text(
            '接続中の機器',
            style: context.titleLarge!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: 83.h,
            width: 303.w,
            margin: EdgeInsets.only(top: 9.1.h, bottom: 13.44.h),
            decoration: BoxDecoration(
              color: const Color(0xffF1F8F7),
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 9.h,
                ),
                ...List.generate(2, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.04.w,
                      vertical: 5.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox.square(
                              dimension: 24.r,
                              child: SvgPicture.asset(
                                Assets.iconsIconWifi.path,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              deviceConnected[index],
                              style: style,
                            ),
                            SizedBox(
                              width: 9.w,
                            ),
                            Text(
                              'Magic motion',
                              style: style.copyWith(
                                color: AppTheme.fontGray3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.5.h,
                          width: 19.w,
                          child: SvgPicture.asset(
                            Assets.iconsIconPercentBattery.path,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          Center(
            child: ButtonCustom(
              'コントロールリクエスト',
              height: 32.h,
              width: 212.w,
              type: ButtonType.outline,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryDonate extends StatelessWidget {
  const HistoryDonate({
    super.key,
    required this.userDonate,
    required this.point,
    this.lastDonate = false,
  });

  final String userDonate;
  final String point;
  final bool? lastDonate;

  @override
  Widget build(BuildContext context) {
    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: const Color(0xff0B0C0C),
    );
    return Container(
      width: 343.w,
      height: 36.h,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: lastDonate! ? const Color(0xffFFDC56) : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff555E58).withOpacity(0.09),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 8.w),
            child: Assets.iconsIcCoin.svg(width: 13.r),
          ),
          RichText(
            text: TextSpan(
              text: userDonate,
              style: style,
              children: [
                TextSpan(
                  text: point,
                  style: style.copyWith(
                    color: point == '10000pt'
                        ? const Color(0xff8F3FFC)
                        : AppTheme.primaryColor,
                  ),
                ),
                TextSpan(
                  text: 'おくりしました',
                  style: style,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserNotification extends StatelessWidget {
  const UserNotification({
    super.key,
    required this.date,
    required this.month,
    required this.time,
    required this.content,
    this.lastNotification = false,
  });

  final String date;
  final String month;
  final String time;
  final String content;
  final bool? lastNotification;

  @override
  Widget build(BuildContext context) {
    final style = context.labelMedium!.copyWith(
      fontSize: 10.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        children: [
          Container(
            height: 56.h,
            width: 56.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              color: AppTheme.pink,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$date月',
                  style: style,
                ),
                RichText(
                  text: TextSpan(
                    text: month,
                    style: style.copyWith(fontSize: 18.sp),
                    children: [
                      TextSpan(
                        text: '日',
                        style: style,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: lastNotification! ? 20.w : 12.w,
          ),
          Text(
            '$time～',
            style: style.copyWith(
              fontSize: 12.sp,
              color: AppTheme.pink,
            ),
          ),
          SizedBox(
            width: 17.w,
          ),
          Text(
            content,
            style: style.copyWith(
              fontSize: 12.sp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ListRankingUser extends ConsumerWidget {
  const ListRankingUser({super.key, required this.creator});
  final CreatorModel creator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List colorRank = const [
      Color(0xffDCBB3C),
      Color(0xffBEC2C2),
      Color(0xff895F0D),
      Color(0xff00BAAF),
      Color(0xffFFDC56),
    ];

    final listUser = ref.watch(userRankingProvider);

    return listUser.when(
      data: (result) {
        return SizedBox(
          height: 61.h,
          width: 369.w,
          child: ListView.builder(
            itemCount: listUser.value!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Stack(
                  children: [
                    SizedBox.square(
                      dimension: 61.r,
                    ),
                    Positioned(
                      bottom: 0,
                      child: CacheImage(
                        image: listUser.value![index],
                        radius: 100.r,
                        dimension: 58.r,
                      ),
                    ),
                    Positioned(
                      left: 39.w,
                      top: 0,
                      child: SizedBox.square(
                        dimension: 22.r,
                        child: CircleAvatar(
                          backgroundColor: colorRank[index],
                          child: Text(
                            (index + 1).toString(),
                            style: context.labelMedium!.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.background,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
      error: (error, stackTrace) => Text('Error: $error'),
      loading: () => const TurnLoading(),
    );
  }
}

class ListFollowUser extends ConsumerWidget {
  const ListFollowUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listUser = ref.watch(userFollowProvider);

    return listUser.when(
      data: (result) {
        return Row(
          children: [
            Wrap(
              spacing: 4.w,
              children: [
                ...List.generate(
                  listUser.value!.length,
                  (index) => CacheImage(
                    image: listUser.value![index],
                    dimension: 34.r,
                    radius: 100.r,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 8.w,
            ),
            Container(
              width: 48.w,
              height: 28.h,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(100.r)),
              ),
              child: Center(
                child: Text(
                  '+391',
                  style: context.labelMedium!.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => Text('Error: $error'),
      loading: () => const TurnLoading(),
    );
  }
}
