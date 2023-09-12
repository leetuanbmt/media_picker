import '../../../../core/config.dart';

import '../../../../core/models/models.dart';
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
    final emailController = useTextEditingController(text: '');

    final passwordController = useTextEditingController(text: '');

    // listen to changes in the TextEditingController
    final updateEmail = useValueListenable(emailController);
    // listen to changes in the TextEditingController
    final updatePass = useValueListenable(passwordController);

    void registerEmailPassword(BuildContext context) {
      ref.watch(registerProvider).changeEmail(emailController.text);
      ref.watch(registerProvider).changePassword(passwordController.text);
      if (ref.watch(registerProvider).email.error.isEmptyOrNull &&
          ref.watch(registerProvider).password.error.isEmptyOrNull) {
        FocusScope.of(context).unfocus();
        LoadingManager.instance.show(context);
        Future.delayed(1.seconds, () {
          LoadingManager.instance.hide(context);
          WidgetsBinding.instance.endOfFrame.then((value) {
            AutoRouter.of(context).push(OTPRoute(authType: AuthType.register));
          });
        });
      }
    }

    return Consumer(
      builder: (context, ref, _) {
        bool isActiveButton = ref
            .watch(registerProvider)
            .isValidEmailPassword(updateEmail.text, updatePass.text);
        return Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 45.h),
          child: Form(
            child: Column(
              children: [
                TextFieldCustom(
                  textController: emailController,
                  hintText: "メールアドレス",
                  keyboardType: TextInputType.emailAddress,
                  errorText: ref.watch(registerProvider).email.error,
                ),
                SizedBox(
                  height: 12.h,
                ),
                TextFieldCustom(
                  textController: passwordController,
                  hintText: 'パスワード（6文字以上の半角英数字）',
                  obscureText: true,
                  errorText: ref.watch(registerProvider).password.error,
                ),
                SizedBox(
                  height: 28.h,
                ),
                ButtonCustom(
                  "新規登録",
                  width: double.infinity,
                  height: 48.h,
                  onPressed: () {
                    isActiveButton ? registerEmailPassword(context) : null;
                  },
                  backgroundColor: isActiveButton == false
                      ? AppTheme.middleGray
                      : AppTheme.primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
