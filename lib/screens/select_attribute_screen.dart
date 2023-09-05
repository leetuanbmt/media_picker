import '../core/config.dart';
import '../gen/assets.gen.dart';

@RoutePage()
class SelectAttributeScreen extends StatelessWidget {
  const SelectAttributeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 193.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                'ユーザー属性の選択',
                style: context.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                'クリエイター・ファンのどちらで登録しても後から\nいつでも変更できます。',
                style: context.bodyMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 36.h,
            ),
            UserOption(
              svgFile: Assets.iconsIconCreator.svg(
                height: 76.h,
                width: 76.w,
              ),
              titleMedium: "クリエイターとして始める",
              titleSmall: "配信者・店舗の方",
            ),
            SizedBox(
              height: 24.h,
            ),
            UserOption(
              svgFile: Assets.iconsIconFan.svg(
                height: 76.h,
                width: 76.w,
              ),
              titleMedium: "ファンとして始める",
              titleSmall: "投げ銭する方",
            ),
          ],
        ),
      ),
    );
  }
}

class UserOption extends StatelessWidget {
  const UserOption({
    super.key,
    required this.svgFile,
    required this.titleMedium,
    required this.titleSmall,
    this.onTap,
  });

  final Widget svgFile;
  final String titleMedium;
  final String titleSmall;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 140.h,
        width: 335.w,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            svgFile,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    titleMedium,
                    style: context.bodyMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.supportColors.last,
                    ),
                  ),
                ),
                Text(
                  titleSmall,
                  style: context.bodySmall!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.fontGrayLead,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: onTap,
              child: Assets.iconsIconArrowRight.svg(
                height: 35.h,
                width: 35.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
