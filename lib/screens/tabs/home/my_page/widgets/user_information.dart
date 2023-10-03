import 'package:flutter_svg/svg.dart';

import '../../../../../core/config.dart';
import '../../../../../core/models/creator/creator_model.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/cache_image.dart';

class UserID extends StatelessWidget {
  const UserID({super.key, required this.creator});

  final CreatorModel creator;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'ID:${creator.id}',
          style: context.labelMedium!.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        SizedBox.square(
          dimension: 18.r,
          child: SvgPicture.asset(
            Assets.iconsIconTwitter.path,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        SizedBox.square(
          dimension: 18.r,
          child: SvgPicture.asset(
            Assets.iconsIconFacebook.path,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({super.key, required this.creator});

  final CreatorModel creator;

  @override
  Widget build(BuildContext context) {
    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CacheImage(
              image: creator.avatar,
              radius: 100.r,
              dimension: 92.w,
            ),
            SizedBox(
              width: 16.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  creator.name,
                  style: context.titleLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 7.64.h,
                ),
                SizedBox(
                  width: 203.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'フォロー',
                            style: style,
                          ),
                          Text(
                            creator.follow.toString(),
                            style: style,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'フォロワー',
                            style: style,
                          ),
                          Text(
                            creator.followers.toString(),
                            style: style,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Assets.iconsIconApp.svg(height: 17.h),
                          Text(
                            '${creator.points}pt',
                            style: style,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(6.w, 1.h, 6.w, 0.h),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            creator.category,
            style: style.copyWith(color: AppTheme.primaryColor),
          ),
        ),
        SizedBox(
          height: 9.4.h,
        ),
      ],
    );
  }
}

class UserBio extends ConsumerWidget {
  const UserBio({super.key, required this.creator});

  final CreatorModel creator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPage = ref.watch(myPageProvider);

    double maxLines = (myPage.getTextHeight(
          creator.bio!,
          context.labelMedium!.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          343.61.w,
        ) /
        18);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Text(
              creator.bio!.isNotEmpty ? creator.bio! : 'No bio description',
              style: context.labelMedium!.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines:
                  (maxLines == 1 || creator.bio!.isEmpty || myPage.isBlocked)
                      ? 1
                      : (myPage.showAllBio ? maxLines.toInt() : 2),
            ),
            if (!myPage.showAllBio && maxLines > 1)
              Container(
                width: double.infinity,
                height: 18.h,
                margin: EdgeInsets.only(top: 18.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.primaryColor.withOpacity(0),
                    ],
                  ),
                ),
              ),
          ],
        ),
        if (!ref.watch(myPageProvider).isBlocked)
          Center(
            child: IconButton(
              onPressed: () {
                myPage.showBio();
              },
              icon: Icon(
                myPage.showAllBio
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
      ],
    );
  }
}
