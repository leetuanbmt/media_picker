import 'package:flutter/cupertino.dart';

import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';

class MyPageFooter extends ConsumerWidget {
  const MyPageFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List coin = ['50', '100', '500', '1000'];

    final myPage = ref.watch(myPageProvider);

    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    void showCoinSheet() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
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
                                  text: '0',
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
                    height: 105.h,
                    width: 327.24.w,
                    child: GridView.builder(
                      itemCount: coin.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 9.24.w,
                        crossAxisSpacing: 9.h,
                        mainAxisExtent: 47.h,
                      ),
                      itemBuilder: (context, index) {
                        return Consumer(
                          builder: (context, ref, child) {
                            return ButtonCustom(
                              coin[index],
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
                  SizedBox(
                    height: 32.h,
                  ),
                  Row(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          return CupertinoSwitch(
                            activeColor: AppTheme.primaryColor,
                            value: ref.watch(
                              myPageProvider.select(
                                (value) => value.isDelaySetting,
                              ),
                            ),
                            onChanged: (value) {
                              myPage.changeDelaySetting(
                                value,
                              );
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 14.w,
                          right: 28.w,
                        ),
                        child: Text(
                          '遅延設定',
                          style: style.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return CupertinoSwitch(
                            activeColor: AppTheme.primaryColor,
                            value: ref.watch(
                              myPageProvider.select(
                                (value) => value.isAutoSetting,
                              ),
                            ),
                            onChanged: (value) {
                              myPage.changeAutoSetting(
                                value,
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: 9.w,
                      ),
                      Text(
                        'オート設定',
                        style: style.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
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
          );
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
