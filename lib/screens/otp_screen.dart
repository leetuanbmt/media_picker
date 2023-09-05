import 'package:pinput/pinput.dart';

import '../core/config.dart';
import '../routes/app_routes.gr.dart';
import '../widgets/commons/indicators/loading_manager.dart';

@RoutePage()
class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = PinTheme(
      width: 42.w,
      height: 50.h,
      textStyle: context.titleMedium!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: AppTheme.box,
          width: 1.r,
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const OTPTitle(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 35.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 225.w),
                child: Pinput(
                  length: 4,
                  autofocus: true,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  defaultPinTheme: theme,
                  focusedPinTheme: theme.copyWith(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  onCompleted: (value) {
                    sentOTP(context);
                  },
                ),
              ),
            ),
            const ReSendOTP(),
          ],
        ),
      ),
    );
  }

  void sentOTP(BuildContext context) {
    FocusScope.of(context).unfocus();
    LoadingManager.instance.show(context);
    Future.delayed(1.seconds, () {
      LoadingManager.instance.hide(context);
      WidgetsBinding.instance.endOfFrame.then((value) {
        AutoRouter.of(context).push(const SelectAttributeRoute());
      });
    });
  }
}

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
        SizedBox(
          height: 120.h,
        ),
        Text(
          "認証コードを入力してください",
          style: context.titleLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppTheme.blackBold,
          ),
        ),
        SizedBox(
          height: 40.h,
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
