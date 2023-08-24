import '../../../core/config.dart';
import '../../../core/models/creator/creator_model.dart';
import '../../../widgets/commons/button_custom.dart';

class FollowingItem extends StatelessWidget {
  const FollowingItem({
    super.key,
    this.model,
  });

  final CreatorModel? model;

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
          CircleAvatar(
            radius: 32.r,
            backgroundImage: NetworkImage(
              model?.avatar ??
                  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model?.firstName ?? 'ゆうこ',
                style: context.labelMedium?.copyWith(
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
          ButtonCustom(
            'フォローする',
            width: 114.w,
            height: 32.h,
            fontSize: 12,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
