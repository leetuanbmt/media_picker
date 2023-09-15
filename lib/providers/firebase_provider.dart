import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/models/models.dart';

final googleProvider = Provider((ref) => GoogleSignIn());

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final userFirestoreProvider =
    Provider.autoDispose.family<DocumentReference, String>(
  (ref, uid) => ref.watch(firestoreProvider).collection('users').doc(uid),
);

final authStateChangesProvider = StreamProvider<User?>(
  (ref) => ref.watch(firebaseAuthProvider).authStateChanges(),
);

final userChangeFirebase =
    StreamProvider.autoDispose.family<UserModel?, String>(
  (ref, uid) => ref.watch(userFirestoreProvider(uid)).snapshots().map(
        (event) => event.exists
            ? UserModel.fromJson(event.data() as Map<String, dynamic>)
            : null,
      ),
);
