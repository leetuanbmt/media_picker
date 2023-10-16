import '../../../../../core/config.dart';
import '../../../../../core/models/user/user_model.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';
import 'my_page_body.dart';
import 'my_page_footer.dart';
import 'user_information.dart';

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
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: isBlocked ? 213.h : 310.h,
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
                        isBlocked
                            ? UserBlocked(creator: creator)
                            : const UserNormal(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (!isBlocked)
          Padding(
            padding: EdgeInsets.only(bottom: context.screenPadding.bottom),
            child: MyPageFooter(
              creator: creator,
            ),
          ),
      ],
    );
  }
}

class UserNormal extends StatelessWidget {
  const UserNormal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = context.titleSmall!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}

class UserBlocked extends StatelessWidget {
  const UserBlocked({
    super.key,
    required this.creator,
  });

  final UserModel creator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      child: Column(
        children: [
          SizedBox(
            height: 56.h,
          ),
          Text(
            '${creator.name} ${context.tr(LocaleKeys.hasBlocked)}',
            style: context.titleMedium!.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
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
      ),
    );
  }
}
