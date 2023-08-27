import '../../../core/config.dart';
import '../../../widgets/commons/button_custom.dart';
import '../../../widgets/commons/text_field_custom.dart';

class LoginForm extends HookWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final checkFieldsEmpty = useState<bool>(true);

    var toggleValue = useState(false);

    bool areFieldsEmpty() {
      return emailController.text.toString().isEmpty ||
          passwordController.text.toString().isEmpty;
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
            Row(
              children: [
                Checkbox(
                  value: toggleValue.value,
                  side: BorderSide(
                    color: AppTheme.box,
                    width: 3.r,
                  ),
                  onChanged: (bool? value) {
                    toggleValue.value = value!;
                  },
                ),
                Text(
                  '次回から自動でログイン',
                  style: context.bodySmall!.copyWith(
                    color: AppTheme.fontGrayLead,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            ButtonCustom(
              "ログイン",
              width: 327.w,
              height: 48.h,
              onPressed: () {},
              backgroundColor: areFieldsEmpty()
                  ? AppTheme.middleGray
                  : AppTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
