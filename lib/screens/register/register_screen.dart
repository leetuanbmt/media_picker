import 'package:flutter/gestures.dart';

import '../../core/config.dart';
import '../../gen/assets.gen.dart';
import '../login/widgets/login_social_id.dart';
import 'widgets/register_form.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.bodyMedium!.copyWith(
      fontSize: 12,
      color: AppTheme.fontGrayLead,
    );
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 104.h,
                ),
                Assets.iconsIconLogo.svg(
                  height: 109.h,
                  width: 78.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 43.h,
                ),
                const RegisterForm(),
                const LoginBySocial(),
                SizedBox(
                  height: 18.h,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '上記からはじめることで、',
                        style: style,
                      ),
                      TextSpan(
                        text: '利用規約',
                        style: style.copyWith(color: AppTheme.primaryColor),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: 'に同意します。',
                        style: style,
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
                            context.router.back();
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 37.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
