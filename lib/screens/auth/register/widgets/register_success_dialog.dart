import '../../../../core/config.dart';
import '../../../../gen/assets.gen.dart';

class RegisterSuccessDialog {
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            height: 165.h,
            width: 342.97.w,
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.all(
                Radius.circular(12.r),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40.01.h,
                ),
                Text(
                  context.tr(LocaleKeys.registerCompleted),
                  style: context.bodyLarge!.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.blackBold,
                  ),
                ),
                SizedBox(
                  height: 21.31.h,
                ),
                Assets.iconsIconSuccess.svg(
                  height: 37.33.h,
                  width: 37.33.w,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
