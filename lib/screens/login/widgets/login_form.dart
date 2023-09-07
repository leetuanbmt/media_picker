import '../../../core/config.dart';

import '../../../routes/app_routes.gr.dart';
import '../../../widgets/commons/button_custom.dart';

import '../../../widgets/commons/text_field_custom.dart';

class LoginForm extends HookWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final checkFieldsEmpty = useState<bool>(true);
    final toggleValue = useState<bool>(false);

    bool areFieldsEmpty() {
      return emailController.text.isEmpty || passwordController.text.isEmpty;
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
            child: TextFieldCustom(
              textController: emailController,
              hintText: "メールアドレス",
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: TextFieldCustom(
              textController: passwordController,
              hintText: 'パスワード（6文字以上の半角英数字）',
              obscureText: true,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Checkbox(
                  value: toggleValue.value,
                  side: BorderSide(
                    color: AppTheme.box,
                    width: 3.r,
                  ),
                  onChanged: (bool? value) {
                    toggleValue.value = value!;
                  },
                ),
              ),
              Text(
                '次回から自動でログイン',
                style: context.bodySmall!.copyWith(
                  fontSize: 12.sp,
                  color: AppTheme.fontGrayLead,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: ButtonCustom(
              "ログイン",
              width: double.maxFinite,
              height: 48.h,
              fontSize: 15.sp,
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
          ),
        ],
      ),
    );
  }
}
