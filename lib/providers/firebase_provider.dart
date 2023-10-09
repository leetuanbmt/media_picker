import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/config.dart';
import '../core/models/models.dart';
import '../core/utilities/utilities.dart';

typedef Json = Map<String, dynamic>;

final googleProvider = Provider((ref) => GoogleSignIn());

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final userFirestoreProvider =
    Provider.autoDispose.family<DocumentReference, String?>(
  (ref, uid) =>
      ref.watch(firestoreProvider).collection(DbCollection.users).doc(uid),
);

final authStateChangesProvider = StreamProvider<User?>(
  (ref) => ref.watch(firebaseAuthProvider).authStateChanges(),
);

final userChangeFirebase =
    StreamProvider.autoDispose.family<UserModel?, String?>(
  (ref, uid) {
    if (uid == null) {
      return const Stream.empty();
    }
    return ref.watch(userFirestoreProvider(uid)).snapshots().map(
          (event) =>
              event.exists ? UserModel.fromJson(event.data() as Json) : null,
        );
  },
);

final userListFirestore = StreamProvider.autoDispose<List<UserModel>>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  if (authState.value?.uid == null) {
    return const Stream.empty();
  }
  return ref
      .watch(firestoreProvider)
      .collection(DbCollection.users)
      .snapshots()
      .map(
        (event) => event.docs
            .map((e) => UserModel.fromJson(e.data()))
            .where((e) => e.id != authState.value?.uid)
            .toList(),
      );
});

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final categories = await ref
      .watch(firestoreProvider)
      .collection(DbCollection.categories)
      .get();
  return categories.docs.map((e) => e.data()['title'] as String).toList();
});

final callHistoryProvider = StreamProvider.autoDispose((ref) {
  final authState = ref.watch(authStateChangesProvider);
  if (authState.value?.uid == null) {
    return const Stream.empty();
  }
  return ref
      .watch(firestoreProvider)
      .collection(DbCollection.users)
      .doc(authState.value?.uid)
      .collection(DbCollection.callHistories)
      .orderBy(DbKey.callTime, descending: true)
      .snapshots()
      .map(
        (event) =>
            event.docs.map((e) => CallHistory.fromJson(e.data())).toList(),
      );
});

final creatorOnlineProvider = StreamProvider.autoDispose<List<CreatorModel>>(
  (ref) {
    final authState = ref.watch(authStateChangesProvider);
    if (authState.value?.uid == null) {
      return const Stream.empty();
    }
    return ref
        .watch(firestoreProvider)
        .collection(DbCollection.creators)
        .where(DbKey.isOnline, isEqualTo: true)
        .snapshots()
        .map(
          (e) => e.docs.map((e) => CreatorModel.fromJson(e.data())).toList(),
        );
  },
);

final creatorByCategory =
    StreamProvider.autoDispose<Map<String, List<CreatorModel>>>(
  (ref) {
    final authState = ref.watch(authStateChangesProvider);
    if (authState.value?.uid == null) {
      return const Stream.empty();
    }
    return ref
        .watch(firestoreProvider)
        .collection(DbCollection.creators)
        .snapshots()
        .map((e) => e.docs.map((e) => CreatorModel.fromJson(e.data())))
        .map((event) => event.groupBy((element) => element.category));
  },
);
