import '../../../../core/config.dart';
import '../../../../core/models/models.dart';

import '../../../../providers/auth/register_provider.dart';
import '../../../../widgets/commons/button_custom.dart';

class RegisterBankAccountScreen extends StatelessWidget {
  const RegisterBankAccountScreen({super.key, required this.userType});
  final UserType userType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Text(
              context.lang.registerYourStripeAccount,
              textAlign: TextAlign.center,
              style: context.titleLarge!.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.blackBold,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              context.lang.registerAccountWithdrawPoint,
              style: context.bodyMedium!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: const Color(0xff828282),
              ),
            ),
            SizedBox(
              height: 52.h,
            ),
            ButtonCustom(
              context.lang.signUp,
              fontSize: 15.sp,
              height: 48.h,
              width: 327.w,
              onPressed: () {},
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return ButtonCustom(
                      context.lang.skip,
                      fontSize: 15.sp,
                      height: 48.h,
                      width: 162.w,
                      type: ButtonType.outline,
                      borderWidth: 2.r,
                      onPressed: () {
                        ref.read(registerProvider).register(context, userType);
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 27.h,
            ),
          ],
        ),
      ),
    );
  }
}
