import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/config.dart';
import '../core/models/models.dart';
import '../core/utilities/utilities.dart';

typedef Json = Map<String, dynamic>;

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final userFirestoreProvider =
    Provider.autoDispose.family<DocumentReference, String?>(
  (ref, uid) =>
      ref.read(firestoreProvider).collection(DbCollection.users).doc(uid),
);

final authStateChangesProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
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
      .map((e) => e.docs.map((e) => CallHistory.fromJson(e.data())));
});

final creatorOnlineProvider = StreamProvider.autoDispose<List<UserModel>>(
  (ref) {
    final authState = ref.watch(authStateChangesProvider);
    if (authState.value?.uid == null) {
      return const Stream.empty();
    }
    return ref
        .watch(firestoreProvider)
        .collection(DbCollection.users)
        .where(DbKey.type, isEqualTo: UserType.creator.value)
        .where(DbKey.isOnline, isEqualTo: true)
        .snapshots()
        .map((e) => e.docs.map((e) => UserModel.fromJson(e.data())).toList());
  },
);
final userByCategory =
    StreamProvider.autoDispose.family<List<UserModel>, String>(
  (ref, category) {
    return ref
        .read(firestoreProvider)
        .collection(DbCollection.users)
        .where('listCategory', arrayContainsAny: [category])
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) {
            return UserModel.fromJson(snapshot.data()!);
          },
          toFirestore: (user, _) => user.toJson(),
        )
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  },
);

final usersProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(firestoreProvider).collection(DbCollection.users).get().then(
        (value) => value.docs.map((e) => UserModel.fromJson(e.data())).toList(),
      );
});
final userCheckExits = FutureProvider.autoDispose.family<bool, String>(
  (ref, email) async {
    final doc = await ref
        .watch(firestoreProvider)
        .collection(DbCollection.users)
        .where('email', isEqualTo: email)
        .get();
    return doc.docs.isNotEmpty;
  },
);

final followCreator =
    FutureProvider.autoDispose.family<void, String>((ref, createId) {
  return ref
      .read(firestoreProvider)
      .collection(DbCollection.users)
      .doc(createId)
      .set({
    'followers': FieldValue.arrayUnion([createId]),
  });
});
final unFollow =
    FutureProvider.autoDispose.family<void, String>((ref, createId) {
  return ref
      .read(firestoreProvider)
      .collection(DbCollection.users)
      .doc(createId)
      .set({
    'followers': FieldValue.arrayRemove([createId]),
  });
});
