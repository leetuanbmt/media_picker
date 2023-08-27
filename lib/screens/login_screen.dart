import 'package:flutter/gestures.dart';

import '../core/config.dart';
import '../gen/assets.gen.dart';
import 'tabs/widgets/login_form.dart';
import 'tabs/widgets/login_social_id.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: EdgeInsets.only(
                    top: 37.h,
                    bottom: 30.h,
                  ),
                  child: Assets.iconsIconLogo.svg(
                    height: 109.h,
                    width: 78.w,
                    fit: BoxFit.contain,
                  ),
                ),
                const LoginForm(),
                const LoginBySocialOrID(),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '上記からはじめることで、',
                        style: context.bodyMedium!.copyWith(
                          fontSize: 12,
                          color: AppTheme.fontGrayLead,
                        ),
                      ),
                      TextSpan(
                        text: '利用規約',
                        style: context.bodyMedium!.copyWith(
                          fontSize: 12,
                          color: AppTheme.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: 'に同意します。',
                        style: context.bodyMedium!.copyWith(
                          fontSize: 12,
                          color: AppTheme.fontGrayLead,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 37.w),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'アカウントをお持ちでない方',
                          style: context.bodyMedium!.copyWith(
                            fontSize: 12,
                            color: AppTheme.fontGrayLead,
                          ),
                        ),
                        TextSpan(
                          text: '新規登録',
                          style: context.bodyMedium!.copyWith(
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
