import 'package:flutter/gestures.dart';

import '../../../core/config.dart';

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
        Padding(
          padding: EdgeInsets.only(top: 20.h, bottom: 37.w),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'アカウントをお持ちでない方',
                  style: style,
                ),
                TextSpan(
                  text: '新規登録',
                  style: style.copyWith(color: AppTheme.primaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
