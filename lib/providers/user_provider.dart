import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/config.dart';
import '../core/models/call/call.dart';
import '../core/models/models.dart';
import '../core/utilities/navigator.dart';
import '../core/utilities/utilities.dart';
import '../routes/app_routes.gr.dart';
import 'firebase_provider.dart';
import 'global_provider.dart';
import 'paginator_provider.dart';

part 'user_provider.g.dart';
part 'user_provider.freezed.dart';

final userProvider = ChangeNotifierProvider((ref) => UserProvider(ref));
// FutureProvider.autoDispose.family<UserModel, String>(
//   (ref, userId) async {
//     // create a cancel token to cancel request
//     final cancelToken = CancelToken();

//     // cancel request when the provider is disposed
//     ref.onDispose(() => cancelToken.cancel());

//     // access the provider above
//     final repository = ref.watch(appProvider);

//     // use it to return a Future
//     final result = await repository.fetchUserInfo(
//       userId: userId,
//       cancelToken: cancelToken,
//     );
//     return result.when(
//       success: (data) {
//         return data;
//       },
//       failure: (error) {
//         throw error.message ?? 'Error';
//       },
//     );
//   },
// );

class UserProvider with ChangeNotifier {
  UserProvider(this.ref);

  final Ref ref;

  UserModel? user;

  StreamSubscription? _userSubscription;
  StreamSubscription? _callListen;
  initialize() {
    final userId = ref.read(firebaseAuthProvider).currentUser?.uid;
    if (userId != null) {
      _userSubscription = ref
          .firestore()
          .collection(DbCollection.users)
          .doc(userId)
          .snapshots()
          .listen((event) {
        if (event.exists) {
          user = UserModel.fromJson(event.data() as Json);
          notifyListeners();
        }
      });
      _callListen = ref
          .firestore()
          .collection(DbCollection.calls)
          .doc(userId)
          .snapshots()
          .listen(listenPickup);
    }
  }

  void listenPickup(DocumentSnapshot? snapshot) {
    if (snapshot != null && snapshot.exists && snapshot.data() != null) {
      final call = Call.fromJson(snapshot.data()! as Json);
      if (!call.hasDialled) {
        AppNavigator.instance.appRouter.navigate(PickupRoute(call: call));
      }
    }
  }

  @override
  void dispose() {
    _callListen?.cancel();
    _userSubscription?.cancel();
    super.dispose();
  }
}

@freezed
class UserResultState with _$UserResultState {
  const factory UserResultState({
    @JsonKey(name: "total_pages") required int total,
    @Default(false) bool isLoadMore,
    required List<UserModel> data,
  }) = _UserResultState;

  factory UserResultState.fromJson(Map<String, dynamic> json) =>
      _$UserResultStateFromJson(json);
}

@riverpod
class UserList extends _$UserList {
  final List<UserModel> items = [];

  int page = 1;

  int total = 0;

  bool get isHasMore => page < total;

  @override
  Future<UserResultState> build() async {
    final result = await ref.read(appProvider).getUserList(page: page);
    return result.when(
      success: (data) {
        total = data.total;
        items.addAll(data.data);
        return data;
      },
      failure: (error) {
        throw error.message ?? 'Error';
      },
    );
  }

  void updateData() {
    state = AsyncData(state.value!.copyWith(data: items));
  }

  Future<void> loadMore() async {
    if (!state.value!.isLoadMore && isHasMore) {
      state = AsyncData(state.value!.copyWith(isLoadMore: true));
      page++;
      final result = await ref.read(appProvider).getUserList(page: page);
      state = AsyncData(state.value!.copyWith(isLoadMore: false));
      result.when(
        success: (data) {
          items.addAll(data.data);
          updateData();
        },
        failure: (error) {
          throw error.message ?? 'Error';
        },
      );
    }
  }

  Future<void> onRefresh() async {
    page = 1;
    final result = await ref.read(appProvider).getUserList(page: page);
    result.when(
      success: (data) {
        items
          ..clear()
          ..addAll(data.data);
        updateData();
      },
      failure: (error) {
        throw error.message ?? 'Error';
      },
    );
  }
}

final usersProvider = StateNotifierProvider.autoDispose<
    PaginationNotifier<UserModel>, PaginationState<UserModel>>((ref) {
  return PaginationNotifier(
    request: (int page) async {
      final res = await ref.read(appProvider).getUserList(page: page);
      return res.when(
        success: (data) {
          return BaseResponse(
            total: data.total,
            items: data.data,
          );
        },
        failure: (error) {
          throw error.message ?? 'Error';
        },
      );
    },
  );
});
final exampleStreamProvider = StreamProvider.autoDispose<int>((ref) async* {
  for (var i = 0; i < 1000; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
});
