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
    this.listCreator,
  });
  final String title;
  final bool showMore, onlineList;
  final List<CreatorModel>? listCreator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 9.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.labelMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (showMore)
                InkWell(
                  onTap: () {},
                  child: Text(
                    'もっと見る',
                    style: context.labelMedium?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: onlineList ? 136.h : 174.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: listCreator?.length,
            itemBuilder: (context, index) {
              return onlineList
                  ? CreatorOnlineItem(
                      model: listCreator?[index],
                    )
                  : FollowingItem(
                      model: listCreator?[index],
                    );
            },
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
