// part of webrtc_wrapper;

// class Transport extends EventEmitter {
//   Transport({
//     required this.url,
//     required this.callerId,
//     this.canReconnect,
//     this.maxRetryCount,
//   });

//   String url, callerId;
//   bool? canReconnect = false;
//   int retryCount = 0;
//   int? maxRetryCount = 1;
//   Timer? timer;
//   bool closed = false;
//   Socket? socket;

//   void connect() async {
//     try {
//       if (retryCount <= maxRetryCount!) {
//         retryCount++;
//         socket = io(url, {
//           "transports": ['websocket'],
//           "query": {"callerId": callerId},
//         });

//         socket!.connect();
//         socket!.onConnect((data) => Logger.log("Connect Socket"));
//         listenEvents();
//       } else {
//         emit('failed');
//       }
//     } catch (error) {
//       connect();
//     }
//   }

//   void listenEvents() {
//     socket!.on(
//       SocketEvent.newCall,
//       (data) => emit(SocketEvent.newCall, data),
//     );
//     socket!.on(
//       SocketEvent.callAnswered,
//       (data) => emit(SocketEvent.callAnswered, data),
//     );

//     socket!.on(
//       SocketEvent.iceCandidate,
//       (data) => emit(SocketEvent.iceCandidate, data),
//     );
//     socket!.on(
//       SocketEvent.makeCall,
//       (data) => emit(SocketEvent.makeCall, data),
//     );

//     socket!.on(
//       SocketEvent.callEnded,
//       (data) => emit(SocketEvent.callEnded, data),
//     );
//   }

//   void handleClose() {
//     reset();
//     if (!closed) {
//       connect();
//     }
//   }

//   void handleError(Object error) {
//     reset();
//     if (!closed) {
//       connect();
//     }
//   }

//   void send(dynamic data) {
//     socket!.emit("message", data);
//   }

//   void reset() {
//     if (timer != null) {
//       timer?.cancel();
//       timer = null;
//     }
//   }

//   void close() {
//     closed = true;
//     destroy();
//   }

//   void destroy() {
//     reset();
//     url = '';
//   }

//   void reconnect() {
//     retryCount = 0;
//     connect();
//   }
// }
