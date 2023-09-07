import '../../../core/config.dart';
import '../../../routes/app_routes.gr.dart';
import '../../../widgets/commons/button_custom.dart';

class RegisterBankAccountScreen extends StatelessWidget {
  const RegisterBankAccountScreen({super.key, required this.onNextPage});
  final Function onNextPage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Text(
              'Stripeアカウントを登録してくださ\nい',
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
              '獲得したポイントを出金出来る口座を登録します。',
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
              "登録する",
              fontSize: 15.sp,
              height: 48.h,
              width: 327.w,
              onPressed: () {},
            ),
            SizedBox(
              height: 397.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonCustom(
                  "SKIPする",
                  fontSize: 15.sp,
                  height: 48.h,
                  width: 162.w,
                  type: ButtonType.outline,
                  borderWidth: 2,
                  onPressed: () {
                    context.router.push(const RegisterSuccessRoute());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
