import '../../../core/config.dart';
import '../../../core/models/creator/creator_model.dart';
import 'creator_online_item.dart';
import 'following_item.dart';

class ListCreator extends StatelessWidget {
  const ListCreator({
    super.key,
    required this.title,
    this.showMore = true,
    this.onlineList = false,
    this.listCreator = const [],
  });
  final String title;
  final bool showMore, onlineList;
  final List<CreatorModel> listCreator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: showMore ? 0 : 8.h,
              ),
              child: Text(
                title,
                style: context.labelMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (showMore)
              Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(0, 32.w),
                    padding: EdgeInsets.all(5.r),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  child: Text(
                    'もっと見る',
                    style: context.labelMedium?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
          ],
        ),
        SizedBox(
          height: onlineList ? 126.h : 164.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: listCreator.length,
            itemBuilder: (context, index) {
              return onlineList
                  ? CreatorOnlineItem(model: listCreator[index])
                  : FollowingItem(model: listCreator[index]);
            },
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
