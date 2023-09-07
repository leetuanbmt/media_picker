import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';

class LoginBySocial extends StatelessWidget {
  const LoginBySocial({
    super.key,
    this.tapFaceBookButton,
    this.tapGoogleButton,
    this.tapTwitterButton,
  });

  final VoidCallback? tapGoogleButton;
  final VoidCallback? tapFaceBookButton;
  final VoidCallback? tapTwitterButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 49.h,
        ),
        Text(
          'SNSアカウントでログイン',
          style: context.bodyMedium!.copyWith(
            fontSize: 14.sp,
            color: AppTheme.blackBold,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        SizedBox(
          height: 48.h,
          width: 184.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: tapTwitterButton,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Assets.iconsIconTwitter.svg(
                  height: 48.h,
                  width: 48.w,
                ),
              ),
              InkWell(
                onTap: tapGoogleButton,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Assets.iconsIconGoogle.svg(
                  height: 48.h,
                  width: 48.w,
                ),
              ),
              InkWell(
                onTap: tapFaceBookButton,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Assets.iconsIconFacebook.svg(
                  height: 48.h,
                  width: 48.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LoginByFaceID extends StatelessWidget {
  const LoginByFaceID({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.h,
        ),
        Text(
          'Face IDでログイン',
          style: context.bodyMedium!.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.fontBoldLight,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        InkWell(
          onTap: () {},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Assets.iconsIconFaceId.svg(
            height: 54.h,
            width: 54.w,
          ),
        ),
      ],
    );
  }
}
