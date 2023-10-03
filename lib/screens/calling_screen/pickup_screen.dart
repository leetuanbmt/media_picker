import 'dart:async';

import '../../core/config.dart';
import '../../core/models/call/call.dart';
import '../../core/models/call_history/call_history.dart';
import '../../core/models/enum/enum.dart';
import '../../core/utilities/utilities.dart';
import '../../providers/call_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../routes/app_routes.gr.dart';
import '../../widgets/commons/cache_image.dart';
import 'widgets/dial_button.dart';

@RoutePage()
class PickupScreen extends ConsumerStatefulWidget {
  const PickupScreen({super.key, required this.call});
  final Call call;
  @override
  ConsumerState<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends ConsumerState<PickupScreen> {
  bool isCallMissed = true;
  String get currentUser =>
      ref.read(firebaseAuthProvider).currentUser?.uid ?? '';

  void addToLocalStorage({required CallStatus callStatus}) {
    final call = CallHistory(
      callerId: widget.call.callerId,
      callerName: widget.call.callerName,
      callerPic: widget.call.callerPic,
      receiverId: widget.call.receiverId,
      receiverName: widget.call.receiverName,
      receiverPic: widget.call.receiverPic,
      channelId: widget.call.channelId,
      hasDialled: widget.call.hasDialled,
      isCallMissed: isCallMissed,
      callTime: DateTime.now(),
      callStatus: callStatus,
      type: 'incoming',
    );

    // add call to local storage
    ref
        .read(firestoreProvider)
        .collection(DbCollection.users)
        .doc(call.callerId)
        .collection(DbCollection.callHistories)
        .doc(widget.call.timeepoch.toString())
        .set(call.toJson());

    ref
        .read(firestoreProvider)
        .collection(DbCollection.users)
        .doc(call.receiverId)
        .collection(DbCollection.callHistories)
        .doc(widget.call.timeepoch.toString())
        .set(call.toJson());
  }

  @override
  void initState() {
    ref.listenManual(callStream(currentUser), (previous, next) {
      if (next.value != null && !next.value!.exists) {
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  void deactivate() {
    if (isCallMissed) {
      addToLocalStorage(callStatus: CallStatus.missed);
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: context.screenHeight * .1),
              Text(
                "Incoming...",
                style: TextStyle(fontSize: 30, color: context.primary),
              ),
              const SizedBox(height: 50),
              Center(
                child: CacheImage(
                  image: widget.call.receiverPic,
                  radius: 100,
                  dimension: context.screenWidth * 0.5,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.call.receiverName,
                style: context.headlineMedium?.copyWith(
                  color: context.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DialButton(
                      icon: Icons.call_end,
                      color: Colors.red,
                      onTap: () async {
                        isCallMissed = false;
                        addToLocalStorage(callStatus: CallStatus.rejected);
                        ref.read(callUtils).endCall(widget.call);
                        Navigator.pop(context);
                      },
                    ),
                    DialButton(
                      icon: Icons.call,
                      color: Colors.green,
                      onTap: () async {
                        isCallMissed = false;
                        addToLocalStorage(callStatus: CallStatus.inCall);
                        AutoRouter.of(context)
                            .replace(CallRoute(call: widget.call));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
