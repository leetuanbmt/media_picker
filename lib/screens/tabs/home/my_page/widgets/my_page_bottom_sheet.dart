import 'package:flutter/cupertino.dart';

import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';
import 'my_page_dialog.dart';

class ReportUserBottomSheet extends StatelessWidget {
  const ReportUserBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3.r)),
      borderSide: BorderSide(
        width: 1.r,
        color: AppTheme.box,
      ),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close_sharp,
                  color: AppTheme.icon,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Text(
              context.tr(LocaleKeys.userReports),
              style: context.headlineSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xff4F4F4F),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            SizedBox(
              height: 110.h,
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: context.tr(LocaleKeys.reportViolationsByUser),
                  hintStyle: context.titleSmall!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    color: AppTheme.boxFont,
                  ),
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: context.screenPadding.bottom,
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  return ButtonCustom(
                    context.tr(LocaleKeys.report),
                    height: 48.h,
                    width: 327.w,
                    fontSize: 15.sp,
                    onPressed: () {
                      Navigator.pop(context);
                      ref.read(myPageProvider).blockUser();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoinBottomSheet extends ConsumerWidget {
  const CoinBottomSheet({
    super.key,
  });

  void showDialogSendPoint(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const DelayDialog();
      },
    );
  }

  void showSettingSheet(BuildContext context, String typeSetting) {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxHeight: context.screenHeight * 0.4,
      ),
      isScrollControlled: true,
      builder: (context) {
        return SettingBottomSheet(
          typeSetting: typeSetting,
        );
      },
    );
  }

  void showChargeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxHeight: context.screenHeight * 0.8,
      ),
      isScrollControlled: true,
      builder: (context) {
        return const SelectChargeBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(myPageProvider);

    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    List points = [
      '10',
      '50',
      '100',
      '500',
      '1000',
      '2000',
      '5000',
      '10000',
      '30000',
      '50000',
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24.w,
          right: 24.w,
        ),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close_sharp,
                  color: AppTheme.icon,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      context.tr(LocaleKeys.possessionPoints),
                      style: style.copyWith(
                        fontSize: 14.sp,
                        color: AppTheme.fontGrayLead,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Assets.iconsIcCoin.svg(),
                        SizedBox(
                          width: 6.51.w,
                        ),
                        RichText(
                          text: TextSpan(
                            text: '99999',
                            style: context.titleLarge!.copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: 'pt',
                                style: style,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ButtonCustom(
                  context.tr(LocaleKeys.charge),
                  onPressed: () {
                    showChargeSheet(context);
                  },
                  height: 31.h,
                  width: 103.w,
                  backgroundColor: AppTheme.purple,
                ),
              ],
            ),
            SizedBox(
              height: 32.h,
            ),
            GridView.builder(
              itemCount: points.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.h,
                crossAxisSpacing: 13.48.w,
                mainAxisExtent: 47.h,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Consumer(
                  builder: (context, ref, child) {
                    return ButtonCustom(
                      points[index],
                      height: 48.h,
                      width: 154.66.w,
                      type: ref.watch(
                                myPageProvider.select(
                                  (value) => value.coinSelected,
                                ),
                              ) ==
                              index
                          ? ButtonType.normal
                          : ButtonType.outline,
                      borderWidth: 2.r,
                      fontSize: 16.sp,
                      radius: 12.r,
                      onPressed: () {
                        provider.chooseCoin(index);
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 9.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50.h,
                  width: 154.66.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffF0F3F7),
                    border: Border.all(
                      width: 1.r,
                      color: AppTheme.fontGray,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: provider.coinInputController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.h),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.34.w,
                ),
                Text(
                  'pt',
                  style: style.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.56.h,
            ),
            Consumer(
              builder: (context, ref, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SwitchButtonSetting(
                      context.tr(LocaleKeys.delaySetting),
                      provider.delayController.text,
                      ref.watch(
                        myPageProvider.select(
                          (value) => value.isDelaySetting,
                        ),
                      ),
                      () {
                        showSettingSheet(context, 'Delay');
                      },
                      (value) {
                        provider.changeDelaySetting(value);
                      },
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    SwitchButtonSetting(
                      context.tr(LocaleKeys.autoSetting),
                      provider.autoController.text,
                      ref.watch(
                        myPageProvider.select(
                          (value) => value.isAutoSetting,
                        ),
                      ),
                      () {
                        showSettingSheet(context, 'Auto');
                      },
                      (value) {
                        provider.changeAutoSetting(value);
                      },
                    ),
                  ],
                );
              },
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        return SizedBox.square(
                          dimension: 24.r,
                          child: Checkbox(
                            value: ref.watch(
                              myPageProvider.select(
                                (value) => value.isSaveSetting,
                              ),
                            ),
                            side: const BorderSide(
                              color: AppTheme.icon,
                              width: 1,
                            ),
                            onChanged: (bool? value) {
                              provider.changeSaveSetting(value!);
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      context.tr(LocaleKeys.saveSettings),
                      style: style.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 24.19.h,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: context.screenPadding.bottom),
              child: ButtonCustom(
                context.tr(LocaleKeys.sendPoints),
                height: 48.h,
                width: 327.w,
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialogSendPoint(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectChargeBottomSheet extends ConsumerWidget {
  const SelectChargeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chargeSelected = ref.watch(
      myPageProvider.select(
        (value) => value.chargeSelected,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close_sharp,
                  color: AppTheme.icon,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Text(
              context.tr(LocaleKeys.possessionPoints),
              style: context.titleSmall!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.iconsIcCoin.svg(
                  width: 31.32.w,
                  height: 31.97.h,
                ),
                SizedBox(width: 11.65.w),
                Text(
                  '2000',
                  style: context.headlineLarge!.copyWith(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 375.w,
                  height: 74.h,
                  child: Row(
                    children: [
                      Assets.iconsIcCoin.svg(
                        width: 19.16.w,
                        height: 21.9.h,
                      ),
                      SizedBox(
                        width: 8.49.w,
                      ),
                      Text(
                        '500',
                        style: context.titleMedium!.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 190.w,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return ButtonCustom(
                            index == 0 ? '￥650' : '￥1300',
                            width: 88.w,
                            height: 33.h,
                            type: chargeSelected == index
                                ? ButtonType.normal
                                : ButtonType.outline,
                            borderWidth: 2.r,
                            onPressed: () {
                              ref.read(myPageProvider).chooseCharge(
                                    index,
                                  );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: AppTheme.lightGray,
              ),
              itemCount: 5,
            ),
            SizedBox(
              height: 22.h,
            ),
            Consumer(
              builder: (context, ref, child) {
                return Padding(
                  padding:
                      EdgeInsets.only(bottom: context.screenPadding.bottom),
                  child: ButtonCustom(
                    context.tr(LocaleKeys.buy),
                    width: 327.w,
                    height: 48.h,
                    backgroundColor: chargeSelected == -1
                        ? AppTheme.middleGray
                        : AppTheme.primaryColor,
                    onPressed: () {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingBottomSheet extends ConsumerWidget {
  const SettingBottomSheet({
    super.key,
    required this.typeSetting,
  });

  final String typeSetting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(myPageProvider);

    final List<DropdownMenuEntry<String>> autoItems = [
      const DropdownMenuEntry(value: "5回", label: "5回"),
      const DropdownMenuEntry(value: "10回", label: "10回"),
      const DropdownMenuEntry(value: "15回", label: "15回"),
      const DropdownMenuEntry(value: "20回", label: "20回"),
    ];

    final List<DropdownMenuEntry<String>> delayItems = [
      const DropdownMenuEntry(value: "5秒", label: "5秒"),
      const DropdownMenuEntry(value: "10秒", label: "10秒"),
      const DropdownMenuEntry(value: "15秒", label: "15秒"),
      const DropdownMenuEntry(value: "20秒", label: "20秒"),
    ];

    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: AppTheme.box,
      ),
      borderRadius: BorderRadius.circular(4.r),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.17.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close_sharp,
                  color: AppTheme.icon,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Text(
              typeSetting == 'Delay' ? '遅延設定' : 'オート設定',
              style: context.titleLarge!.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              typeSetting == 'Delay'
                  ? '遅延設定についての注釈がここに入ります。'
                  : 'オート設定についての注釈がここに入ります',
              style: context.labelLarge!.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
                color: AppTheme.fontGrayLead,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            DropdownMenu(
              controller: typeSetting == 'Delay'
                  ? provider.delayController
                  : provider.autoController,
              width: 328.37.w,
              textStyle: context.titleMedium!.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
                color: AppTheme.boxFont,
              ),
              dropdownMenuEntries:
                  typeSetting == 'Delay' ? delayItems : autoItems,
              inputDecorationTheme: InputDecorationTheme(
                constraints: BoxConstraints(maxHeight: 48.h),
                focusedBorder: border,
                enabledBorder: border,
                contentPadding: EdgeInsets.only(
                  left: 12.w,
                ),
              ),
              trailingIcon: const Icon(
                color: AppTheme.icon,
                Icons.keyboard_arrow_down_rounded,
              ),
              onSelected: (value) {
                typeSetting == 'Delay'
                    ? provider.delayController.text = value!
                    : provider.autoController.text = value!;
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            ButtonCustom(
              '設定する',
              height: 48.h,
              width: 327.w,
              onPressed: () {
                Navigator.of(context).pop();
                typeSetting == 'Delay'
                    ? provider.changeDelayValue()
                    : provider.changeAutoValue();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchButtonSetting extends StatelessWidget {
  const SwitchButtonSetting(
    this.content,
    this.valueSelected,
    this.valueSetting,
    this.onPressed,
    this.onChanged, {
    super.key,
  });

  final String content;
  final String valueSelected;
  final bool valueSetting;
  final VoidCallback onPressed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );
    return Consumer(
      builder: (context, ref, child) {
        return SizedBox(
          height: 64.h,
          width: 141.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 31.h,
                    width: 51.w,
                    child: CupertinoSwitch(
                      activeColor: AppTheme.primaryColor,
                      value: valueSetting,
                      onChanged: onChanged,
                    ),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    content,
                    style: style.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              if (valueSetting)
                SizedBox(
                  height: 24.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        valueSelected,
                        style: style.copyWith(
                          color: AppTheme.fontGray3,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(48.w, 24.h),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          backgroundColor: AppTheme.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3.r),
                            ),
                            side: BorderSide(
                              width: 1.r,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                        onPressed: onPressed,
                        child: Text(
                          '変更',
                          style: style.copyWith(
                            color: AppTheme.primaryColor,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
