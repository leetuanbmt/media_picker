import 'package:biometric_storage/biometric_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../core/config.dart';
import '../../core/models/models.dart';
import '../../core/utilities/navigator.dart';
import '../firebase_provider.dart';
import 'state/auth.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthenticationState>(
  (ref) => AuthNotifier(ref),
);

class AuthNotifier extends StateNotifier<AuthenticationState> {
  AuthNotifier(this.ref) : super(const AuthenticationState.initial());
  final Ref ref;

  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookAuth.instance;

  Future<void> loginGoogle() async {
    try {
      state = const AuthenticationState.loading();

      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        state = const AuthenticationState.initial();
        return;
      }
      final authentication = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      await checkAndCreatedUser(userCredential.user);
      state = AuthenticationState.success(userCredential.user);
    } on FirebaseAuthException catch (e) {
      state = AuthenticationState.error(message: e.message);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      state = const AuthenticationState.loading();

      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AuthenticationState.success(userCredential.user);
    } on FirebaseAuthException catch (e) {
      state = AuthenticationState.error(message: e.message);
    }
  }

  Future<void> loginFacebook() async {
    state = const AuthenticationState.loading();
    final result = await facebookSignIn.login();
    switch (result.status) {
      case LoginStatus.success:
        final accessToken = result.accessToken!;
        final credential = FacebookAuthProvider.credential(accessToken.token);
        final userCredential = await firebaseAuth.signInWithCredential(
          credential,
        );
        state = AuthenticationState.success(userCredential.user);
      case LoginStatus.cancelled:
        state = const AuthenticationState.initial();
      case LoginStatus.failed:
        state = AuthenticationState.error(
          message: 'Login failed with error: ${result.message}',
        );
      case LoginStatus.operationInProgress:
        state = const AuthenticationState.loading();
    }
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      state = const AuthenticationState.loading();
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AuthenticationState.success(userCredential.user);
    } on FirebaseAuthException catch (e) {
      state = AuthenticationState.error(message: e.message);
    }
  }

  Future<void> checkAndCreatedUser(User? user) async {
    if (user == null || user.email == null) return;
    final isExits = await ref.read(userCheckExits(user.email!).future);
    if (!isExits) {
      final newUser = UserModel.defaultUser.copyWith(
        id: user.uid,
        email: user.email!,
        name: user.displayName ?? '',
        avatar: user.photoURL ?? '',
        phoneNumber: user.phoneNumber ?? '',
      );
      await ref.read(userFirestoreProvider(user.uid)).set(newUser.toJson());
    }
  }

  Future<void> loginTwitter() async {
    state = const AuthenticationState.initial();
    state = const AuthenticationState.error(message: 'Not support yet');
    // state = const AuthenticationState.loading();

    // final twitterLogin = TwitterLogin(
    //   apiKey: AppConfig.twitterConsumerKey,
    //   apiSecretKey: AppConfig.twitterConsumerSecret,
    //   redirectURI: 'example://',
    // );
    // final authResult = await twitterLogin.login();
    // switch (authResult.status) {
    //   case TwitterLoginStatus.loggedIn:
    //     final credential = TwitterAuthProvider.credential(
    //       accessToken: authResult.authToken ?? '',
    //       secret: authResult.authTokenSecret ?? '',
    //     );
    //     final userCredential =
    //         await FirebaseAuth.instance.signInWithCredential(credential);
    //     state = AuthenticationState.success(userCredential.user);
    //     break;
    //   case TwitterLoginStatus.cancelledByUser:
    //     state = const AuthenticationState.initial();
    //     break;
    //   case TwitterLoginStatus.error:
    //     state = AuthenticationState.error(
    //       message: 'Login failed with error: ${authResult.errorMessage}',
    //     );
    //     break;
    //   default:
    //     state = const AuthenticationState.initial();
    // }
  }

  Future<void> loginApple() async {
    try {
      state = const AuthenticationState.loading();
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      state = AuthenticationState.success(userCredential.user);
      await checkAndCreatedUser(userCredential.user);
    } on SignInWithAppleAuthorizationException catch (e) {
      e.code == AuthorizationErrorCode.canceled
          ? state = const AuthenticationState.initial()
          : state = AuthenticationState.error(message: e.toString());
    }
  }

  Future<void> loginFaceID(BuildContext context) async {
    final response = await BiometricStorage().canAuthenticate();
    if (response == CanAuthenticateResponse.success) {
      final storage = await BiometricStorage().getStorage('login');
      final credentials = await storage.read();
      if (credentials != null) {
        final email = credentials.split(' ')[0];
        final password = credentials.split(' ')[1];
        signInWithEmailAndPassword(email, password);
      }
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      await facebookSignIn.logOut();
      AppNavigator.goToLogin();
    } catch (e) {
      Logger.log("Logout error: $e");
    }
  }
}
