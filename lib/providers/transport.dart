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
    Logger.log(event);
    try {
      switch (event["type"]) {
        case SocketEvent.newCall:
          emit(SocketEvent.callEnded, event["data"]);
          break;
        case SocketEvent.callEnded:
          emit(SocketEvent.callEnded, event["data"]);
          break;
        case SocketEvent.callAnswered:
          emit(SocketEvent.callAnswered, event["data"]);
          break;
        case SocketEvent.iceCandidate:
          emit(SocketEvent.iceCandidate, event["data"]);
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
      payload["data"] = data;
    }
    socket?.send(jsonEncode(payload));
  }

  void close() {
    socket?.close();
    socket = null;
  }
}
