import 'package:flutter/foundation.dart';

import '../core/config.dart';
import '../core/models/register/creator_model.dart';
import '../core/models/register/fan_model.dart';

class RegisterProvider extends ChangeNotifier {
  Validator _firstName = Validator(null, null);
  Validator _middleName = Validator(null, null);
  Validator _lastName = Validator(null, null);
  Validator _phoneNumber = Validator(null, null);
  Validator _birthDay = Validator(null, null);
  Validator _gender = Validator(null, null);
  Validator _email = Validator(null, null);
  Validator _password = Validator(null, null);
  Validator _userName = Validator(null, null);
  Validator _anotherName = Validator(null, null);
  Validator _agencyCode = Validator(null, null);
  Validator get firstName => _firstName;
  Validator get middleName => _middleName;
  Validator get lastName => _lastName;
  Validator get email => _email;
  Validator get password => _password;
  Validator get userName => _userName;
  Validator get phoneNumber => _phoneNumber;
  Validator get birthday => _birthDay;
  Validator get gender => _gender;
  Validator get anotherName => _anotherName;
  Validator get agencyCode => _agencyCode;
  List<String> userUsage = [];
  List<String> userCategory = [];

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

  bool isValidInformation(
    String firstName,
    String middleName,
    String lastName,
    String phoneNumber,
    String gender,
    String birthday,
  ) {
    if (firstName.isNotEmpty &&
        middleName.isNotEmpty &&
        lastName.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        gender.isNotEmpty &&
        birthday != '選択する') {
      return true;
    } else {
      return false;
    }
  }

  void getInformation(
    String firstName,
    String middleName,
    String lastName,
    String number,
    String date,
    String gender,
    String anotherName,
    String agencyCode,
  ) {
    _firstName = Validator(firstName, null);
    _middleName = Validator(middleName, null);
    _lastName = Validator(lastName, null);
    _phoneNumber = Validator(number, null);
    _birthDay = Validator(date, null);
    _gender = Validator(gender, null);
    _anotherName = Validator(anotherName, null);
    _agencyCode = Validator(agencyCode, null);
    notifyListeners();
  }

  void changeEmail(String email) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email) ==
        false) {
      _email = Validator('', 'Check your email');
    } else if (userEmail.contains(email)) {
      _email = Validator('', 'Email is valid');
    } else {
      _email = Validator(email, null);
    }
    notifyListeners();
  }

  void changePassword(String pass) {
    if (pass.length >= 6) {
      _password = Validator(pass, null);
    } else {
      _password = Validator('', 'Must have at least 6 characters');
    }
    notifyListeners();
  }

  void changeUserName(String userName) {
    if (userEmail.isNotEmpty) {
      _userName = Validator(userName, '');
    }
  }

  void changeUsage(List<String> listUsage) {
    if (listUsage.isNotEmpty) {
      userUsage = listUsage;
    }
  }

  void changeCategory(List<String> listCategory) {
    if (listCategory.isNotEmpty) {
      userCategory = listCategory;
    }
  }

  void registerFan() {
    if (kDebugMode) {
      print(
        FanModel(
          id: 1,
          email: email.value!,
          password: password.value!,
          userName: userName.value!,
          listUsage: userUsage,
          listCategory: userCategory,
        ),
      );
    }
  }

  void registerCreator() {
    if (kDebugMode) {
      print(
        CreatorModel(
          id: 1,
          email: email.value!,
          password: password.value!,
          surName: firstName.value!,
          middleName: middleName.value!,
          lastName: lastName.value!,
          birthDay: birthday.value!,
          gender: gender.value!,
          phoneNumber: phoneNumber.value!,
          listUsage: userUsage,
          listCategory: userCategory,
          agencyCode: agencyCode.value,
          anotherName: anotherName.value,
        ),
      );
    }
  }

  void clean() {
    firstName.value = null;
    middleName.value = null;
    lastName.value = null;
    birthday.value = null;
    gender.value = null;
    phoneNumber.value = null;
    agencyCode.value = null;
    anotherName.value = null;
    userName.value = null;
    userUsage.clear();
    userCategory.clear();
  }
}

final registerProvider = ChangeNotifierProvider<RegisterProvider>((ref) {
  return RegisterProvider();
});

class Validator {
  String? value;
  String? error;
  Validator(this.value, this.error);
}
