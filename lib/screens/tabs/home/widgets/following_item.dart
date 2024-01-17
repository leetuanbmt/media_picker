import '../../../../core/config.dart';
import '../../../../core/models/models.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/cache_image.dart';
import '../../../../widgets/commons/tag_name_custom.dart';

class FollowingItem extends StatelessWidget {
  const FollowingItem({super.key, this.creator, this.onPressed});

  final UserModel? creator;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136.w,
      margin: EdgeInsets.only(right: 9.w),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppTheme.lightGray,
          width: 1.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CacheImage(
            image: creator?.avatar,
            radius: 100.r,
            dimension: Size.square(64.r),
          ),
          Flexible(
            child: TagName(
              name: creator?.name ?? 'ゆうこ',
              isExpanded: true,
            ),
          ),
          ButtonCustom(
            context.lang.toFollow,
            height: 32.h,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
