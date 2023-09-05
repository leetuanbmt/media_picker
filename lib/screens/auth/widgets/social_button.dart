import 'package:flutter_svg/svg.dart';

import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.path,
    this.onPressed,
    this.colorFilter,
  });
  final String path;
  final VoidCallback? onPressed;
  final ColorFilter? colorFilter;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SizedBox.square(
        dimension: 48.r,
        child: SvgPicture.asset(
          path,
          fit: BoxFit.contain,
          colorFilter: colorFilter,
        ),
      ),
    );
  }
}

class SocialList extends StatelessWidget {
  const SocialList({
    super.key,
    this.tapGoogleButton,
    this.tapFaceBookButton,
    this.tapTwitterButton,
  });
  final VoidCallback? tapGoogleButton;
  final VoidCallback? tapFaceBookButton;
  final VoidCallback? tapTwitterButton;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SNSアカウントでログイン',
          style: context.bodyMedium!.copyWith(
            fontSize: 14,
            color: AppTheme.blackBold,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 90.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SocialButton(
                onPressed: tapTwitterButton,
                path: Assets.iconsIconTwitter.path,
              ),
              SocialButton(
                onPressed: tapGoogleButton,
                path: Assets.iconsIconGoogle.path,
              ),
              SocialButton(
                onPressed: tapFaceBookButton,
                path: Assets.iconsIconFacebook.path,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
