import '../../core/config.dart';

import 'widgets/input_otp.dart';

@RoutePage()
class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 120.h, bottom: 40.h),
                child: Text(
                  "認証コードを入力してください",
                  style: context.titleLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.blackBold,
                  ),
                ),
              ),
              Text(
                "メールアドレスに送信した認証コードを入力し、登録\nを完成させましょう！",
                textAlign: TextAlign.center,
                style: context.titleMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: AppTheme.fontGrayLead,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(74.w, 50.h, 74.w, 40.h),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputOTP(),
                    InputOTP(),
                    InputOTP(),
                    InputOTP(
                      finalValue: true,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "メールを再送する",
                  style: context.titleSmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
