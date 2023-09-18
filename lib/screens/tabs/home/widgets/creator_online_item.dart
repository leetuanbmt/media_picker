import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/config.dart';
import '../../../../core/models/creator/creator_model.dart';
import '../../../../widgets/commons/tag_name_custom.dart';

class CreatorOnlineItem extends ConsumerWidget {
  const CreatorOnlineItem({
    super.key,
    this.model,
  });

  final CreatorModel? model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 126.w,
        margin: EdgeInsets.only(right: 9.w),
        padding: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              model?.avatar ?? '',
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
            TagName(
              name: model?.name ?? 'ゆうこ',
              textColor: Colors.white,
              isExpanded: true,
            ),
          ],
        ),
      ),
    );
  }
}
