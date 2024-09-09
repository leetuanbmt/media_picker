import 'package:pinput/pinput.dart';

import '../core/config.dart';
import '../core/models/models.dart';
import '../core/routes/app_routes.gr.dart';
import '../widgets/commons/button_custom.dart';
import '../widgets/commons/indicators/loading_manager.dart';

@RoutePage()
class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key, required this.authType});
  final AuthType authType;
  @override
  Widget build(BuildContext context) {
    final BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: AppTheme.box),
    );
    final theme = PinTheme(
      width: 42.w,
      height: 50.h,
      textStyle: context.bodyMedium,
      decoration: decoration,
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
                    decoration: decoration.copyWith(
                      border: Border.all(color: context.primaryColor),
                    ),
                  ),
                  onCompleted: (value) {
                    sentOTP(context, value);
                  },
                ),
              ),
            ),
            ButtonCustom(
              'メールを再送する',
              type: ButtonType.text,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void sentOTP(BuildContext context, String val) {
    FocusScope.of(context).unfocus();
    LoadingManager.instance.show(context);
    Future.delayed(1.seconds, () {
      if (!context.mounted) return;
      LoadingManager.instance.hide(context);
      WidgetsBinding.instance.endOfFrame.then((value) {
        if (authType == AuthType.login) {
          if (!context.mounted) return;
          AutoRouter.of(context).pushAndPopUntil(
            const HomeRoute(),
            predicate: (_) => false,
          );
        } else {
          if (!context.mounted) return;
          AutoRouter.of(context).push(const SelectAttributeRoute());
        }
      });
    });
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
          '認証コードを入力してください',
          style: context.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.blackBold,
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        Text(
          'メールアドレスに送信した認証コードを入力し、登録\nを完成させましょう！',
          textAlign: TextAlign.center,
          style: context.bodySmall?.copyWith(
            fontWeight: FontWeight.w300,
            color: AppTheme.fontGrayLead,
          ),
        ),
      ],
    );
  }
}
