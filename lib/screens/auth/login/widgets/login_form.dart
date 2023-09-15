import '../../../../core/config.dart';
import '../../../../providers/login_provider.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // create a TextEditingController for each field
    final emailController = useTextEditingController();

    final passwordController = useTextEditingController();

    // create a ValueNotifier<bool> for each field
    final checkFieldsEmpty = useState<bool>(true);
    // create a ValueNotifier<bool> for each field
    final saveAccount = useState<bool>(false);

    bool areFieldsEmpty() {
      return emailController.text.isEmpty || passwordController.text.isEmpty;
    }

    checkFieldsEmpty.value = areFieldsEmpty();

    useEffect(
      () {
        void listener() {
          checkFieldsEmpty.value = areFieldsEmpty();
        }

        emailController.addListener(listener);

        passwordController.addListener(listener);

        final saveEmail = AppConfig.email.getString();
        final savePassword = AppConfig.password.getString();
        final checkSaveAccount = AppConfig.checkSaveAccount.getBool();
        saveAccount.value = checkSaveAccount;
        if (checkSaveAccount && saveEmail != null && savePassword != null) {
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
                      value: saveAccount.value,
                      side: const BorderSide(color: AppTheme.box, width: 3),
                      onChanged: (bool? value) {
                        saveAccount.value = value!;
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      saveAccount.value = saveAccount.value.toggle();
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
            HookBuilder(
              builder: (context) {
                return ButtonCustom(
                  "ログイン",
                  height: 48.h,
                  width: double.infinity,
                  onPressed: () {
                    checkFieldsEmpty.value
                        ? null
                        : login(
                            context,
                            emailController,
                            passwordController,
                            saveAccount,
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

  void login(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    ValueNotifier<bool> saveAccount,
    WidgetRef ref,
  ) {
    FocusScope.of(context).unfocus();
    AppConfig.checkSaveAccount.setBool(saveAccount.value);
    if (saveAccount.value) {
      AppConfig.email.setString(emailController.text);
      AppConfig.password.setString(passwordController.text);
    } else {
      AppConfig.email.setString("");
      AppConfig.password.setString("");
    }

    AppConfig.checkSaveAccount.setBool(saveAccount.value);
    ref.read(loginProvider.notifier).login(
          context,
          emailController.text,
          passwordController.text,
        );
  }
}
