import '../../../core/config.dart';

import '../../../widgets/commons/button_custom.dart';
import '../../../widgets/commons/text_field_custom.dart';
import '../../login/otp_screen.dart';

class RegisterForm extends HookWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final checkFieldsEmpty = useState<bool>(true);

    bool areFieldsEmpty() {
      return emailController.text.isEmpty || passwordController.text.isEmpty;
    }

    void navigateOTP() {
      context.nextPage(const OTPScreen());
    }

    useEffect(() {
      emailController.addListener(() {
        checkFieldsEmpty.value = areFieldsEmpty();
      });
      passwordController.addListener(() {
        checkFieldsEmpty.value = areFieldsEmpty();
      });
      return null;
    }, [
      emailController,
      passwordController,
    ]);
    return Form(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: SizedBox(
              height: 48.h,
              width: 327.w,
              child: TextFieldCustom(
                textController: emailController,
                hintText: "メールアドレス",
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: SizedBox(
              height: 48.h,
              width: 327.w,
              child: TextFieldCustom(
                textController: passwordController,
                hintText: 'パスワード（6文字以上の半角英数字）',
                obscureText: true,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: ButtonCustom(
              "新規登録",
              width: double.maxFinite,
              height: 48.h,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              onPressed: () {
                checkFieldsEmpty.value ? null : navigateOTP();
              },
              backgroundColor: checkFieldsEmpty.value
                  ? AppTheme.middleGray
                  : AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
