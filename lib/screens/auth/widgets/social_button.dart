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
    this.loginGoogle,
    this.loginFacebook,
    this.loginTwitter,
  });
  final VoidCallback? loginGoogle;
  final VoidCallback? loginFacebook;
  final VoidCallback? loginTwitter;
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
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 90.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SocialButton(
                onPressed: loginTwitter,
                path: Assets.iconsIconTwitter.path,
              ),
              SocialButton(
                onPressed: loginGoogle,
                path: Assets.iconsIconGoogle.path,
              ),
              SocialButton(
                onPressed: loginGoogle,
                path: Assets.iconsIconFacebook.path,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
