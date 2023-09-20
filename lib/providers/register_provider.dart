import '../core/config.dart';
import '../core/models/base/base_model.dart';
import 'auth_provider.dart';

final registerProvider = ChangeNotifierProvider.autoDispose<RegisterProvider>(
  (ref) => RegisterProvider(ref)..initialize(),
);

class RegisterProvider extends ChangeNotifier {
  RegisterProvider(this.ref);

  final Ref ref;

  AuthProvider get auth => ref.read(authProvider);

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String get email => emailController.text;

  String get password => passwordController.text;

  bool checkFieldsEmpty = true;

  bool areFieldsEmpty() {
    return email.isEmpty || password.isEmpty;
  }

  void listener() {
    checkFieldsEmpty = areFieldsEmpty();
    notifyListeners();
  }

  void initialize() {
    emailController.addListener(listener);
    passwordController.addListener(listener);
  }

  @override
  void dispose() {
    emailController.removeListener(listener);
    passwordController.removeListener(listener);
    super.dispose();
  }

  Future<void> register(
    BuildContext context,
    String email,
    String password,
  ) async {
    checkEmail(email);
    if (checkEmail(email)) {
      checkValidPassword(password);
      if (checkValidPassword(password)) {
        ref.loading(true);
        final state =
            await auth.createUserWithEmailAndPassword(email, password);
        ref.loading(false);
        if (!context.mounted) return;
        if (state is ErrorState) {
          context.toast((state).message);
        }
      } else {
        context.toast('Password at least 6 characters');
      }
    } else {
      context.toast('Check your email');
    }
  }

  bool checkEmail(String email) {
    if (RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkValidPassword(String password) {
    if (password.length >= 6) {
      return true;
    } else {
      return false;
    }
  }
}
