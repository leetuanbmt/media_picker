import '../../../../core/config.dart';
import '../../../../providers/login_provider.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(loginProvider.notifier);
    final emailController = provider.emailController;
    final passwordController = provider.passwordController;
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
                  Consumer(
                    builder: (context, ref, child) {
                      return SizedBox.square(
                        dimension: 24.r,
                        child: Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: ref.watch(
                            loginProvider.select((value) => value.saveAccount),
                          ),
                          side: const BorderSide(color: AppTheme.box, width: 3),
                          onChanged: provider.toggleSaveAccount,
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: provider.toggleSaveAccount,
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
            Consumer(
              builder: (context, ref, child) {
                final checkFieldsEmpty = ref.watch(
                  loginProvider.select((value) => value.checkFieldsEmpty),
                );
                return ButtonCustom(
                  "ログイン",
                  height: 48.h,
                  width: double.infinity,
                  onPressed: () {
                    checkFieldsEmpty
                        ? null
                        : ref.read(loginProvider.notifier).login(context);
                  },
                  backgroundColor: checkFieldsEmpty
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
}
