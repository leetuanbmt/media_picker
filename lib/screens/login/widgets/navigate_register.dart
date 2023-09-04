import 'package:flutter/gestures.dart';

import '../../../core/config.dart';
import '../../../routes/app_routes.gr.dart';

class NavigateRegister extends StatelessWidget {
  const NavigateRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.bodyMedium!.copyWith(
      fontSize: 12,
      color: AppTheme.fontGrayLead,
    );
    return Column(
      children: [
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
                    context.router.push(const RegisterRoute());
                  },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 37.h,
        ),
      ],
    );
  }
}
