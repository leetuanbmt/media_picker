import 'package:flutter/gestures.dart';

import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';
import '../../../providers/auth/auth_notify.dart';
import '../../../routes/app_routes.gr.dart';
import '../widgets/logo.dart';
import '../widgets/social_button.dart';
import 'widgets/login_form.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, this.onResult});
  final Function(bool didLogin)? onResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const AuthLogo(),
              const LoginForm(),
              Consumer(
                builder: (context, ref, child) {
                  final auth = ref.read(authProvider.notifier);
                  return SocialList(
                    loginGoogle: auth.loginGoogle,
                    loginFacebook: auth.loginFacebook,
                    loginTwitter: auth.loginTwitter,
                    loginApple: auth.loginApple,
                  );
                },
              ),
              const LoginByFaceID(),
              const LoginInformation(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginInformation extends StatelessWidget {
  const LoginInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.bodySmall!.copyWith(
      color: AppTheme.fontGrayLead,
    );
    return Column(
      children: [
        HeightBox(30.h),
        RichText(
          text: TextSpan(
            style: style,
            children: <TextSpan>[
              const TextSpan(
                text: '上記からはじめることで、',
                // style: style,
              ),
              TextSpan(
                text: '利用規約',
                style: style.copyWith(color: AppTheme.primaryColor),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
              const TextSpan(
                text: 'に同意します。',
                // style: style,
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'アカウントをお持ちでない方',
                style: style,
              ),
              TextSpan(
                text: '新規登録',
                style: style.copyWith(color: AppTheme.primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.router.replace(const RegisterRoute());
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LoginByFaceID extends ConsumerWidget {
  const LoginByFaceID({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Text(
          'Face IDでログイン',
          style: context.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.fontBoldLight,
          ),
        ),
        SizedBox(height: 10.h),
        IconButton(
          icon: Assets.iconsIconFaceId.svg(),
          onPressed: () {},
        ),
      ],
    );
  }
}
