import '../../../../core/config.dart';

import '../../../../providers/register_provider.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class RegisterForm extends ConsumerWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final register = ref.read(registerProvider.notifier);

    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 45.h),
      child: Form(
        child: Column(
          children: [
            TextFieldCustom(
              textController: register.emailController,
              hintText: "メールアドレス",
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => register.checkButton(),
            ),
            SizedBox(
              height: 12.h,
            ),
            TextFieldCustom(
              textController: register.passwordController,
              hintText: 'パスワード（6文字以上の半角英数字）',
              obscureText: true,
              onChanged: (_) => register.checkButton(),
            ),
            SizedBox(
              height: 28.h,
            ),
            ValueListenableBuilder<bool>(
              valueListenable:
                  ref.watch(registerProvider.notifier).checkActiveButton,
              builder: (context, _, __) {
                final isActive = ref
                    .watch(registerProvider.notifier)
                    .checkActiveButton
                    .value;
                return ButtonCustom(
                  "新規登録",
                  width: double.infinity,
                  height: 48.h,
                  onPressed: () {
                    isActive
                        ? registerEmailPassword(
                            context,
                            register.emailController,
                            register.passwordController,
                            ref,
                          )
                        : null;
                  },
                  backgroundColor:
                      isActive ? AppTheme.primaryColor : AppTheme.middleGray,
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
    ref.watch(registerProvider.notifier).register(
          context,
          emailController.text,
          passwordController.text,
        );
  }
}
