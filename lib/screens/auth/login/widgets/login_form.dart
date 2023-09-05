import '../../../../core/config.dart';
import '../../../../core/models/models.dart';
import '../../../../routes/app_routes.gr.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/indicators/loading_manager.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class LoginForm extends HookWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    // create a TextEditingController for each field
    final emailController = useTextEditingController(text: 'example.com');

    final passwordController = useTextEditingController(text: 'password');

    // create a ValueNotifier<bool> for each field
    final checkFieldsEmpty = useState<bool>(true);
    // create a ValueNotifier<bool> for each field
    final toggleValue = useState<bool>(false);

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
                    dimension: 20.r,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      toggleValue.value = !toggleValue.value;
                    },
                    child: Text(
                      '次回から自動でログイン',
                      style: context.bodySmall!.copyWith(
                        color: AppTheme.fontGrayLead,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ButtonCustom(
              "ログイン",
              width: 327.w,
              height: 48.h,
              onPressed: () {
                checkFieldsEmpty.value ? null : login(context);
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

  void login(BuildContext context) {
    FocusScope.of(context).unfocus();
    LoadingManager.instance.show(context);
    Future.delayed(1.seconds, () {
      LoadingManager.instance.hide(context);
      WidgetsBinding.instance.endOfFrame.then((value) {
        AutoRouter.of(context).push(OTPRoute(authType: AuthType.login));
      });
    });
  }
}
