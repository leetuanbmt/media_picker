import '../../../../core/config.dart';
import '../../../../core/models/models.dart';
import '../../../../core/utilities/preferences.dart';
import '../../../../providers/register_provider.dart';
import '../../../../routes/app_routes.gr.dart';
import '../../../../widgets/commons/button_custom.dart';
import 'register_success.dart';

class RegisterBankAccountScreen extends HookConsumerWidget {
  const RegisterBankAccountScreen({super.key, required this.userType});
  final UserType userType;

  void register(BuildContext context, WidgetRef ref) {
    userType == UserType.fan
        ? ref.watch(registerProvider).registerFan()
        : ref.watch(registerProvider).registerCreator();

    LoadingRegisterSuccess.instance.show(context);
    Future.delayed(2.seconds, () {
      LoadingRegisterSuccess.instance.hide(context);
      ref.watch(registerProvider).clean();
      WidgetsBinding.instance.endOfFrame.then((value) {
        Preferences.authenticated = true;
        AutoRouter.of(context).pushAndPopUntil(
          const HomeRoute(),
          predicate: (_) => false,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
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
            const Spacer(),
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
                    register(context, ref);
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
