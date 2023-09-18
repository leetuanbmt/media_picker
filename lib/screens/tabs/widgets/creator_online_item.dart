import '../../../core/config.dart';
import '../../../core/models/creator/creator_model.dart';
import '../../../widgets/commons/category_picker.dart';

class CreatorOnlineItem extends StatelessWidget {
  const CreatorOnlineItem({
    super.key,
    this.model,
  });

  final CreatorModel? model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CategoryPicker.show(context);
      },
      child: Container(
        width: 126.w,
        margin: EdgeInsets.only(right: 9.w),
        padding: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: NetworkImage(
              model?.avatar ??
                  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
            ),
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
                model?.category ?? '👗ファッション',
                style: context.labelMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model?.name ?? 'ゆうこ',
                  style: context.labelMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                2.widthBox,
                CircleAvatar(
                  radius: 8.r,
                  child: Icon(Icons.check, size: 12.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
