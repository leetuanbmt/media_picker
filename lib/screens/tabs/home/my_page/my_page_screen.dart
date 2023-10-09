import '../../../../core/config.dart';
import '../../../../core/models/creator/creator_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../providers/my_page_provider.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/cache_image.dart';
import '../../../../widgets/commons/indicators/loading_manager.dart';
import 'widgets/my_page_app_bar.dart';
import 'widgets/my_page_body.dart';
import 'widgets/my_page_footer.dart';
import 'widgets/user_information.dart';

@RoutePage()
class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    final style = context.titleSmall!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    );

    return Consumer(
      builder: (context, ref, child) {
        final creatorAsync = ref.watch(creatorChangeFirebase(id));
        final isBlocked =
            ref.watch(myPageProvider.select((value) => value.isBlocked));
        return creatorAsync.when(
          data: (creator) {
            return Scaffold(
              backgroundColor: AppTheme.background,
              appBar: AppBar(
                leading: const MyPageLeading(),
                actions: [
                  UserOnline(
                    isOnline: creator.isOnline,
                  ),
                  MyPageAction(creator.isOnline),
                ],
                backgroundColor: AppTheme.primaryColor,
              ),
              body: creator.isOnline
                  ? SingleChildScrollView(
                      child: Column(
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.16.w),
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
                                        ? Center(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 56.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 60.w,
                                                  ),
                                                  child: Text(
                                                    '${creator.name} ${context.tr(LocaleKeys.hasBlocked)}',
                                                    style: context.titleMedium!
                                                        .copyWith(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 25.h,
                                                ),
                                                ButtonCustom(
                                                  context
                                                      .tr(LocaleKeys.unblock),
                                                  onPressed: () {
                                                    ref
                                                        .read(myPageProvider)
                                                        .blockUser();
                                                  },
                                                  type: ButtonType.outline,
                                                  width: 199.w,
                                                  height: 50.03.h,
                                                ),
                                              ],
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                context
                                                    .tr(LocaleKeys.userRanking),
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (!isBlocked) const MyPageFooter(),
                        ],
                      ),
                    )
                  : UserOffline(creator: creator),
            );
          },
          error: (error, stack) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const TurnLoading(),
        );
      },
    );
  }
}

class UserOffline extends StatelessWidget {
  const UserOffline({super.key, required this.creator});

  final CreatorModel creator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 305.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Center(
              child: Column(
                children: [
                  CacheImage(
                    image: creator.avatar,
                    dimension: 79.w,
                    radius: 100.r,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    creator.name,
                    style: context.titleLarge!.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xffFFFFFF),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 84.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextItem(value: context.tr(LocaleKeys.follow)),
                            TextItem(value: creator.follow.toString()),
                          ],
                        ),
                        Column(
                          children: [
                            TextItem(value: context.tr(LocaleKeys.followers)),
                            TextItem(value: creator.followers.toString()),
                          ],
                        ),
                        Column(
                          children: [
                            Assets.iconsIconApp.svg(height: 15.h),
                            TextItem(value: '${creator.points}pt'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(6.w, 1.h, 6.w, 0.h),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text(
                      creator.category,
                      style: context.labelMedium!.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: UserBio(creator: creator),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        Consumer(
          builder: (context, ref, child) {
            final isFollowed =
                ref.watch(myPageProvider.select((value) => value.isFollowed));

            return isFollowed
                ? ButtonCustom(
                    context.tr(LocaleKeys.following),
                    height: 44.h,
                    width: 156.w,
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.7),
                    onPressed: () {},
                  )
                : ButtonCustom(
                    '+ ${context.tr(LocaleKeys.follow)}',
                    onPressed: () {
                      ref.read(myPageProvider).followUser();
                    },
                    type: ButtonType.outline,
                    height: 50.h,
                    width: 156.w,
                  );
          },
        ),
        SizedBox(
          height: 21.h,
        ),
      ],
    );
  }
}
