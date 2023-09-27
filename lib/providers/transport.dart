import 'package:eventify/eventify.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../core/utilities/logger.dart';
import '../screens/video_call/webrtc_wrapper/webrtc_wrapper.dart';

class Transport extends EventEmitter {
  String url;
  String callerID;

  io.Socket? socket;

  bool get isConnecting => socket?.connected ?? false;

  Transport({
    required this.url,
    required this.callerID,
  });

  void connect() async {
    socket = io.io(url, <String, dynamic>{
      'transports': ['websocket'],
      "query": {"callerId": callerID},
    });
    socket?.onConnect((data) => Logger.log('Connect: ${socket?.id}'));
    socket?.onDisconnect((data) => Logger.log('Disconnect: $data'));
    socket?.onConnectError((data) => Logger.log(data));
    socket?.connect();
    listenEvents();
  }

  void listenEvents() {
    socket?.on(
      SocketEvent.newCall,
      (data) => emit(SocketEvent.newCall, null, data),
    );
    socket?.on(
      SocketEvent.callEnded,
      (data) => emit(SocketEvent.callEnded, null, data),
    );

    socket?.on(
      SocketEvent.callAnswered,
      (data) => emit(SocketEvent.callAnswered, null, data),
    );

    socket?.on(
      SocketEvent.iceCandidate,
      (data) => emit(SocketEvent.iceCandidate, null, data),
    );
  }

  void send(String type, dynamic data) {
    socket?.emit(type, data);
  }

  void close() {
    socket?.close();
    socket = null;
  }
}
