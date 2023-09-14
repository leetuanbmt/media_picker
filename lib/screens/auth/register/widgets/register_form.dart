import '../../../../core/config.dart';

import '../../../../core/models/models.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../providers/register_provider.dart';
import '../../../../routes/app_routes.gr.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/indicators/loading_manager.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class RegisterForm extends HookConsumerWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // create a TextEditingController for each field
    final emailController = useTextEditingController();

    final passwordController = useTextEditingController();

    // create a ValueNotifier<bool> for each field
    final checkFieldsEmpty = useState<bool>(true);

    bool areFieldsEmpty() {
      return emailController.text.isEmpty || passwordController.text.isEmpty;
    }

    checkFieldsEmpty.value = areFieldsEmpty();

    Logger.log("checkFieldsEmpty.value ${checkFieldsEmpty.value}");

    useEffect(
      () {
        void listener() {
          checkFieldsEmpty.value = areFieldsEmpty();
        }

        emailController.addListener(listener);
        passwordController.addListener(listener);
        final saveEmail = AppConfig.email.getString();
        final savePassword = AppConfig.password.getString();
        if (saveEmail != null && savePassword != null) {
          emailController.text = saveEmail;
          passwordController.text = savePassword;
        }

        return () {
          emailController.removeListener(listener);
          passwordController.removeListener(listener);
        };
      },
      [],
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 45.h),
      child: Form(
        child: Column(
          children: [
            TextFieldCustom(
              textController: emailController,
              hintText: "メールアドレス",
              keyboardType: TextInputType.emailAddress,
              //errorText: ref.watch(registerProvider).email.error,
            ),
            SizedBox(
              height: 12.h,
            ),
            TextFieldCustom(
              textController: passwordController,
              hintText: 'パスワード（6文字以上の半角英数字）',
              obscureText: true,
              //errorText: ref.watch(registerProvider).password.error,
            ),
            SizedBox(
              height: 28.h,
            ),
            Consumer(
              builder: (context, ref, child) {
                return ButtonCustom(
                  "新規登録",
                  width: double.infinity,
                  height: 48.h,
                  onPressed: () {
                    checkFieldsEmpty.value
                        ? null
                        : registerEmailPassword(
                            context,
                            emailController,
                            passwordController,
                            ref,
                          );
                  },
                  backgroundColor: checkFieldsEmpty.value
                      ? AppTheme.middleGray
                      : AppTheme.primaryColor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void registerEmailPassword(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    WidgetRef ref,
  ) {
    FocusScope.of(context).unfocus();
    ref.read(registerProvider.notifier).register(
          context,
          emailController.text,
          passwordController.text,
        );
    //     .whenComplete(() {
    //   context.router.push(
    //     OTPRoute(authType: AuthType.register),
    //   );
    // });
    // LoadingManager.instance.show(context);
    // Future.delayed(1.seconds, () {
    //   LoadingManager.instance.hide(context);
    //   WidgetsBinding.instance.endOfFrame.then((value) {
    //     AutoRouter.of(context).push(OTPRoute(authType: AuthType.register));
    //   });
    // });
  }
}
