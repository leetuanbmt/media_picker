import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import '../../core/config.dart';
import '../../gen/assets.gen.dart';
import 'widgets/resend_otp.dart';

@RoutePage()
class OTPScreen extends HookWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final otpControllers = List.generate(4, (_) => useTextEditingController());
    final focusNodes = List.generate(4, (_) => useFocusNode());
    final isLoading = useState<bool>(false);

    useEffect(
      () {
        backButtonHandler() {
          Navigator.pop(context);
          return true;
        }

        WidgetsBinding.instance
            .addObserver(HookWidgetBindingObserver(backButtonHandler));
        return () {
          WidgetsBinding.instance
              .removeObserver(HookWidgetBindingObserver(backButtonHandler));
        };
      },
      [context],
    );

    final border = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: AppTheme.primaryColor,
      ),
      borderRadius: BorderRadius.circular(3.r),
    );

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  const OTPTitle(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(74.w, 50.h, 74.w, 40.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: 42.w,
                          height: 50.h,
                          child: TextField(
                            controller: otpControllers[index],
                            style: context.titleMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 4.w,
                                bottom: 13.h,
                                top: 13.h,
                              ),
                              focusedBorder: border,
                              enabledBorder: border.copyWith(
                                borderSide: const BorderSide(
                                  color: AppTheme.box,
                                ),
                              ),
                            ),
                            focusNode: focusNodes[index],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (index < otpControllers.length - 1) {
                                  focusNodes[index + 1].requestFocus();
                                } else if (otpControllers[0].text.isNotEmpty &&
                                    otpControllers[1].text.isNotEmpty &&
                                    otpControllers[2].text.isNotEmpty &&
                                    otpControllers[3].text.isNotEmpty) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  isLoading.value = true;
                                }
                              } else {
                                if (index > 0) {
                                  focusNodes[index - 1].requestFocus();
                                }
                              }
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  const ReSendOTP(),
                ],
              ),
              if (isLoading.value) ...[
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
      ),
    );
  }
}

class HookWidgetBindingObserver extends WidgetsBindingObserver {
  final bool Function() backButtonHandler;

  HookWidgetBindingObserver(this.backButtonHandler);

  @override
  Future<bool> didPopRoute() async {
    return backButtonHandler();
  }
}
