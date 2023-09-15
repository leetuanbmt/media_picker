import '../../../../core/config.dart';

import '../../../../core/models/models.dart';
import '../../../../providers/register_provider.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class RegisterForm extends HookConsumerWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // create a TextEditingController for each field
    final emailController = useTextEditingController();

    final passwordController = useTextEditingController();

    // create a ValueNotifier<bool> for each field
    final checkFieldsEmpty = useState<bool>(true);

    bool areFieldsEmpty() {
      return emailController.text.isEmpty || passwordController.text.isEmpty;
    }

    checkFieldsEmpty.value = areFieldsEmpty();

    Logger.log("checkFieldsEmpty.value ${checkFieldsEmpty.value}");

    ref.listen(registerProvider, (previous, next) {
      // if (next is SuccessState) {
      //   context.router.pushAndPopUntil(
      //     OTPRoute(authType: AuthType.register),
      //     predicate: (router) => false,
      //   );
      // }
      if (next is ErrorState) {
        context.toast(next.message);
      }
      if (next is LoadingState) {
        context.startLoading();
      } else {
        context.endLoading();
      }
    });

    useEffect(
      () {
        void listener() {
          checkFieldsEmpty.value = areFieldsEmpty();
        }

        emailController.addListener(listener);
        passwordController.addListener(listener);

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
            Consumer(
              builder: (context, ref, child) {
                return ButtonCustom(
                  "新規登録",
                  width: double.infinity,
                  height: 48.h,
                  onPressed: () {
                    checkFieldsEmpty.value
                        ? null
                        : registerEmailPassword(
                            context,
                            emailController,
                            passwordController,
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

  void registerEmailPassword(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    WidgetRef ref,
  ) {
    FocusScope.of(context).unfocus();
    ref.watch(registerProvider.notifier).register(
          emailController.text,
          passwordController.text,
        );
  }
}
