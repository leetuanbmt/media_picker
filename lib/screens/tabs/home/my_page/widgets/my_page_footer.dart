import 'package:flutter/cupertino.dart';

import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';

class MyPageFooter extends ConsumerWidget {
  const MyPageFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPage = ref.watch(myPageProvider);

    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    void showCoinSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: myPage.isFollowed ? context.screenHeight * 0.8 : 443.01.h,
        ),
        builder: (context) {
          return const CoinBottomSheet();
        },
      );
    }

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
            return myPage.isFollowed
                ? ButtonCustom(
                    'ポイントをおくる',
                    height: 44.h,
                    width: 327.w,
                    onPressed: () {
                      showCoinSheet();
                    },
                  )
                : Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      ButtonCustom(
                        'ポイントをおくる',
                        height: 44.h,
                        width: 208.w,
                        onPressed: () {
                          showCoinSheet();
                        },
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      ButtonCustom(
                        '+ フォロー',
                        onPressed: () {
                          myPage.followUser();
                        },
                        type: ButtonType.outline,
                        height: 44.h,
                        width: 148.w,
                      ),
                    ],
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
    final myPage = ref.watch(myPageProvider);

    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SizedBox(
          height: context.screenHeight * 0.7,
          width: context.screenWidth,
          child: SingleChildScrollView(
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
                                text: myPage.isFollowed ? '99999' : '0',
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
                      onPressed: () {},
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
                  height: myPage.isFollowed ? 273.h : 104.h,
                  width: 327.24.w,
                  child: GridView.builder(
                    itemCount: myPage.isFollowed
                        ? coinFollowed.length
                        : coinNotFollowed.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 9.24.w,
                      crossAxisSpacing: 9.h,
                      mainAxisExtent: 47.h,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Consumer(
                        builder: (context, ref, child) {
                          return ButtonCustom(
                            myPage.isFollowed
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
                              myPage.chooseCoin(index);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                myPage.isFollowed
                    ? Column(
                        children: [
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.r)),
                                ),
                                child: TextField(
                                  controller: myPage.coinInputController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
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
                            height: 24.h,
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 32.h,
                      ),
                Consumer(
                  builder: ((context, ref, child) {
                    return Row(
                      children: [
                        SwitchButtonSetting(
                          '遅延設定',
                          myPage.delayController.text,
                          ref.watch(
                            myPageProvider.select(
                              (value) => value.isDelaySetting,
                            ),
                          ),
                          () {
                            showSettingSheet('Delay');
                          },
                          (value) {
                            myPage.changeDelaySetting(value);
                          },
                        ),
                        SwitchButtonSetting(
                          'オート設定',
                          myPage.autoController.text,
                          ref.watch(
                            myPageProvider.select(
                              (value) => value.isAutoSetting,
                            ),
                          ),
                          () {
                            showSettingSheet('Auto');
                          },
                          (value) {
                            myPage.changeAutoSetting(value);
                          },
                        ),
                      ],
                    );
                  }),
                ),
                if (myPage.isFollowed)
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
                                    myPage.changeSaveSetting(value!);
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
                SizedBox(
                  height: myPage.isFollowed ? 27.19.h : 12.h,
                ),
                ButtonCustom(
                  'ポイントを送る',
                  height: 48.h,
                  width: 327.w,
                  onPressed: () {},
                ),
              ],
            ),
          ),
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
    final myPage = ref.watch(myPageProvider);

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
                  ? myPage.delayController
                  : myPage.autoController,
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
                    ? myPage.delayController.text = value!
                    : myPage.autoController.text = value!;
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            ButtonCustom(
              '設定する',
              height: 48.h,
              width: 327.w,
              onPressed: () {},
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
          height: 77.h,
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
                Row(
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
                        backgroundColor: AppTheme.background,
                        padding: const EdgeInsets.all(0),
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
            ],
          ),
        );
      },
    );
  }
}
