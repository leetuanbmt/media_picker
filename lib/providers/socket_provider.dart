// import '../core/config.dart';
// import '../core/models/enum/enum.dart';
// import '../core/utilities/navigator.dart';
// import '../routes/app_routes.gr.dart';
// import '../screens/video_call/webrtc_wrapper/webrtc_wrapper.dart';
// import 'transport.dart';

// final socketProvider = ChangeNotifierProvider((ref) => SocketNotify());

// class SocketNotify extends ChangeNotifier {
//   Transport? transport;

//   CallStatus callStatus = CallStatus.none;

//   OfferSdpData? incomingSDPOffer;

//   String? callerID;

//   bool isComingCall = false;

//   bool get isConnecting => transport?.isConnecting ?? false;

//   void initSocket(String callerID) {
//     this.callerID = callerID;
//     transport = Transport(
//       url: AppConfig.websocketUrl,
//       callerID: callerID,
//     );
//     transport?.connect();
//     listenMessage();
//   }

//   void disconnect() {
//     Logger.log('Transport closed');
//     transport?.close();
//     transport = null;
//   }

//   void listenMessage() {
//     transport?.on(SocketEvent.newCall, null, (ev, context) {
//       incomingCall(ev.eventData);
//     });
//     transport?.on(SocketEvent.callEnded, null, (ev, context) {
//       incomingSDPOffer = null;
//       isComingCall = false;
//       callStatus = CallStatus.none;
//       notifyListeners();
//     });
//   }

//   void incomingCall(dynamic data) {
//     incomingSDPOffer = OfferSdpData.fromJson(data);
//     callStatus = CallStatus.incoming;
//     isComingCall = true;
//     notifyListeners();
//   }

//   void acceptCall() {
//     AppNavigator.instance.appRouter.navigate(
//       CallRoute(
//         callerId: incomingSDPOffer!.callerId,
//         calleeId: callerID!,
//         offer: incomingSDPOffer?.sdpOffer,
//       ),
//     );
//     WidgetsBinding.instance.endOfFrame.whenComplete(() {
//       isComingCall = false;
//       notifyListeners();
//     });
//   }

//   void endCall() {
//     transport?.send(SocketEvent.callEnded, incomingSDPOffer?.toJson());
//     isComingCall = false;
//     notifyListeners();
//   }
// }
