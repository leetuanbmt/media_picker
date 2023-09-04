import 'dart:ui' as ui;

import 'package:pinput/pinput.dart';

import '../../core/config.dart';
import '../../gen/assets.gen.dart';
import '../../routes/app_routes.gr.dart';

@RoutePage()
class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

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

    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  const OTPTitle(),
                  SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                    height: 50.h,
                    width: 226.w,
                    child: Pinput(
                      length: 4,
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
                        debugPrint(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 48.h,
                  ),
                  const ReSendOTP(),
                ],
              ),
            ),
            if (isLoading == true) ...[
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black.withOpacity(0.4),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Assets.iconsIconLoading.svg(
                    width: 48,
                    height: 48,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ReSendOTP extends StatelessWidget {
  const ReSendOTP({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(const SelectAttributeRoute());
      },
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
