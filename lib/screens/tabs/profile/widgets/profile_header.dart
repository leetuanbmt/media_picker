import '../../../../core/config.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/tag_name_custom.dart';
import 'card_profile.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.labelSmall?.copyWith(
      fontSize: 12.sp,
      color: AppTheme.fontGray3,
      fontWeight: FontWeight.w300,
    );

    return CardProfile(
      radius: 20.r,
      child: Padding(
        padding: EdgeInsets.all(13.r),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 44.r,
                  backgroundImage: const NetworkImage(
                    'https://picsum.photos/250?image=9',
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TagName(
                      name: 'ユーザー名',
                      fontSize: 17,
                    ),
                    Text(
                      'ID:0000000',
                      style: context.labelSmall?.copyWith(
                        color: AppTheme.fontGray3,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    ButtonCustom(
                      'ランキング',
                      height: 28.h,
                      width: 100.w,
                      backgroundColor: const Color(0xff8F3FFC),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                const _TagCustom(
                  title: '配信',
                  color: Color(0xff44D0CB),
                ),
                SizedBox(width: 3.w),
                const _TagCustom(
                  title: 'カテゴリ',
                  color: Color(0xff7B8AFF),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'フォロー',
                      style: titleStyle,
                    ),
                    Text(
                      '0',
                      style: context.labelSmall?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Text(
                        'フォロワー',
                        style: titleStyle,
                      ),
                      Text(
                        '0',
                        style: context.labelSmall?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '獲得ポイント',
                      style: titleStyle,
                    ),
                    Text(
                      '1000',
                      style: context.labelSmall?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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
        style: context.labelSmall?.copyWith(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
