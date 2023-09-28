import 'dart:convert';

import 'package:eventify/eventify.dart';
import 'package:web_socket_client/web_socket_client.dart';

import '../core/config.dart';
import '../screens/video_call/webrtc_wrapper/webrtc_wrapper.dart';

class Transport extends EventEmitter {
  String url;
  String callerID;

  WebSocket? socket;

  bool get isConnecting =>
      (socket?.connection is Connected) || (socket?.connection is Reconnected);

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
  }

  void listenEvents(dynamic event) {
    final json = jsonDecode(event) as Map<String, dynamic>;
    final type = json["type"];
    final data = json["data"] as Map<String, dynamic>;
    try {
      switch (type) {
        case SocketEvent.newCall:
          emit(SocketEvent.newCall, null, data);
          break;
        case SocketEvent.callEnded:
          emit(SocketEvent.callEnded, null, data);
          break;
        case SocketEvent.callAnswered:
          emit(SocketEvent.callAnswered, null, data);
          break;
        case SocketEvent.iceCandidate:
          emit(SocketEvent.iceCandidate, null, data);
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
