import '../../../core/config.dart';
import '../../../core/models/enum/enum.dart';
import '../../../core/routes/app_routes.gr.dart';

@RoutePage()
class SelectAttributeScreen extends StatelessWidget {
  const SelectAttributeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor,
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
                context.lang.selectUserAttributes,
                style: context.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontSize: 24.sp,
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
                context.lang.selectUserAttributesInform,
                style: context.bodySmall!.copyWith(
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
              titleMedium: context.lang.startAsCreator,
              titleSmall: context.lang.forDistributorsOrStores,
              onTap: () {
                context.router
                    .push(RegisterUserRoute(userType: UserType.creator));
              },
            ),
            SizedBox(
              height: 24.h,
            ),
            UserOption(
              svgFile: Assets.iconsIconFan.svg(
                height: 76.h,
                width: 76.w,
              ),
              titleMedium: context.lang.startAsFan,
              titleSmall: context.lang.personWhoTipsMoney,
              onTap: () {
                context.router.push(RegisterUserRoute(userType: UserType.fan));
              },
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
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 140.h,
          width: 335.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    svgFile,
                    SizedBox(
                      width: 12.w,
                    ),
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
                  ],
                ),
                Assets.iconsIconArrowRight.svg(
                  height: 35.h,
                  width: 35.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
