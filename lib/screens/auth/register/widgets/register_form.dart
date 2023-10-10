import '../../../../core/config.dart';

import '../../../../providers/register_provider.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class RegisterForm extends ConsumerWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(registerProvider.notifier);

    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 45.h),
      child: Form(
        child: Column(
          children: [
            TextFieldCustom(
              textController: provider.emailController,
              hintText: "メールアドレス",
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 12.h,
            ),
            TextFieldCustom(
              textController: provider.passwordController,
              hintText: 'パスワード（6文字以上の半角英数字）',
              obscureText: true,
            ),
            SizedBox(
              height: 28.h,
            ),
            Consumer(
              builder: (context, ref, child) {
                final areFieldsEmpty = ref.watch(
                  registerProvider
                      .select((value) => value.checkEmailPasswordEmpty),
                );
                return ButtonCustom(
                  "新規登録",
                  width: double.infinity,
                  height: 48.h,
                  onPressed: () {
                    areFieldsEmpty
                        ? null
                        : registerEmailPassword(
                            context,
                            ref,
                          );
                  },
                  backgroundColor: areFieldsEmpty
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

  void registerEmailPassword(
    BuildContext context,
    WidgetRef ref,
  ) {
    FocusScope.of(context).unfocus();
    ref.read(registerProvider.notifier).checkEmailPassword(
          context,
        );
  }
}
