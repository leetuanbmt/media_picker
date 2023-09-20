import 'package:biometric_storage/biometric_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../core/config.dart';
import '../core/models/base/base_model.dart';
import 'firebase_provider.dart';

final authProvider = Provider((ref) => AuthProvider(ref));

class AuthProvider {
  final Ref ref;

  AuthProvider(this.ref);

  Future<BaseState> loginGoogle() async {
    try {
      final googleSignIn = ref.watch(googleProvider);
      final auth = ref.watch(firebaseAuthProvider);
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) return const InitialState();
      final authentication = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      final userCredential = await auth.signInWithCredential(credential);
      return SuccessState(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return ErrorState(message: e.message);
    }
  }

  Future<BaseState> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final auth = ref.watch(firebaseAuthProvider);
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SuccessState(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return ErrorState(message: e.message);
    }
  }

  Future<BaseState> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final auth = ref.watch(firebaseAuthProvider);
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SuccessState(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return ErrorState(message: e.message);
    }
  }

  Future<BaseState> loginFacebook() async {
    final result = await FacebookAuth.instance.login();
    switch (result.status) {
      case LoginStatus.success:
        final accessToken = result.accessToken!;
        final credential = FacebookAuthProvider.credential(accessToken.token);
        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        return SuccessState(userCredential.user);
      case LoginStatus.cancelled:
        return const InitialState();
      case LoginStatus.failed:
        return ErrorState(
          message: 'Login failed with error: ${result.message}',
        );
      case LoginStatus.operationInProgress:
        return ErrorState(
          message: 'Login failed with error: ${result.message}',
        );
    }
  }

  Future<BaseState> loginTwitter() async {
    return const InitialState();
    // state = const LoadingState();
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
    //     FirebaseAuth.instance.signInWithCredential(credential);
    //     break;
    //   case TwitterLoginStatus.cancelledByUser:
    //     state = const InitialState();
    //     break;
    //   case TwitterLoginStatus.error:
    //     state = ErrorState(
    //       message: 'Login failed with error: ${authResult.errorMessage}',
    //     );
    //     break;
    //   default:
    //     state = const InitialState();
    // }
  }

  Future<void> loginFaceID() async {
    final response = await BiometricStorage().canAuthenticate();
    if (response == CanAuthenticateResponse.success) {
      final storage = await BiometricStorage().getStorage('login');
      final credentials = await storage.read();
      if (credentials != null) {
        final email = credentials.split(' ')[0];
        final password = credentials.split(' ')[1];
        signInWithEmailAndPassword(email, password);
      } else {
        await storage.write('demo@gmail.com 123456@gotip');
        signInWithEmailAndPassword('demo@gmail.com', '123456@gotip');
      }
    }
  }
}
