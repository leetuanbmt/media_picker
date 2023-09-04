import '../../core/config.dart';
import '../../gen/assets.gen.dart';
import 'widgets/login_form.dart';
import 'widgets/login_social_id.dart';
import 'widgets/navigate_register.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 37.h,
                ),
                Assets.iconsIconLogo.svg(
                  height: 109.h,
                  width: 78.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 21.h,
                ),
                const LoginForm(),
                const LoginBySocial(),
                const LoginByFaceID(),
                const NavigateRegister(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
