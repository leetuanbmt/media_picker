import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';

class MyPageFooter extends StatelessWidget {
  const MyPageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    return Column(
      children: [
        Divider(
          color: AppTheme.primaryColor,
        ),
        SizedBox(
          height: 17.14.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: '保持 ',
                style: style.copyWith(
                  color: AppTheme.fontGrayLead,
                ),
                children: [
                  TextSpan(
                    text: '2000',
                    style: context.titleMedium!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: 'pt',
                    style: style.copyWith(
                      color: AppTheme.fontGrayLead,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 7.h,
        ),
        Consumer(
          builder: (context, ref, child) {
            final isFollowed =
                ref.watch(myPageProvider.select((value) => value.isFollowed));

            void showCoinSheet() {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                constraints: BoxConstraints(
                  maxHeight: isFollowed
                      ? context.screenHeight * 0.8
                      : context.screenHeight * 0.5,
                ),
                builder: (context) {
                  return const CoinBottomSheet();
                },
              );
            }

            return isFollowed
                ? ButtonCustom(
                    'ポイントをおくる',
                    height: 44.h,
                    width: 327.w,
                    onPressed: () {
                      showCoinSheet();
                    },
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonCustom(
                          'ポイントをおくる',
                          height: 44.h,
                          width: 208.w,
                          onPressed: () {
                            showCoinSheet();
                          },
                        ),
                        ButtonCustom(
                          '+ フォロー',
                          onPressed: () {
                            ref.read(myPageProvider).followUser();
                          },
                          type: ButtonType.outline,
                          height: 44.h,
                          width: 148.w,
                        ),
                      ],
                    ),
                  );
          },
        ),
        SizedBox(
          height: 20.21.h,
        ),
      ],
    );
  }
}

class CoinBottomSheet extends ConsumerWidget {
  const CoinBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFollowed = ref.watch(myPageProvider).isFollowed;
    final provider = ref.read(myPageProvider);

    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    final bodySmall = context.bodySmall!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.blackBold,
    );
    List coinNotFollowed = ['50', '100', '500', '1000'];
    List coinFollowed = [
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

    void showSettingSheet(String typeSetting) {
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

    void showChargeSheet() {
      showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(
          maxHeight: context.screenHeight * 0.7,
        ),
        isScrollControlled: true,
        builder: (context) {
          return const SelectChargeBottomSheet();
        },
      );
    }

    void showDiaLogSuccess(BuildContext context) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(
            const Duration(seconds: 2),
          ).whenComplete(() {
            Navigator.of(context).pop();
          });
          return Dialog(
            child: SizedBox(
              width: 317.w,
              height: 302.h,
              child: Center(
                child: Assets.iconsIconDonateSuccess.svg(
                  width: 136.w,
                  height: 136.h,
                ),
              ),
            ),
          );
        },
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                      '所持ポイント',
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
                            text: isFollowed ? '99999' : '0',
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
                  'チャージする',
                  onPressed: () {
                    showChargeSheet();
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
            SizedBox(
              height: isFollowed ? 273.h : 104.h,
              width: 327.24.w,
              child: GridView.builder(
                itemCount:
                    isFollowed ? coinFollowed.length : coinNotFollowed.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 9.24.w,
                  crossAxisSpacing: 9.h,
                  mainAxisExtent: 47.h,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Consumer(
                    builder: (context, ref, child) {
                      return ButtonCustom(
                        isFollowed
                            ? coinFollowed[index]
                            : coinNotFollowed[index],
                        height: 47.h,
                        width: 159.w,
                        type: ref.watch(
                                  myPageProvider.select(
                                    (value) => value.coinSelected,
                                  ),
                                ) ==
                                index
                            ? ButtonType.normal
                            : ButtonType.outline,
                        borderWidth: 2.r,
                        radius: 12.r,
                        onPressed: () {
                          provider.chooseCoin(index);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            isFollowed
                ? Padding(
                    padding: EdgeInsets.only(
                      top: 9.h,
                      bottom: 24.h,
                    ),
                    child: Row(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.r)),
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
                  )
                : SizedBox(
                    height: 32.h,
                  ),
            Consumer(
              builder: (context, ref, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SwitchButtonSetting(
                      '遅延設定',
                      provider.delayController.text,
                      ref.watch(
                        myPageProvider.select(
                          (value) => value.isDelaySetting,
                        ),
                      ),
                      () {
                        showSettingSheet('Delay');
                      },
                      (value) {
                        provider.changeDelaySetting(value);
                      },
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    SwitchButtonSetting(
                      'オート設定',
                      provider.autoController.text,
                      ref.watch(
                        myPageProvider.select(
                          (value) => value.isAutoSetting,
                        ),
                      ),
                      () {
                        showSettingSheet('Auto');
                      },
                      (value) {
                        provider.changeAutoSetting(value);
                      },
                    ),
                  ],
                );
              },
            ),
            if (isFollowed)
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
                        '設定を保存する',
                        style: style.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            if (isFollowed)
              SizedBox(
                height: 20.19.h,
              ),
            ButtonCustom(
              'ポイントを送る',
              height: 48.h,
              width: 327.w,
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.white,
                      child: SizedBox(
                        width: 317.w,
                        height: 356.h,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 55.h,
                            ),
                            CircularPercentIndicator(
                              radius: 110.r,
                              lineWidth: 20.r,
                              backgroundColor: const Color(0xffE0E0E0),
                              progressColor: AppTheme.primaryColor,
                              percent: 1,
                              circularStrokeCap: CircularStrokeCap.round,
                              animation: true,
                              animationDuration: 5000,
                              onAnimationEnd: () {
                                Navigator.of(context).pop();
                                showDiaLogSuccess(context);
                              },
                              center: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ポイントをおくるまで',
                                    style: bodySmall.copyWith(
                                      color: AppTheme.fontGrayLead,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'あと',
                                        style: bodySmall,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        '5:00',
                                        style: bodySmall,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        '秒',
                                        style: bodySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'キャンセル',
                                style: context.titleSmall!.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
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
              '所持ポイント',
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
            Expanded(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
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
            ),
            SizedBox(
              height: 22.h,
            ),
            Consumer(
              builder: (context, ref, child) {
                return ButtonCustom(
                  '購入する',
                  width: 327.w,
                  height: 48.h,
                  backgroundColor: chargeSelected == -1
                      ? AppTheme.middleGray
                      : AppTheme.primaryColor,
                  onPressed: () {},
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
