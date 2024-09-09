import '../../../../../core/config.dart';
import '../../../../../core/models/enum/enum.dart';
import '../../../../../core/providers/my_page_provider.dart';
import '../../../../../core/routes/app_routes.gr.dart';
import '../../../../../widgets/commons/commons.dart';
import '../device_connected.dart';
import 'my_page_bottom_sheet.dart';

class DeviceConnected extends StatelessWidget {
  const DeviceConnected({super.key});

  void controlRequest(BuildContext context, WidgetRef ref) {
    final provider = ref.read(myPageProvider);

    MyPageBottomSheet()
        .showBottomSheet(context, const ControlRequestBottomSheet(), () {
      Future.delayed(const Duration(seconds: 3), () {
        if (!context.mounted) return;
        final controlStatus = provider.requestStatus;
        if (controlStatus == RequestControlStatus.requesting) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  context.lang.controlRequest,
                  style: context.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.primaryColor,
                  ),
                ),
              ),
              duration: const Duration(seconds: 4),
              backgroundColor: Colors.white,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom: context.screenHeight - 140,
                left: 30.w,
                right: 30.w,
              ),
            ),
          );
          provider.updateRequestStatus(RequestControlStatus.underControl);
          provider.updateShowDeviceControlling();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> deviceConnected = [
      {'device': 'ぬいぐるみ', 'status': true},
      {'device': '扇風機', 'status': true},
    ];

    final style = context.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );

    return Container(
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
            context.lang.connectDevices,
            style: style.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
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
                ...List.generate(deviceConnected.length, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.5.w,
                      vertical: 5.h,
                    ),
                    child: DeviceItem(
                      nameDevice: deviceConnected[index]['device'],
                      isConnected: deviceConnected[index]['status'],
                    ),
                  );
                }),
                SizedBox(
                  height: 9.h,
                ),
              ],
            ),
          ),
          Center(
            child: Consumer(
              builder: (context, ref, child) {
                final status = ref.watch(
                  myPageProvider.select((value) => value.requestStatus),
                );
                return status == RequestControlStatus.requestControl
                    ? ButtonCustom(
                        context.lang.controlRequest,
                        height: 32.h,
                        width: 212.w,
                        type: ButtonType.outline,
                        fontSize: 13.sp,
                        onPressed: () {
                          controlRequest(context, ref);
                        },
                      )
                    : status == RequestControlStatus.requesting
                        ? ButtonCustom(
                            context.lang.requesting,
                            height: 32.h,
                            width: 212.w,
                            backgroundColor: context.primary.withOpacity(0.8),
                            onPressed: () {},
                          )
                        : ButtonCustom(
                            context.lang.underControl,
                            height: 32.h,
                            width: 212.h,
                            backgroundColor: context.primary.withOpacity(0.8),
                            onPressed: () {
                              context.router.push(const DeviceConnectedRoute());
                            },
                          );
              },
            ),
          ),
          SizedBox(
            height: 14.46.h,
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
  final bool lastDonate;

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
        color: lastDonate ? const Color(0xffFFDC56) : Colors.white,
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
                    color: lastDonate
                        ? const Color(0xff8F3FFC)
                        : context.primaryColor,
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
  });

  final String date;
  final String month;
  final String time;
  final String content;

  @override
  Widget build(BuildContext context) {
    final style = context.labelSmall!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    return Padding(
      padding: EdgeInsets.only(top: 12.h, left: 12.w),
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
                  '$date${context.lang.day}',
                  style: style.copyWith(
                    fontSize: 10.sp,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: month,
                    style: style.copyWith(fontSize: 18.sp),
                    children: [
                      TextSpan(
                        text: context.lang.month,
                        style: style.copyWith(fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Text(
            '$time～',
            style: style.copyWith(
              color: AppTheme.pink,
            ),
          ),
          SizedBox(
            width: 17.w,
          ),
          Text(
            content,
            style: style.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ListRankingUser extends StatelessWidget {
  const ListRankingUser({super.key, required this.padding});

  final double padding;

  @override
  Widget build(BuildContext context) {
    List colorRank = const [
      Color(0xffDCBB3C),
      Color(0xffBEC2C2),
      Color(0xff895F0D),
      Color(0xff00BAAF),
      Color(0xffFFDC56),
      Color(0xffDCBB3C),
      Color(0xffBEC2C2),
      Color(0xff895F0D),
      Color(0xff00BAAF),
      Color(0xffFFDC56),
    ];

    return Consumer(
      builder: (context, ref, child) {
        final listUser = ref.watch(userRankingProvider);

        return listUser.when(
          data: (result) {
            return SizedBox(
              height: 61.h,
              width: 369.w,
              child: ListView.builder(
                itemCount: result.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: padding),
                    child: Stack(
                      children: [
                        SizedBox.square(
                          dimension: 61.r,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: CacheImage(
                            image: result[index].avatar,
                            radius: 100.r,
                            dimension: Size.square(58.r),
                          ),
                        ),
                        Positioned(
                          right: 0,
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
                },
              ),
            );
          },
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => const Loading(),
        );
      },
    );
  }
}

class ListFollowUser extends StatelessWidget {
  const ListFollowUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final listUser = ref.watch(userFollowProvider);

        return listUser.when(
          data: (result) {
            return Row(
              children: [
                Wrap(
                  spacing: 4.w,
                  children: [
                    ...List.generate(
                      result.length,
                      (index) => CacheImage(
                        image: result[index].avatar,
                        dimension: Size.square(34.r),
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
                    color: context.primaryColor,
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
          loading: () => const Loading(),
        );
      },
    );
  }
}
