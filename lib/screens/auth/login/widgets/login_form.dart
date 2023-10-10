import '../../../../core/config.dart';
import '../../../../core/utilities/navigator.dart';
import '../../../../providers/auth/auth_notify.dart';
import '../../../../providers/auth/state/auth.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    ref.listen(authProvider, (previous, next) {
      if (next is AuthLoading) {
        context.startLoading();
      } else {
        context.endLoading();
      }
      if (next is AuthError) {
        context.toast(next.message);
      } else if (next is AuthSuccess) {
        AppConfig.email.setString(emailController.text);
        AppConfig.password.setString(passwordController.text);
        AppNavigator.goToDashboard();
      }
    });

    final isSaveAccount = useState(false);
    final checkFieldsEmpty = useState(true);

    bool areFieldsEmpty() {
      return emailController.text.isEmpty || passwordController.text.isEmpty;
    }

    useEffect(
      () {
        listener() {
          checkFieldsEmpty.value = areFieldsEmpty();
        }

        emailController.addListener(listener);
        passwordController.addListener(listener);
        final saveEmail = AppConfig.email.getString();
        final savePassword = AppConfig.password.getString();
        final checkSaveAccount = AppConfig.checkSaveAccount.getBool();
        isSaveAccount.value = checkSaveAccount;
        // check save account and set value for email and password
        if (checkSaveAccount && saveEmail != null && savePassword != null) {
          emailController.text = saveEmail;
          passwordController.text = savePassword;
        }

        return () {
          emailController.removeListener(listener);
          passwordController.removeListener(listener);
        };
      },
      [emailController, passwordController],
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
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: TextFieldCustom(
                textController: passwordController,
                hintText: 'パスワード（6文字以上の半角英数字）',
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 18.h,
              ),
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 24.r,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: isSaveAccount.value,
                      side: const BorderSide(color: AppTheme.box, width: 3),
                      onChanged: (value) {
                        isSaveAccount.value = value!;
                        AppConfig.checkSaveAccount.setBool(value);
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      isSaveAccount.value = !isSaveAccount.value;
                      AppConfig.checkSaveAccount.setBool(isSaveAccount.value);
                    },
                    child: Text(
                      '次回から自動でログイン',
                      style: context.bodySmall!.copyWith(
                        color: AppTheme.fontGrayLead,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ButtonCustom(
              "ログイン",
              height: 48.h,
              width: double.infinity,
              onPressed: () {
                checkFieldsEmpty.value
                    ? null
                    : ref
                        .read(authProvider.notifier)
                        .signInWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );
              },
              backgroundColor: checkFieldsEmpty.value
                  ? AppTheme.middleGray
                  : AppTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
