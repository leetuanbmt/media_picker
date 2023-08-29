import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';

class LoginBySocialOrID extends StatefulWidget {
  const LoginBySocialOrID({super.key});

  @override
  State<LoginBySocialOrID> createState() => _LoginBySocialOrIDState();
}

class _LoginBySocialOrIDState extends State<LoginBySocialOrID> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SNSアカウントでログイン',
          style: context.bodyMedium!.copyWith(
            color: AppTheme.blackBold,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(90.w, 18.h, 90.w, 40.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(highlightColor: Colors.transparent),
                icon: Assets.iconsIconTwitter.svg(
                  height: 48.h,
                  width: 48.w,
                ),
              ),
              IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(highlightColor: Colors.transparent),
                icon: Assets.iconsIconGoogle.svg(
                  height: 48.h,
                  width: 48.w,
                ),
              ),
              IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(highlightColor: Colors.transparent),
                icon: Assets.iconsIconFacebook.svg(
                  height: 48.h,
                  width: 48.w,
                ),
              ),
            ],
          ),
        ),
        Text(
          'Face IDでログイン',
          style: context.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.fontBoldLight,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 20.h),
          child: IconButton(
            icon: Assets.iconsIconFaceId.svg(
              height: 54.h,
              width: 54.w,
            ),
            onPressed: () {},
            style: IconButton.styleFrom(highlightColor: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
