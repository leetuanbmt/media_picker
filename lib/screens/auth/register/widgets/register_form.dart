import '../../../../core/config.dart';

import '../../../../providers/auth/register_provider.dart';
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
              hintText: context.tr(LocaleKeys.emailAddress),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 12.h,
            ),
            TextFieldCustom(
              textController: provider.passwordController,
              hintText: context.tr(LocaleKeys.password),
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
                  context.tr(LocaleKeys.signUp),
                  width: double.infinity,
                  height: 48.h,
                  onPressed: () {
                    if (areFieldsEmpty) return;
                    ref
                        .watch(registerProvider.notifier)
                        .checkEmailPassword(context);
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
}
