import 'package:firebase_auth/firebase_auth.dart';

import '../core/config.dart';
import '../core/repositories/base_repository.dart';

final appProvider = Provider((ref) => AppRepositoriesImpl());

final userChange = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);
