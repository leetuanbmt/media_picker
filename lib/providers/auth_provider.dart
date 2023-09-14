import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

import '../core/config.dart';

final authProvider = Provider<AuthProvider>((ref) => AuthProvider._());

class AuthProvider {
  AuthProvider._();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    context.startLoading();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
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
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) return;
      final authentication = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      Logger.log(e);
    }
  }

  Future<void> loginFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();
    switch (result.status) {
      case LoginStatus.success:
        final AccessToken accessToken = result.accessToken!;
        final credential = FacebookAuthProvider.credential(accessToken.token);
        await FirebaseAuth.instance.signInWithCredential(credential);
        break;

      case LoginStatus.cancelled:
        if (!context.mounted) return;
        context.toast('Login cancelled by user.');
        break;
      case LoginStatus.failed:
        if (!context.mounted) return;
        context.toast('Login failed with error: ${result.message}');
        break;

      default:
    }
  }

  Future<void> loginTwitter(BuildContext context) async {
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
        Logger.log('Login cancelled by user.');
        break;
      case TwitterLoginStatus.error:
        Logger.log('Login error: ${authResult.errorMessage}');
        break;
      default:
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
