import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/config.dart';
import '../core/models/call/call.dart';
import '../core/models/models.dart';
import '../core/utilities/db_helper.dart';
import '../core/utilities/navigator.dart';
import '../routes/app_routes.gr.dart';
import 'user_provider.dart';

final callStream = StreamProvider.autoDispose.family<DocumentSnapshot?, String>(
  (ref, uid) {
    return ref.firestore().collection(DbCollection.calls).doc(uid).snapshots();
  },
);

final callProvider = ChangeNotifierProvider<CallProvider>((ref) {
  return CallProvider(ref);
});

class CallProvider extends ChangeNotifier {
  CallProvider(this.ref);
  final Ref ref;

  CollectionReference get callCollection =>
      ref.firestore().collection(DbCollection.calls);

  void dial(UserModel receiver) async {
    final caller = ref.read(userProvider.notifier).user;
    final call = Call(
      channelId: DateTime.now().millisecondsSinceEpoch.toString(),
      callerId: caller!.id,
      callerName: caller.name,
      callerPic: caller.avatar,
      receiverId: receiver.id,
      receiverName: receiver.name,
      receiverPic: receiver.avatar,
      hasDialled: true,
      timeepoch: DateTime.now().millisecondsSinceEpoch,
    );
    await makeCall(call);
    AppNavigator.instance.appRouter.navigate(CallRoute(call: call));
  }

  Future<void> makeCall(Call call) async {
    try {
      // set call data to firestore
      final hasDialledMap = call.copyWith(hasDialled: true).toJson();
      await callCollection.doc(call.callerId).set(hasDialledMap);

      // add call to receiver call collection
      final hasNotDialledMap = call.copyWith(hasDialled: false).toJson();
      await callCollection.doc(call.receiverId).set(hasNotDialledMap);
    } catch (e) {
      Logger.log("makeCall error: $e");
    }
  }

  Future<void> endCall(Call call) async {
// delete call doc from firestore
    await callCollection.doc(call.callerId).delete();
    await callCollection.doc(call.receiverId).delete();
  }
}
