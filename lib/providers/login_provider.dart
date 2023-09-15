import 'package:biometric_storage/biometric_storage.dart';

import '../core/config.dart';
import '../core/models/models.dart';
import 'auth_provider.dart';

final loginProvider = ChangeNotifierProvider.autoDispose<LoginProvider>(
  (ref) => LoginProvider(ref)..initialize(),
);

class LoginProvider extends ChangeNotifier {
  LoginProvider(this.ref);

  final Ref ref;

  AuthProvider get auth => ref.read(authProvider);

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool checkFieldsEmpty = true;

  bool saveAccount = false;

  String get email => emailController.text;

  String get password => passwordController.text;

  bool areFieldsEmpty() {
    return email.isEmpty || password.isEmpty;
  }

  void toggleSaveAccount([bool? value]) {
    saveAccount = !saveAccount;
    notifyListeners();
  }

  void listener() {
    checkFieldsEmpty = areFieldsEmpty();
    notifyListeners();
  }

  void initialize() {
    emailController.addListener(listener);
    passwordController.addListener(listener);
    final saveEmail = AppConfig.email.getString();
    final savePassword = AppConfig.password.getString();
    final checkSaveAccount = AppConfig.checkSaveAccount.getBool();
    saveAccount = checkSaveAccount;
    // check save account and set value for email and password
    if (checkSaveAccount && saveEmail != null && savePassword != null) {
      emailController.text = saveEmail;
      passwordController.text = savePassword;
    }
  }

  @override
  void dispose() {
    // remove listener
    emailController.removeListener(listener);
    passwordController.removeListener(listener);

    super.dispose();
  }

  Future<void> loginGoogle(BuildContext context) async {
    ref.loading(true);
    final state = await auth.loginGoogle();
    ref.loading(false);
    if (!context.mounted) return;
    if (state is ErrorState) {
      context.toast((state).message);
    }
  }

  Future<void> loginFacebook(BuildContext context) async {
    ref.loading(true);
    final state = await auth.loginFacebook();
    ref.loading(false);
    if (!context.mounted) return;
    if (state is ErrorState) {
      context.toast((state).message);
    }
  }

  Future<void> loginTwitter(BuildContext context) async {
    ref.loading(true);
    final state = await auth.loginTwitter();
    ref.loading(false);
    if (!context.mounted) return;
    if (state is ErrorState) {
      context.toast((state).message);
    }
  }

  Future<void> login(BuildContext context) async {
    FocusScope.of(context).unfocus();
    AppConfig.checkSaveAccount.setBool(saveAccount);
    if (saveAccount) {
      AppConfig.email.setString(emailController.text);
      AppConfig.password.setString(passwordController.text);
    } else {
      AppConfig.email.setString("");
      AppConfig.password.setString("");
    }

    AppConfig.checkSaveAccount.setBool(saveAccount);

    ref.loading(true);
    final state = await auth.signInWithEmailAndPassword(email, password);
    ref.loading(false);
    if (!context.mounted) return;
    if (state is ErrorState) {
      context.toast((state).message);
    }
  }

  void loginFaceID(BuildContext context) async {
    final response = await BiometricStorage().canAuthenticate();
    if (response == CanAuthenticateResponse.success) {
      final storage = await BiometricStorage().getStorage('login');
      final credentials = await storage.read();
      if (credentials != null) {
        final email = credentials.split(' ')[0];
        final password = credentials.split(' ')[1];
        ref.loading(true);
        final state = await auth.signInWithEmailAndPassword(email, password);
        ref.loading(false);
        if (state is ErrorState && context.mounted) {
          context.toast((state).message);
        }
      }
    }
  }
}
