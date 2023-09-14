import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

import '../core/config.dart';
import '../core/models/base/base_model.dart';

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterProvider, BaseState>(
  (ref) => RegisterProvider(),
);

class RegisterProvider extends StateNotifier<BaseState> {
  RegisterProvider() : super(const InitialState());

  Future<void> register(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      state = const LoadingState();
      2.seconds.delayed();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = SuccessState(credential.user);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;

      state = ErrorState(message: e.toString());
      context
        ..endLoading()
        ..toast(e.message);
    }
  }
}
