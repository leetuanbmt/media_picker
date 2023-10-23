import '../../../../../core/config.dart';
import '../../../../../core/models/user/user_model.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';
import 'my_page_body.dart';
import 'my_page_footer.dart';
import 'user_information.dart';
import 'widget.dart';

class UserOnline extends StatelessWidget {
  const UserOnline({
    super.key,
    required this.isBlocked,
    required this.creator,
  });

  final bool isBlocked;
  final UserModel creator;

  @override
  Widget build(BuildContext context) {
    return isBlocked
        ? UserBlocked(user: creator)
        : UserNormal(
            creator: creator,
          );
  }
}

class UserNormal extends StatelessWidget {
  const UserNormal({
    super.key,
    required this.creator,
  });

  final UserModel creator;

  @override
  Widget build(BuildContext context) {
    final style = context.titleSmall!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    );
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 310.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r),
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
                              context.tr(LocaleKeys.userRanking),
                              style: style.copyWith(
                                color: AppTheme.blackBold,
                              ),
                            ),
                            SizedBox(
                              height: 11.h,
                            ),
                            ListRankingUser(
                              padding: 16.w,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              context.tr(LocaleKeys.inform),
                              style: style.copyWith(
                                color: AppTheme.fontGray3,
                              ),
                            ),
                            Container(
                              height: 148.h,
                              width: 351.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.r),
                                ),
                              ),
                              child: const Column(
                                children: [
                                  UserNotification(
                                    date: '12',
                                    month: '5',
                                    time: '18:00',
                                    content: '鬼合戦フェスタ',
                                  ),
                                  UserNotification(
                                    date: '12',
                                    month: '6',
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: context.screenPadding.bottom),
              child: Consumer(
                builder: (context, ref, child) {
                  final isShow = ref.watch(
                    myPageProvider
                        .select((value) => value.showDeviceControlling),
                  );
                  return isShow
                      ? const DeviceControlling()
                      : MyPageFooter(
                          creator: creator,
                        );
                },
              ),
            ),
          ],
        ),
        Consumer(
          builder: (context, ref, child) {
            final isShowTimeRemaining = ref.watch(
              myPageProvider.select((value) => value.isShowTimeRemaining),
            );
            return isShowTimeRemaining
                ? const TimeReMainingIndicator()
                : const SizedBox();
          },
        ),
      ],
    );
  }
}

class UserBlocked extends StatelessWidget {
  const UserBlocked({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 213.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
                color: AppTheme.primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 26.w, top: 19.h),
              child: UserID(creator: user),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 48.h,
                  ),
                  UserInformation(
                    creator: user,
                    isBlocked: true,
                  ),
                  UserBio(creator: user),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 32.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: Text(
            '${user.name} ${context.tr(LocaleKeys.hasBlocked)}',
            style: context.titleMedium!.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
        Consumer(
          builder: (context, ref, child) {
            return ButtonCustom(
              context.tr(LocaleKeys.unblock),
              onPressed: () {
                ref.read(myPageProvider).blockUser();
              },
              type: ButtonType.outline,
              width: 199.w,
              height: 50.03.h,
              fontSize: 18.sp,
              borderWidth: 2.r,
            );
          },
        ),
      ],
    );
  }
}
