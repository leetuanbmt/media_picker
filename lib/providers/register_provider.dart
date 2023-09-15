import 'package:firebase_auth/firebase_auth.dart';

import '../core/config.dart';
import '../core/models/base/base_model.dart';

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterProvider, BaseState>(
  (ref) => RegisterProvider(),
);

class RegisterProvider extends StateNotifier<BaseState> {
  RegisterProvider() : super(const InitialState());

  Future<void> register(
    String email,
    String password,
  ) async {
    checkEmail(email);
    if (checkEmail(email)) {
      checkValidPassword(password);
      if (checkValidPassword(password)) {
        try {
          state = const LoadingState();
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          state = SuccessState(credential.user);
        } on FirebaseAuthException catch (e) {
          state = ErrorState(message: e.message);
        } catch (e) {
          state = ErrorState(message: e.toString());
        }
      } else {
        state = const ErrorState(message: 'Password at least 6 characters');
      }
    } else {
      state = const ErrorState(message: 'Check your email');
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
