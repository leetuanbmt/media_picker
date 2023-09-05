import '../../../../core/config.dart';

import '../../../../routes/app_routes.gr.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class RegisterForm extends HookWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    // create a TextEditingController for each field
    final emailController = useTextEditingController(text: '');

    final passwordController = useTextEditingController(text: '');

    // create a ValueNotifier<bool> for each field
    final checkFieldsEmpty = useState<bool>(true);
    // create a ValueNotifier<bool> for each field

    // listen to changes in the TextEditingController
    final updateEmail = useValueListenable(emailController);
    // listen to changes in the TextEditingController
    final updatePass = useValueListenable(passwordController);

    bool areFieldsEmpty() {
      return updateEmail.text.isEmpty || updatePass.text.isEmpty;
    }

    checkFieldsEmpty.value = areFieldsEmpty();
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
            SizedBox(
              height: 12.h,
            ),
            TextFieldCustom(
              textController: passwordController,
              hintText: 'パスワード（6文字以上の半角英数字）',
              obscureText: true,
            ),
            SizedBox(
              height: 28.h,
            ),
            ButtonCustom(
              "新規登録",
              width: double.maxFinite,
              height: 48.h,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              onPressed: () {
                checkFieldsEmpty.value
                    ? null
                    : context.router.push(const OTPRoute());
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
