import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../core/config.dart';

class MyPageDialog {
  void showDiaLogSuccess(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(
          const Duration(seconds: 3),
        ).whenComplete(() {
          if (!context.mounted) return;
          Navigator.of(context).pop();
        });
        return Center(
          child: Container(
            width: 317.w,
            height: 302.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            child: Assets.iconsIconDonateSuccess
                .svg(width: 136.w, height: 136.h, fit: BoxFit.scaleDown),
          ),
        );
      },
    );
  }

  Future<void> showDialogSpentAllPoint(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          if (!context.mounted) return;
          Navigator.of(context).pop();
        });
        return Center(
          child: Container(
            width: 335.w,
            height: 204.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 36.h,
                ),
                Text(
                  context.lang.spentAllPoint,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.blackBold,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Assets.iconsIconClappingHands.svg(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DelayDialog extends StatelessWidget {
  const DelayDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.bodySmall!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.blackBold,
    );
    return Center(
      child: Container(
        width: 317.w,
        height: 356.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 55.h,
            ),
            CircularPercentIndicator(
              radius: 110.r,
              lineWidth: 20.r,
              backgroundColor: const Color(0xffE0E0E0),
              progressColor: context.primaryColor,
              percent: 1,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration: 5000,
              onAnimationEnd: () {
                Navigator.of(context).pop();
                MyPageDialog().showDiaLogSuccess(context);
              },
              center: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.lang.untilReceivePoints,
                    style: style.copyWith(
                      color: AppTheme.fontGrayLead,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.lang.after, style: style),
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
                      Text(context.lang.seconds, style: style),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                context.lang.cancel,
                style: context.textTheme.titleSmall!.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: context.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AutoDialog extends StatelessWidget {
  const AutoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.bodySmall!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.black,
    );

    ValueNotifier<bool> isAnimation = ValueNotifier<bool>(false);

    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      isAnimation.value = true;
      Future.delayed(const Duration(seconds: 3), () {
        if (!context.mounted) return;
        Navigator.of(context).pop();
        MyPageDialog().showDiaLogSuccess(context);
      });
    });

    return Center(
      child: Container(
        height: 356.h,
        width: 317.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 55.h,
            ),
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Assets.iconsIconAutoDialog.svg(
                  width: 219.99.w,
                  height: 220.01.h,
                  fit: BoxFit.scaleDown,
                ),
                ValueListenableBuilder(
                  valueListenable: isAnimation,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 60.h,
                        ),
                        SizedBox(
                          height: 40.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.lang.remaining,
                                style: style,
                              ),
                              Text(
                                '30',
                                style: context.textTheme.displaySmall!.copyWith(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.blackBold,
                                  letterSpacing: 2.w,
                                ),
                              ),
                              Text(
                                'pt',
                                style: style,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 35.h,
                          width: 124.w,
                          margin: EdgeInsets.only(bottom: 10.h, top: 20.h),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.r)),
                            gradient: isAnimation.value
                                ? LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppTheme.purple,
                                      AppTheme.purple.withValues(alpha: 0),
                                    ],
                                  )
                                : null,
                            color: isAnimation.value ? null : AppTheme.purple,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '3000',
                                style:
                                    context.textTheme.headlineSmall!.copyWith(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  letterSpacing: 2.w,
                                ),
                              ),
                              Text(
                                'pt',
                                style: context.textTheme.titleMedium!.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  letterSpacing: 2.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isAnimation.value)
                          Text(
                            '-100',
                            style: context.textTheme.titleLarge!.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.purple,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                context.lang.cancel,
                style: context.textTheme.titleSmall!.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: context.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
