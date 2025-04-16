import '../../../../../core/config.dart';
import '../../../../../core/models/models.dart';
import '../../../../../widgets/commons/button_custom.dart';
import '../../../../../widgets/commons/cache_image.dart';
import '../../../../../widgets/commons/tag_name_custom.dart';
import 'card_profile.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, this.user});
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    final isFan = user?.type == UserType.fan;
    return CardProfile(
      radius: 20.r,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        child: Column(
          children: [
            Row(
              children: [
                CacheImage(
                  radius: 100,
                  dimension: Size.square(88.r),
                  image: user?.avatar,
                  isZoom: true,
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TagName(
                      name: user?.name ?? '',
                      fontSize: 17,
                    ),
                    Text(
                      user?.id ?? 'ID:0000000',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppTheme.fontGray3,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    if (isFan)
                      Row(
                        children: [
                          _TagCustom(
                            title: context.lang.delivery,
                            color: context.primaryColor,
                          ),
                          SizedBox(width: 3.w),
                          _TagCustom(
                            title: context.lang.category,
                            color: const Color(0xff7B8AFF),
                          ),
                        ],
                      )
                    else
                      ButtonCustom(
                        context.lang.ranking,
                        height: 28.h,
                        backgroundColor: const Color(0xff8F3FFC),
                        onPressed: () {},
                      ),
                  ],
                ),
              ],
            ),
            if (!isFan) ...[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                child: Row(
                  children: [
                    _TagCustom(
                      title: context.lang.delivery,
                      color: context.primaryColor,
                    ),
                    SizedBox(width: 3.w),
                    _TagCustom(
                      title: context.lang.category,
                      color: const Color(0xff7B8AFF),
                    ),
                  ],
                ),
              ),
            ] else
              SizedBox(height: 16.h),
            Row(
              children: [
                FollowItem(
                  title: context.lang.follow,
                  subTitle: user?.follow.toCompactCurrency ?? '',
                ),
                FollowItem(
                  title: context.lang.followers,
                  subTitle: user?.followers.toCompactCurrency ?? '',
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                ),
                FollowItem(
                  title: context.lang.earnedPoints,
                  subTitle: user?.points.toCurrency ?? '',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FollowItem extends StatelessWidget {
  const FollowItem({
    super.key,
    required this.title,
    required this.subTitle,
    this.padding,
  });
  final String title, subTitle;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    final titleStyle = context.textTheme.bodySmall?.copyWith(
      color: AppTheme.fontGray3,
      fontWeight: FontWeight.w300,
    );
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          Text(title, style: titleStyle),
          Text(
            subTitle,
            style: titleStyle?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.blackBold,
            ),
          ),
        ],
      ),
    );
  }
}

class _TagCustom extends StatelessWidget {
  const _TagCustom({
    required this.color,
    required this.title,
  });
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: context.textTheme.labelSmall?.copyWith(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
