import 'dart:core';

import '../core/config.dart';

final registerProvider = ChangeNotifierProvider<RegisterProvider>((ref) {
  return RegisterProvider();
});

class RegisterProvider extends ChangeNotifier {
  Validator _email = Validator(null, null);
  Validator _password = Validator(null, null);

  Validator get email => _email;
  Validator get password => _password;

  List<String> userEmail = [
    'example@gmail.com',
    'example1@gmail.com',
    'example2@gmail.com',
  ];

  bool isValidEmailPassword(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void changeEmail(String email) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email) ==
        false) {
      _email = Validator(null, 'Check your email');
    } else if (userEmail.contains(email)) {
      _email = Validator(null, 'Email is valid');
    } else {
      _email = Validator(email, null);
    }
    notifyListeners();
  }

  void changePassword(String pass) {
    if (pass.length >= 6) {
      _password = Validator(pass, null);
    } else {
      _password = Validator(null, 'Must have at least 6 characters');
    }
    notifyListeners();
  }
}

class Validator {
  String? value;
  String? error;
  Validator(this.value, this.error);
}
