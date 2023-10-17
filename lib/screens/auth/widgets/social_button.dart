import 'dart:io';

import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';

enum SocialType {
  google,
  facebook,
  twitter,
  apple,
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.type,
    this.onPressed,
  });
  final SocialType type;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    Widget child = switch (type) {
      SocialType.google => Assets.iconsIconGoogle.svg(),
      SocialType.twitter => Assets.iconsIcTwitter.svg(),
      SocialType.facebook => Assets.iconsIconFacebook.svg(),
      SocialType.apple => DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.black.withOpacity(0.1),
            ),
          ),
          child: const Icon(Icons.apple, size: 40),
        ),
    };
    return IconButton(
      onPressed: onPressed,
      icon: SizedBox.square(
        dimension: 48.r,
        child: child,
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
    this.loginApple,
  });
  final VoidCallback? loginGoogle;
  final VoidCallback? loginFacebook;
  final VoidCallback? loginTwitter;
  final VoidCallback? loginApple;
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
        Wrap(
          spacing: 10,
          children: [
            SocialButton(
              onPressed: loginTwitter,
              type: SocialType.twitter,
            ),
            SocialButton(
              onPressed: loginGoogle,
              type: SocialType.google,
            ),
            SocialButton(
              onPressed: loginFacebook,
              type: SocialType.facebook,
            ),
            // only support IOS
            if (Platform.isIOS)
              SocialButton(
                onPressed: loginApple,
                type: SocialType.apple,
              ),
          ],
        ),
      ],
    );
  }
}
