import 'package:flutter/gestures.dart';

import '../../../core/config.dart';
import '../../../gen/assets.gen.dart';
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
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              AuthLogo(),
              LoginForm(),
              SocialList(),
              LoginByFaceID(),
              LoginInformation(),
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
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 35.h,
      ),
      child: Column(
        children: [
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
          SizedBox(
            height: 20.h,
          ),
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
                      context.router.push(const RegisterRoute());
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginByFaceID extends StatelessWidget {
  const LoginByFaceID({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Text(
          'Face IDでログイン',
          style: context.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.fontBoldLight,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        SocialButton(
          path: Assets.iconsIconFaceId.path,
          onPressed: () {},
        ),
      ],
    );
  }
}
