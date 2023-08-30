import '../../../core/config.dart';

class ReSendOTP extends StatelessWidget {
  const ReSendOTP({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Text(
        "メールを再送する",
        style: context.titleSmall!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}

class OTPTitle extends StatelessWidget {
  const OTPTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
