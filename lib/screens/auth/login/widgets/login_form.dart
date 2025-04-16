import '../../../../core/config.dart';
import '../../../../core/providers/auth/auth_provider.dart';
import '../../../../core/providers/auth/state/auth.dart';
import '../../../../core/providers/user_preferences/user_preferences_provider.dart';
import '../../../../core/providers/user_preferences/user_preferences_state.dart';
import '../../../../core/utilities/navigator.dart';
import '../../../../widgets/commons/button_custom.dart';
import '../../../../widgets/commons/text_field_custom.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pref = ref.watch(UserPreferencesNotifier.provider);

    final prefProvider = ref.watch(UserPreferencesNotifier.notifier);

    final emailController = useTextEditingController();

    final passwordController = useTextEditingController();

    final isSaveAccount = useState(false);

    final checkFieldsEmpty = useState(true);

    bool areFieldsEmpty() {
      return emailController.text.isEmpty || passwordController.text.isEmpty;
    }

    void setUser(UserPreferences state) {
      if (state.isRememberMe) {
        isSaveAccount.value = state.isRememberMe;
        if (state.isRememberMe) {
          emailController.text = state.username;
          passwordController.text = state.password;
        }
        checkFieldsEmpty.value = areFieldsEmpty();
      }
    }

    ref.listen(UserPreferencesNotifier.provider, (previous, next) {
      setUser(next);
    });
    ref.listen(authProvider, (previous, next) {
      if (next is AuthLoading) {
        context.startLoading();
      } else {
        context.endLoading();
      }
      if (next is AuthError) {
        context.toast(next.message);
      } else if (next is AuthSuccess) {
        // save account
        prefProvider.saveAccount(
          emailController.text,
          passwordController.text,
          isSaveAccount.value,
        );
        AppNavigator.instance.goToDashboard();
      }
    });

    useEffect(
      () {
        // check save account and set value for email and password
        setUser(pref);

        listener() => checkFieldsEmpty.value = areFieldsEmpty();

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
              hintText: context.lang.emailAddress,
              keyboardType: TextInputType.emailAddress,
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: TextFieldCustom(
                textController: passwordController,
                hintText: context.lang.password,
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
                    dimension: 24.r,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: isSaveAccount.value,
                      side: const BorderSide(color: AppTheme.box, width: 3),
                      onChanged: (value) {
                        isSaveAccount.value = value!;
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      isSaveAccount.value = !isSaveAccount.value;
                    },
                    child: Text(
                      context.lang.logInAutomaticallyNextTime,
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppTheme.fontGrayLead,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ButtonCustom(
              context.lang.logIn,
              height: 48.h,
              width: double.infinity,
              onPressed: () {
                if (checkFieldsEmpty.value) return;
                ref.read(authProvider.notifier).signInWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                    );
              },
              backgroundColor: checkFieldsEmpty.value
                  ? AppTheme.middleGray
                  : context.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
