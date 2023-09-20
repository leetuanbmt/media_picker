import '../core/config.dart';
import '../core/models/base/base_model.dart';
import 'auth_provider.dart';

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterProvider, BaseState>(
  (ref) => RegisterProvider(ref),
);

class RegisterProvider extends StateNotifier<BaseState> {
  RegisterProvider(this.ref) : super(const InitialState());

  final Ref ref;

  AuthProvider get auth => ref.read(authProvider);

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String get email => emailController.text;

  String get password => passwordController.text;

  final isEmailValid = ValueNotifier<bool>(false);
  final isPasswordValid = ValueNotifier<bool>(false);
  final checkActiveButton = ValueNotifier<bool>(false);

  void checkButton() {
    isEmailValid.value = email.isNotEmpty;
    isPasswordValid.value = password.isNotEmpty;
    if (isEmailValid.value && isPasswordValid.value) {
      checkActiveButton.value = true;
    } else {
      checkActiveButton.value = false;
    }
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
        state = await auth.createUserWithEmailAndPassword(email, password);
        ref.loading(false);
        if (state is ErrorState && context.mounted) {
          context.toast((state as ErrorState).message);
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
