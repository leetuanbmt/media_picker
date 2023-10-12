import 'package:flutter_svg/svg.dart';

import '../../../../../core/config.dart';

import '../../../../../core/models/models.dart';
import '../../../../../core/utilities/utilities.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/cache_image.dart';

class UserID extends StatelessWidget {
  const UserID({super.key, required this.creator});

  final UserModel creator;

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

  final UserModel creator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CacheImage(
              image: creator.avatar,
              radius: 100.r,
              dimension: 92.w,
              isZoom: true,
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
                          const TextItem(value: "フォロー"),
                          TextItem(
                            value: creator.follow.toCompactCurrency,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const TextItem(value: 'フォロワー'),
                          TextItem(
                            value: creator.followers.toCompactCurrency,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Assets.iconsIconApp.svg(height: 17.h),
                          TextItem(
                            value: '${creator.points.toCurrency}pt',
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
        if (creator.listCategory.isNotEmpty)
          Container(
            padding: EdgeInsets.fromLTRB(6.w, 1.h, 6.w, 0.h),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              creator.listCategory.first,
              style: context.labelMedium!.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        SizedBox(
          height: 9.4.h,
        ),
      ],
    );
  }
}

class TextItem extends StatelessWidget {
  const TextItem({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.labelMedium!.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}

class UserBio extends ConsumerWidget {
  const UserBio({super.key, required this.creator});

  final UserModel creator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showBio =
        ref.watch(myPageProvider.select((value) => value.showAllBio));
    final isBlocked =
        ref.watch(myPageProvider.select((value) => value.isBlocked));

    double maxLines = (AppUtils.getTextHeight(
          creator.bio!.isNotEmpty ? creator.bio! : 'No bio description',
          context.labelMedium!.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          343.61.w,
        ).h /
        18.h);

    return Consumer(
      builder: (context, ref, child) {
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
                  maxLines: isBlocked
                      ? 1
                      : ((showBio && maxLines >= 2)
                          ? maxLines.toInt()
                          : ((!showBio && maxLines >= 2) ? 2 : 1)),
                ),
                if (!showBio && maxLines >= 2 && !isBlocked)
                  Container(
                    width: double.infinity,
                    height: 18.h,
                    margin: EdgeInsets.only(top: 13.h),
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
            if (!isBlocked)
              Center(
                child: IconButton(
                  onPressed: () {
                    ref.read(myPageProvider).showBio();
                  },
                  icon: Icon(
                    showBio
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
