import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

import '../core/config.dart';
import '../core/models/models.dart';

final authProvider = StateNotifierProvider.autoDispose<AuthProvider, BaseState>(
  (ref) => AuthProvider(),
);

class AuthProvider extends StateNotifier<BaseState> {
  AuthProvider() : super(const InitialState());

  final googleSignIn = GoogleSignIn();

  Future<void> login(String email, String password) async {
    try {
      state = const LoadingState();
      2.seconds.delayed();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = SuccessState(credential.user);
    } on FirebaseAuthException catch (e) {
      state = ErrorState(message: e.toString());
    }
  }

  Future<void> register(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    context.startLoading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Logger.log(credential);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      context
        ..endLoading()
        ..toast(e.message);
    }
  }

  Future<void> loginGoogle(BuildContext context) async {
    try {
      state = const LoadingState();
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) return;
      final authentication = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      state = SuccessState(userCredential.user);
    } on FirebaseAuthException catch (e) {
      state = ErrorState(message: e.toString());
      Logger.log(e);
    }
  }

  Future<void> loginFacebook(BuildContext context) async {
    state = const LoadingState();
    final result = await FacebookAuth.instance.login();
    switch (result.status) {
      case LoginStatus.success:
        final accessToken = result.accessToken!;
        final credential = FacebookAuthProvider.credential(accessToken.token);
        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        state = SuccessState(userCredential.user);
        break;
      case LoginStatus.cancelled:
        state = const InitialState();
        break;
      case LoginStatus.failed:
        ErrorState(message: 'Login failed with error: ${result.message}');
        break;
      case LoginStatus.operationInProgress:
        ErrorState(message: 'Login failed with error: ${result.message}');
        break;
    }
  }

  Future<void> loginTwitter(BuildContext context) async {
    state = const LoadingState();
    final twitterLogin = TwitterLogin(
      apiKey: AppConfig.twitterConsumerKey,
      apiSecretKey: AppConfig.twitterConsumerSecret,
      redirectURI: 'example://',
    );
    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        final credential = TwitterAuthProvider.credential(
          accessToken: authResult.authToken ?? '',
          secret: authResult.authTokenSecret ?? '',
        );
        FirebaseAuth.instance.signInWithCredential(credential);
        break;
      case TwitterLoginStatus.cancelledByUser:
        state = const InitialState();
        break;
      case TwitterLoginStatus.error:
        state = ErrorState(
          message: 'Login failed with error: ${authResult.errorMessage}',
        );
        break;
      default:
        state = const InitialState();
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
