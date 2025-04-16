import '../../../../../core/config.dart';
import '../../../../../core/models/enum/enum.dart';
import '../../../../../core/models/user/user_model.dart';
import '../../../../../core/providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';
import '../../../../../widgets/commons/cache_image.dart';
import 'my_page_body.dart';
import 'user_information.dart';
import 'widget.dart';

class UserOffline extends StatelessWidget {
  const UserOffline({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.blackBold,
    );
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            color: context.primaryColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                CacheImage(
                  image: user.avatar,
                  radius: 100.r,
                  dimension: Size.square(79.r),
                  isZoom: true,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  user.name,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        TextItem(value: context.lang.follow),
                        TextItem(
                          value: user.follow.toCompactCurrency,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 22.w,
                    ),
                    Column(
                      children: [
                        TextItem(value: context.lang.followers),
                        TextItem(
                          value: user.followers.toCompactCurrency,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 22.w,
                    ),
                    Column(
                      children: [
                        Assets.iconsIconApp.svg(height: 15.h),
                        TextItem(
                          value: '${user.points.toCurrency}pt',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 9.h,
                ),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 4.h,
                  children: [
                    ...user.listCategory.map(
                      (e) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.r),
                          ),
                          color: Colors.white,
                        ),
                        child: Text(
                          e,
                          style: context.textTheme.labelMedium!.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: context.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                UserBio(creator: user),
              ],
            ),
          ),
        ),
        user.type == UserType.creator
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 23.93.h,
                    ),
                    Text(
                      context.lang.userRanking,
                      style: style,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    ListRankingUser(
                      padding: 8.w,
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Text(
                      context.lang.inform,
                      style: style,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 148.h,
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
                  ],
                ),
              )
            : const Spacer(),
        SizedBox(
          height: 30.h,
        ),
        Consumer(
          builder: (context, ref, child) {
            final isFollowing = ref.watch(
              myPageProvider.select((value) => value.checkFollowUser(user.id)),
            );
            return isFollowing
                ? Padding(
                    padding: EdgeInsets.only(
                      bottom: context.padding.bottom,
                    ),
                    child: Center(
                      child: ButtonCustom(
                        context.lang.following,
                        backgroundColor:
                            context.primaryColor.withValues(alpha: 0.7),
                        height: 44.h,
                        width: 156.w,
                        fontSize: 15.sp,
                        onPressed: () {},
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      bottom: context.padding.bottom,
                    ),
                    child: Center(
                      child: ButtonCustom(
                        '+ ${context.lang.follow}',
                        type: ButtonType.outline,
                        borderWidth: 2.r,
                        height: 50.h,
                        width: 156.w,
                        fontSize: 18.sp,
                        onPressed: () {
                          ref.read(myPageProvider).followUser(user.id);
                        },
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
