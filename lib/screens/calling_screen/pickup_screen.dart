import 'package:firebase_auth/firebase_auth.dart';

import '../../core/config.dart';
import '../../core/models/call/call.dart';
import '../../core/models/call_history/call_history.dart';
import '../../core/models/enum/enum.dart';
import '../../core/providers/call_provider.dart';
import '../../core/providers/firebase_provider.dart';
import '../../core/routes/app_routes.gr.dart';
import '../../core/utilities/utilities.dart';
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
  String get currentUser => FirebaseAuth.instance.currentUser?.uid ?? '';

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
      callTime: DateTime.now(),
      type: DbKeys.incoming,
    );

    // add call to local storage

    ref
        .read(firestoreProvider)
        .collection(DbCollection.users)
        .doc(call.callerId)
        .collection(DbCollection.callHistories)
        .doc(widget.call.timeepoch.toString())
        .set(call.copyWith(hasDialled: true).toJson());

    if (!isCallMissed) {
      ref
          .read(firestoreProvider)
          .collection(DbCollection.users)
          .doc(call.receiverId)
          .collection(DbCollection.callHistories)
          .doc(widget.call.timeepoch.toString())
          .set(call.copyWith(hasDialled: false).toJson());
    }
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CacheImage(
                image: widget.call.callerPic,
                dimension: MediaQuery.of(context).size,
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: context.screenHeight * .2),
                  Text(
                    widget.call.callerName,
                    style: context.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    context.lang.incomingCall,
                    style: context.bodyMedium?.copyWith(
                      color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}
