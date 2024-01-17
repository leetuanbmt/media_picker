import 'package:flutter/gestures.dart';

import '../../../core/config.dart';
import '../../../routes/app_routes.gr.dart';
import '../widgets/logo.dart';
import '../widgets/social_button.dart';
import 'widgets/register_form.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              RegisterForm(),
              SocialList(),
              RegisterInformation(),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterInformation extends StatelessWidget {
  const RegisterInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.bodyMedium!.copyWith(
      fontSize: 12,
      color: AppTheme.fontGrayLead,
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35.h),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: style,
              children: <TextSpan>[
                TextSpan(text: context.lang.byStartingFromAbove),
                TextSpan(
                  text: context.lang.termsOfService,
                  style: style.copyWith(color: context.primaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(text: context.lang.iAgree),
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
                  text: context.lang.alreadyHaveAccount,
                  style: style,
                ),
                TextSpan(
                  text: context.lang.logIn,
                  style: style.copyWith(color: context.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.router.replace(LoginRoute());
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
