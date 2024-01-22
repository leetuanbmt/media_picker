import 'package:flutter_svg/svg.dart';

import '../../../../core/config.dart';
import '../../../../core/providers/my_page_provider.dart';
import 'widgets/my_page_dialog.dart';
import 'widgets/my_page_footer.dart';

@RoutePage()
class DeviceConnectedScreen extends StatefulWidget {
  const DeviceConnectedScreen({super.key});

  @override
  State<DeviceConnectedScreen> createState() => _DeviceConnectedScreenState();
}

class _DeviceConnectedScreenState extends State<DeviceConnectedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        MyPageDialog().showDialogSpentAllPoint(context);
        Future.delayed(const Duration(seconds: 3), () {
          context.back();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> deviceConnected = [
      {'device': 'ぬいぐるみ', 'status': false},
      {'device': '扇風機', 'status': true},
    ];

    final style = context.titleSmall!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.lang.connecting,
          style: context.titleLarge!.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xffFFFFFF),
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            context.back();
          },
          icon: Assets.iconsIconArrowLeft.svg(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Container(
              height: 201.91.h,
              width: 343.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
                border: Border.all(color: const Color(0xffFCF9F9)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff555E58).withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
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
                    height: 108.42.h,
                    width: 311.2.w,
                    margin: EdgeInsets.only(top: 9.1.h, bottom: 13.44.h),
                    padding: EdgeInsets.symmetric(horizontal: 9.w),
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F8F7),
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 11.58.h,
                        ),
                        Text(
                          context.lang.underControl,
                          style: context.bodySmall!.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffEB5757),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
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
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        context.lang.addEquipment,
                        style: style.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: context.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Consumer(
            builder: (context, ref, child) {
              final isShow = ref.watch(
                myPageProvider.select((value) => value.showDeviceControlling),
              );
              return isShow
                  ? Padding(
                      padding:
                          EdgeInsets.only(bottom: context.screenPadding.bottom),
                      child: const DeviceControlling(),
                    )
                  : const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class DeviceItem extends StatelessWidget {
  const DeviceItem({
    super.key,
    required this.nameDevice,
    required this.isConnected,
  });

  final String nameDevice;
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    final style = context.titleSmall!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox.square(
              dimension: 24.r,
              child: SvgPicture.asset(
                isConnected
                    ? Assets.iconsIconWifi.path
                    : Assets.iconsIconWifiDisconnect.path,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              nameDevice,
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
    );
  }
}
