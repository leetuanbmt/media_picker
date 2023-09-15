import 'package:firebase_auth/firebase_auth.dart';

import '../core/config.dart';
import '../core/models/models.dart';
import '../core/repositories/base_repository.dart';
import '../core/utilities/navigator.dart';
import '../core/utilities/utilities.dart';

final loadingProvider = StateProvider<bool>((ref) => false);

final appProvider = Provider((ref) => AppRepositoriesImpl());

final userChange = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

final appGlobalProvider = StateNotifierProvider<AppGlobal, GlobalSetting>(
  (ref) => AppGlobal(),
);

final colorProvider = StateProvider<Color>(
  (ref) => ref.read(appGlobalProvider).themeColor ?? AppTheme.defaultColor,
);

class AppGlobal extends StateNotifier<GlobalSetting> {
  AppGlobal() : super(const GlobalSetting()) {
    navigator(FirebaseAuth.instance.currentUser);
    FirebaseAuth.instance.authStateChanges().listen(navigator);
  }
  void navigator(User? user) {
    if (user != null) {
      AppNavigator.goToDashboard();
    } else {
      AppNavigator.goToLogin();
    }
  }

  void setColor(Color color) {
    state = state.copyWith(themeColor: color);
    AppTheme.primaryColor = color;
    Preferences.themeColor = color.value;
  }
}
