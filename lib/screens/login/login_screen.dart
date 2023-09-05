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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 37.h,
                  bottom: 30.h,
                ),
                child: Assets.iconsIconLogo.svg(
                  height: 109.h,
                  width: 78.w,
                  fit: BoxFit.contain,
                ),
              ),
              const LoginForm(),
              const LoginBySocialOrID(),
              const NavigateRegister(),
            ],
          ),
        ),
      ),
    );
  }
}
