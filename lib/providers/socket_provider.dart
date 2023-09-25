import 'package:socket_io_client/socket_io_client.dart';

import '../core/config.dart';
import '../core/models/enum/enum.dart';
import '../core/utilities/navigator.dart';
import '../routes/app_routes.gr.dart';
import '../screens/video_call/webrtc_wrapper/webrtc_wrapper.dart';
import 'firebase_provider.dart';

final socketProvider = ChangeNotifierProvider((ref) => SocketNotify(ref));

class SocketNotify extends ChangeNotifier {
  ProviderSubscription? subscription;
  final Ref ref;
  SocketNotify(this.ref) {
    initialize();
    subscription = ref.listen(authStateChangesProvider, (previous, next) {
      if (next.value != null) {
        initialize();
      } else {
        Logger.log("Socket disconnect");
        socket?.disconnect();
        socket = null;
      }
    });
  }
  Socket? socket;

  CallStatus callStatus = CallStatus.none;

  OfferSdpData? incomingSDPOffer;

  String? callerID;

  bool isComingCall = false;

  bool get isSocketConnected => socket?.connected ?? false;

  void initialize() async {
    if (isSocketConnected) return;
    callerID = ref.read(firebaseAuthProvider).currentUser?.uid;
    if (callerID == null) return;
    socket = io(AppConfig.websocketUrl, {
      "transports": ['websocket'],
      "query": {"callerId": callerID},
    });
    socket!.onConnect((data) => Logger.log("Socket connected"));
    socket!.onError((data) => Logger.log(data));
    socket!.on(SocketEvent.newCall, incomingCall);

    socket!.on(SocketEvent.callEnded, (data) {
      incomingSDPOffer = null;
      isComingCall = false;
      callStatus = CallStatus.none;
      notifyListeners();
    });
    socket!.connect();
  }

  void incomingCall(dynamic data) {
    incomingSDPOffer = OfferSdpData.fromJson(data);
    callStatus = CallStatus.incoming;
    isComingCall = true;
    notifyListeners();
  }

  void acceptCall() {
    AppNavigator.instance.appRouter.navigate(
      CallRoute(
        callerId: incomingSDPOffer!.callerId,
        calleeId: callerID!,
        offer: incomingSDPOffer?.sdpOffer,
      ),
    );
    WidgetsBinding.instance.endOfFrame.whenComplete(() {
      isComingCall = false;
      notifyListeners();
    });
  }

  void endCall() {
    socket!.emit(SocketEvent.callEnded, incomingSDPOffer);
    isComingCall = false;
    notifyListeners();
  }

  @override
  void dispose() {
    socket?.disconnect();
    subscription?.close();
    super.dispose();
  }
}
