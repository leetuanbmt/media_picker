import '../../../../core/config.dart';
import '../../../../core/models/models.dart';
import '../../../../widgets/commons/tag_name_custom.dart';

class CreatorOnlineItem extends ConsumerWidget {
  const CreatorOnlineItem({
    super.key,
    this.creator,
    this.onPressed,
  });

  final UserModel? creator;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 126.w,
        margin: EdgeInsets.only(right: 9.w),
        padding: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: creator?.avatar == null
              ? null
              : DecorationImage(
                  image: context.imageProvider(creator?.avatar ?? ''),
                  fit: BoxFit.cover,
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              margin: EdgeInsets.only(left: 4.w),
              decoration: BoxDecoration(
                color: AppTheme.pink,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                creator?.firstCategory ?? '',
                style: context.labelMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TagName(
              name: creator?.name ?? 'ゆうこ',
              textColor: Colors.white,
              isExpanded: true,
            ),
          ],
        ),
      ),
    );
  }
}
