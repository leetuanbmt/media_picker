import 'dart:convert';

import 'package:eventify/eventify.dart';
import 'package:web_socket_client/web_socket_client.dart';

import '../core/config.dart';
import '../screens/video_call/webrtc_wrapper/webrtc_wrapper.dart';

class Transport extends EventEmitter {
  String url;
  String callerID;

  WebSocket? socket;

  bool get isConnecting => socket?.connection is Connection;

  Transport({
    required this.url,
    required this.callerID,
  });

  void connect() async {
    socket = WebSocket(
      Uri.parse("${AppConfig.websocketUrl}?callerId=$callerID"),
    );
    socket?.messages.listen((event) {
      listenEvents(event);
    });
    socket?.connection.listen((event) {
      Logger.log(event);
    });
    // socket = io.io(url, <String, dynamic>{
    //   'transports': ['websocket'],
    //   "query": {"callerId": callerID},
    // });
    // socket?.onConnect((data) => Logger.log('Connect: ${socket?.id}'));
    // socket?.onDisconnect((data) => Logger.log('Disconnect: $data'));
    // socket?.onConnectError((data) => Logger.log(data));
    // socket?.connect();
    // listenEvents();
  }

  void listenEvents(dynamic event) {
    final data = jsonDecode(event);
    try {
      Logger.log(data.runtimeType);
      switch (data["type"]) {
        case SocketEvent.newCall:
          emit(SocketEvent.newCall, null, data["data"]);
          break;
        case SocketEvent.callEnded:
          emit(SocketEvent.callEnded, null, data["data"]);
          break;
        case SocketEvent.callAnswered:
          emit(SocketEvent.callAnswered, null, data["data"]);
          break;
        case SocketEvent.iceCandidate:
          emit(SocketEvent.iceCandidate, null, data["data"]);
          break;
        default:
      }
    } catch (e) {
      Logger.log("msg: ${e.toString()}");
    }
  }

  void send(String type, dynamic data) {
    final Map<String, dynamic> payload = {"type": type};
    if (data != null) {
      payload.addAll(data);
    }
    socket?.send(jsonEncode(payload));
  }

  void close() {
    socket?.close();
    socket = null;
  }
}
