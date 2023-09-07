import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';

@RoutePage()
class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.boxFont,
      body: Center(
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
                '登録が完了しました！',
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
      ),
    );
  }
}
