import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/config.dart';
import '../../core/models/models.dart';
import '../../core/utilities/db_helper.dart';
import '../../core/utilities/navigator.dart';
import '../../routes/app_routes.gr.dart';
import '../firebase_provider.dart';
import 'auth_notify.dart';

final registerProvider = ChangeNotifierProvider.autoDispose<RegisterProvider>(
  (ref) => RegisterProvider(ref)..initialize(),
);

class RegisterProvider extends ChangeNotifier {
  RegisterProvider(this.ref);

  final Ref ref;

  AuthNotifier get auth => ref.read(authProvider.notifier);

  void initialize() {
    emailController.addListener(listener);
    passwordController.addListener(listener);
    userNameController.addListener(usernameListener);
    firstNameController.addListener(informationListener);
    middleNameController.addListener(informationListener);
    lastNameController.addListener(informationListener);
    phoneNumberController.addListener(informationListener);
    genderController.addListener(informationListener);
    dateInputController.addListener(informationListener);
  }

  @override
  void dispose() {
    emailController.removeListener(listener);
    passwordController.removeListener(listener);
    userNameController.removeListener(usernameListener);
    firstNameController.removeListener(informationListener);
    middleNameController.removeListener(informationListener);
    lastNameController.removeListener(informationListener);
    phoneNumberController.removeListener(informationListener);
    genderController.removeListener(informationListener);
    dateInputController.removeListener(informationListener);
    super.dispose();
  }

  void refresh(UserType userType) {
    if (userType == UserType.fan) {
      userNameController.clear();
      listUsage.clear();
      listCategory.clear();
    } else {
      agencyCodeController.clear();
      firstNameController.clear();
      middleNameController.clear();
      lastNameController.clear();
      anotherNameController.clear();
      phoneNumberController.clear();
      genderController.clear();
      dateInputController.clear();
      userNameController.clear();
      listUsage.clear();
      listCategory.clear();
    }
  }

  // register user

  final pageController = PageController(initialPage: 0);

  int activePage = 0;

  void changeActivePage(int page) {
    activePage = page;
    notifyListeners();
  }

  void changePage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.linearToEaseOut,
    );
  }

  // register screen

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String get email => emailController.text;

  String get password => passwordController.text;

  bool checkEmailPasswordEmpty = true;

  bool areEmailPasswordEmpty() {
    return email.isEmpty || password.isEmpty;
  }

  void listener() {
    checkEmailPasswordEmpty = areEmailPasswordEmpty();
    notifyListeners();
  }

  Future<void> checkEmailPassword(BuildContext context) async {
    if (!checkValidEmail(email)) return context.toast('Invalid email');
    if (!checkValidPassword(password)) {
      return context.toast('Password at least 6 characters');
    }
    ref.loading(true);
    try {
      final doc = await ref
          .read(firestoreProvider)
          .collection(DbCollection.users)
          .where('email', isEqualTo: email)
          .get();

      ref.loading(false);
      if (doc.docs.isNotEmpty) {
        if (!context.mounted) return;
        context.toast('Email is used by another account!');
        return;
      } else {
        if (!context.mounted) return;
        context.router.push(const SelectAttributeRoute());
      }
    } catch (e) {
      ref.loading(false);
      if (context.mounted) {
        context.toast(e.toString());
      }
      Logger.log(e.toString());
    }
  }

  bool checkValidEmail(String email) {
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

  // register information screen

  final agencyCodeController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final anotherNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final genderController = TextEditingController();
  final dateInputController = TextEditingController(
    text: '選択する',
  );

  String get agencyCode => agencyCodeController.text;
  String get firstName => firstNameController.text;
  String get middleName => middleNameController.text;
  String get lastName => lastNameController.text;
  String get anotherName => anotherNameController.text;
  String get phoneNumber => phoneNumberController.text;
  String get gender => genderController.text;
  String get dateInput => dateInputController.text;

  bool checkInformationEmpty = true;

  bool areInformationEmpty() {
    return firstNameController.text.isEmpty ||
        middleNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        genderController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        dateInputController.text == '選択する';
  }

  void informationListener() {
    checkInformationEmpty = areInformationEmpty();
    notifyListeners();
  }

  // register username screen
  final userNameController = TextEditingController();

  String get username => userNameController.text;

  bool checkUsernameEmpty = true;

  bool isUsernameEmpty() {
    return username.isEmpty;
  }

  void usernameListener() {
    checkUsernameEmpty = isUsernameEmpty();
    notifyListeners();
  }

  // register usage screen

  List<String> listUsage = [];

  bool checkUsageEmpty = true;

  bool checkUsageActive(String usage) {
    return listUsage.contains(usage);
  }

  void updateUsage(String usage) {
    if (listUsage.contains(usage)) {
      listUsage = [...listUsage..remove(usage)];
      checkUsageEmpty = listUsage.isEmpty;
      checkUsageActive(usage);
    } else {
      listUsage = [...listUsage..add(usage)];
      checkUsageEmpty = listUsage.isEmpty;
      checkUsageActive(usage);
    }
    notifyListeners();
  }

  // register category screen

  List<String> listCategory = [];

  bool checkCategoryEmpty = true;

  bool checkCategoryActive(String category) {
    return listCategory.contains(category);
  }

  void updateCategory(String category) {
    if (listCategory.contains(category)) {
      listCategory = [...listCategory..remove(category)];
      checkCategoryEmpty = listCategory.isEmpty;
      checkUsageActive(category);
    } else {
      listCategory = [...listCategory..add(category)];
      checkCategoryEmpty = listCategory.isEmpty;
      checkCategoryActive(category);
    }
    notifyListeners();
  }

  // register bank account screen

  Future<void> register(
    BuildContext context,
    UserType userType,
  ) async {
    try {
      ref.loading(true);
      await auth.createUserWithEmailAndPassword(email, password);
      final currentUser = ref.read(firebaseAuthProvider).currentUser!.uid;
      await createUser(currentUser, userType).whenComplete(() {
        ref.loading(false);
        AppNavigator.goToDashboard();
      });
    } catch (e) {
      ref.loading(false);
      if (!context.mounted) return;
      context.toast(e.toString());
    }
  }

  Future<void> createUser(String id, UserType userType) async {
    DateTime? dateTime;
    if (userType == UserType.creator) {
      DateFormat dateFormat = DateFormat('yyyy年MM月dd日');
      dateTime = dateFormat.parse(dateInput);
    }

    final user = userType == UserType.creator
        ? UserModel(
            id: id,
            email: email,
            name: username,
            avatar:
                'https://static-00.iconduck.com/assets.00/avatar-default-symbolic-icon-2048x1949-pq9uiebg.png',
            type: userType,
            listTopic: listUsage,
            listCategory: listCategory,
            followers: 0,
            follow: 0,
            points: 0,
            bio: '',
            birthday: dateTime,
            following: [],
            isOnline: false,
            firstName: firstName,
            middleName: middleName,
            lastName: lastName,
            agencyCode: agencyCode,
            anotherName: anotherName,
            gender: gender,
            phoneNumber: phoneNumber,
          )
        : UserModel(
            id: id,
            email: email,
            name: username,
            avatar:
                'https://static-00.iconduck.com/assets.00/avatar-default-symbolic-icon-2048x1949-pq9uiebg.png',
            type: userType,
            listTopic: listUsage,
            listCategory: listCategory,
            followers: 0,
            follow: 0,
            points: 0,
            bio: '',
            following: [],
            isOnline: false,
          );

    await ref
        .watch(firestoreProvider)
        .collection(DbCollection.users)
        .doc(id)
        .set(user.toJson());
  }
}
