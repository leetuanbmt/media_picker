import '../../../../core/config.dart';
import '../../../../core/models/creator/creator_model.dart';
import '../../../../providers/my_page_provider.dart';
import '../../../../widgets/commons/button_custom.dart';
import 'widgets/my_page_app_bar.dart';
import 'widgets/my_page_body.dart';
import 'widgets/my_page_footer.dart';
import 'widgets/user_information.dart';

@RoutePage()
class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen({super.key, required this.creator});

  final CreatorModel creator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPage = ref.watch(myPageProvider);

    final style = context.titleSmall!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: const MyPageLeading(),
        actions: const [
          UserOnline(),
          MyPageAction(),
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
                                    height: 56.h,
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
                                  'ユーザーランキング',
                                  style: style.copyWith(
                                    color: AppTheme.blackBold,
                                  ),
                                ),
                                SizedBox(
                                  height: 11.h,
                                ),
                                const ListRankingUser(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  '告知',
                                  style: style.copyWith(
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
                    ],
                  ),
                ),
              ],
            ),
            if (!myPage.isBlocked) const MyPageFooter(),
          ],
        ),
      ),
    );
  }
}
