import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';

class DelayDialog extends StatelessWidget {
  const DelayDialog({super.key});

  void showDiaLogSuccess(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(
          const Duration(seconds: 2),
        ).whenComplete(() {
          Navigator.of(context).pop();
        });
        return Dialog(
          child: SizedBox(
            width: 317.w,
            height: 302.h,
            child: Center(
              child: Assets.iconsIconDonateSuccess.svg(
                width: 136.w,
                height: 136.h,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = context.bodySmall!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.blackBold,
    );
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: 317.w,
        height: 356.h,
        child: Column(
          children: [
            SizedBox(
              height: 55.h,
            ),
            CircularPercentIndicator(
              radius: 110.r,
              lineWidth: 20.r,
              backgroundColor: const Color(0xffE0E0E0),
              progressColor: AppTheme.primaryColor,
              percent: 1,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration: 5000,
              onAnimationEnd: () {
                Navigator.of(context).pop();
                showDiaLogSuccess(context);
              },
              center: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr(LocaleKeys.untilReceivePoints),
                    style: style.copyWith(
                      color: AppTheme.fontGrayLead,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.tr(LocaleKeys.after),
                        style: style,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        '5:00',
                        style: style,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        context.tr(LocaleKeys.seconds),
                        style: style,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                context.tr(LocaleKeys.cancel),
                style: context.titleSmall!.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppTheme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
