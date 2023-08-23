import 'package:flutter_svg/flutter_svg.dart';

import '../../core/config.dart';
import '../../core/models/creator/creator_model.dart';
import '../../gen/assets.gen.dart';
import '../../routes/app_routes.gr.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listCategory = ['お笑い', 'アート', 'メディア'];
    const CreatorModel model = CreatorModel(
      id: 1,
      firstName: 'ゆうこ',
      lastName: '',
      avatar:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
      category: '👗ファッション',
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppTheme.primaryColor,
        title: const _SearchAppBar(),
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            context.router.push(const QRRoute());
          },
          icon: const Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _ListCreator(
              title: 'オンライン',
              showMore: false,
              child: _listCreatorBuilder(
                height: 126.h,
                child: const _UserOnlineItem(model: model),
              ),
            ),
            Divider(
              color: AppTheme.dividerColor2,
              thickness: 8.h,
            ),
            SizedBox(height: 20.h),
            ...listCategory
                .map(
                  (e) => _ListCreator(
                    title: e,
                    child: _listCreatorBuilder(
                      child: const _RecommendUserItem(model: model),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _listCreatorBuilder({
    Widget? child,
    double? height,
  }) {
    return SizedBox(
      height: height ?? 164.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return child;
        },
      ),
    );
  }
}

class _SearchAppBar extends StatelessWidget {
  const _SearchAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      margin: EdgeInsets.only(right: 16.w),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'ユーザー名・IDで検索',
          filled: true,
          fillColor: Colors.white,
          hintStyle: context.labelMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: const Color(0xffAFAFAF),
          ),
          contentPadding: EdgeInsets.zero,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: SvgPicture.asset(
            Assets.iconsIconSearch.path,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}

class _ListCreator extends StatelessWidget {
  const _ListCreator({
    required this.title,
    required this.child,
    this.showMore = true,
  });
  final String title;
  final bool showMore;
  final Widget child;

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
                  color: AppTheme.greyText,
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
        child,
        SizedBox(height: 20.h),
      ],
    );
  }
}

class _RecommendUserItem extends StatelessWidget {
  const _RecommendUserItem({
    required this.model,
  });

  final CreatorModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 9.w),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: const Color(0xffd4d4d4),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 32.r,
            backgroundImage: NetworkImage(
              model.avatar,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.firstName,
                  style: context.labelMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                2.widthBox,
                CircleAvatar(
                  radius: 10,
                  child: Icon(Icons.check, size: 12.sp),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.appTheme.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            child: Text(
              'フォローする',
              style: context.labelMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserOnlineItem extends StatelessWidget {
  const _UserOnlineItem({
    required this.model,
  });

  final CreatorModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 126.w,
      height: 126.h,
      margin: EdgeInsets.only(right: 9.w),
      padding: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: NetworkImage(
            model.avatar,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            margin: EdgeInsets.only(left: 5.w),
            decoration: BoxDecoration(
              color: const Color(0xffEA497B),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              model.category,
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
                model.firstName,
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
    );
  }
}
