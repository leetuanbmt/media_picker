import '../../../core/config.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35.h),
      child: Assets.iconsIconLogo.svg(
        height: 109.h,
        width: 78.w,
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(
          context.primaryColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
