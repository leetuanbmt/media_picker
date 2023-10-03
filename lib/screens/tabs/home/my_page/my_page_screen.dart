import 'package:flutter/cupertino.dart';

import '../../../../core/config.dart';
import '../../../../core/models/creator/creator_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../providers/my_page_provider.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/dialogs.dart';
import 'widgets/my_page_body.dart';
import 'widgets/my_page_footer.dart';
import 'widgets/user_information.dart';

@RoutePage()
class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen({super.key, required this.creator});

  final CreatorModel creator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = context.titleMedium!.copyWith(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xffEB5757),
    );

    final myPage = ref.watch(myPageProvider);

    return Scaffold(
      backgroundColor: AppTheme.primaryColor.withOpacity(0.05),
      appBar: AppBar(
        leading: SizedBox.square(
          dimension: 32.h,
          child: InkWell(
            onTap: () {
              context.back();
            },
            child: Assets.iconsIconBackArrow.svg(
              width: 8.w,
              height: 15.11.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        actions: [
          Container(
            height: 31.63.h,
            width: 106.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30.r),
              ),
              color: AppTheme.pink,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.iconsIconOnline.svg(
                  height: 16.81.h,
                  width: 15.w,
                ),
                SizedBox(
                  width: 6.w,
                ),
                Text(
                  'オンライン',
                  style: context.labelMedium!.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (ctx) {
                  return CupertinoActionSheet(
                    title: Text(
                      'ユーザーを報告する',
                      style: style,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          AppDialog.showAppBottomSheet(
                            context,
                            title: 'ユーザーの報告',
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 110.h,
                                  width: 343.w,
                                  child: TextField(
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      hintText: 'ユーザーの違反行為などを報告',
                                      hintStyle: context.titleSmall!.copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w300,
                                        color: AppTheme.boxFont,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3.r),
                                        ),
                                        borderSide: BorderSide(
                                          width: 1.r,
                                          color: AppTheme.box,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.r)),
                                        borderSide: BorderSide(
                                          width: 1.r,
                                          color: AppTheme.box,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 32.h,
                                ),
                                ButtonCustom(
                                  '報告する',
                                  height: 48.h,
                                  width: 327.w,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    myPage.blockUser();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'ブロックする',
                          style: style.copyWith(
                            color: const Color(0xff007AFF),
                          ),
                        ),
                      ),
                    ],
                    cancelButton: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: style.copyWith(
                          color: const Color(0xff007AFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: myPage.isBlocked ? 222.37.h : 310.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    ),
                    color: AppTheme.primaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserID(creator: creator),
                      SizedBox(
                        height: 6.77.h,
                      ),
                      UserInformation(creator: creator),
                      UserBio(creator: creator),
                      myPage.isBlocked
                          ? Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                  Text(
                                    '${creator.name} さんはブロック\nされています',
                                    style: context.titleMedium!.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  ButtonCustom(
                                    'ブロックを解除',
                                    onPressed: () {
                                      myPage.blockUser();
                                    },
                                    type: ButtonType.outline,
                                    width: 199.w,
                                    height: 50.03.h,
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                const DeviceConnected(),
                                SizedBox(
                                  height: 20.42.h,
                                ),
                                const ListFollowUser(),
                                SizedBox(
                                  height: 22.h,
                                ),
                                const HistoryDonate(
                                  userDonate: 'ミシャさんが',
                                  point: '10000pt',
                                  lastDonate: true,
                                ),
                                const HistoryDonate(
                                  userDonate: 'ダイスケさんが',
                                  point: '100pt',
                                ),
                                const HistoryDonate(
                                  userDonate: 'ダイスケさんが',
                                  point: '100pt',
                                ),
                                Text(
                                  'ユーザーランキング',
                                  style: context.titleMedium!.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.blackBold,
                                  ),
                                ),
                                SizedBox(
                                  height: 11.h,
                                ),
                                ListRankingUser(creator: creator),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  '告知',
                                  style: context.titleMedium!.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.fontGray3,
                                  ),
                                ),
                                Container(
                                  height: 148.h,
                                  width: 351.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r)),
                                  ),
                                  child: const Column(
                                    children: [
                                      UserNotification(
                                        date: '12',
                                        month: '5',
                                        time: '18:00',
                                        content: '鬼合戦フェスタ',
                                        lastNotification: true,
                                      ),
                                      UserNotification(
                                        date: '12',
                                        month: '5',
                                        time: '18:00',
                                        content: '鬼合戦フェスタ',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16.49.h,
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
            myPage.isBlocked ? const SizedBox() : const MyPageFooter(),
          ],
        ),
      ),
    );
  }
}
