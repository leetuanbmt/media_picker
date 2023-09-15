import '../core/config.dart';
import '../core/models/models.dart';
import 'auth_provider.dart';

final loginProvider = StateNotifierProvider<LoginProvider, BaseState>(
  (ref) => LoginProvider(ref),
);

class LoginProvider extends StateNotifier<BaseState> {
  LoginProvider(this.ref) : super(const InitialState());

  final Ref ref;

  AuthProvider get auth => ref.read(authProvider);

  Future<void> loginGoogle(BuildContext context) async {
    ref.loading(true);
    state = await auth.loginGoogle();
    ref.loading(false);
    if (state is ErrorState && context.mounted) {
      context.toast((state as ErrorState).message);
    }
  }

  Future<void> loginFacebook(BuildContext context) async {
    ref.loading(true);
    state = await auth.loginFacebook();
    ref.loading(false);
    if (state is ErrorState && context.mounted) {
      context.toast((state as ErrorState).message);
    }
  }

  Future<void> loginTwitter(BuildContext context) async {
    ref.loading(true);
    state = await auth.loginTwitter();
    ref.loading(false);
    if (state is ErrorState && context.mounted) {
      context.toast((state as ErrorState).message);
    }
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    ref.loading(true);
    state = await auth.signInWithEmailAndPassword(email, password);
    ref.loading(false);
    if (state is ErrorState && context.mounted) {
      context.toast((state as ErrorState).message);
    }
  }
}
