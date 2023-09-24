// part of webrtc_wrapper;

// class Connection extends PeerConnection {
//   String? userId;
//   String? connectionType;
//   String? name;
//   bool? videoEnabled = true;
//   bool? audioEnabled = true;

//   Connection({
//     this.userId,
//     this.connectionType,
//     this.name,
//     this.audioEnabled,
//     this.videoEnabled,
//   });

//   void toggleVideo(bool val) {
//     videoEnabled = val;
//   }

//   void toggleAudio(bool val) {
//     audioEnabled = val;
//   }
// }

// class PeerConnection extends EventEmitter {
//   PeerConnection();

//   RTCVideoRenderer remoteRender = RTCVideoRenderer();

//   RTCPeerConnection? rtcPeerConnection;

//   final Map<String, dynamic> configuration = {
//     'iceServers': [
//       {
//         "urls": [
//           'stun:stun.l.google.com:19302',
//           'stun:stun1.l.google.com:19302',
//         ],
//       }
//     ],
//   };

//   Future<void> start() async {
//     remoteRender.initialize();
//     rtcPeerConnection = await createPeerConnection(configuration);
//     rtcPeerConnection!.onAddStream = _onAddStream;
//     rtcPeerConnection!.onRemoveStream = _onRemoveStream;
//     rtcPeerConnection!.onRenegotiationNeeded = _onRenegotiationNeeded;
//     rtcPeerConnection!.onIceCandidate = _onIceCandidate;
//     rtcPeerConnection!.onTrack = _onTrack;
//   }

//   void _onTrack(RTCTrackEvent event) {
//     if (event.track.kind == 'video') {
//       remoteRender.srcObject = event.streams[0];
//       emit(StringPayload.userJoin);
//       Logger.log('user-joined');
//     }
//   }

//   void _onAddStream(MediaStream stream) {
//     remoteRender.srcObject = stream;
//     emit(StringPayload.userJoin);
//   }

//   void _onRemoveStream(MediaStream stream) {
//     remoteRender.srcObject = null;
//     emit(StringPayload.userLeft);
//   }

//   void _onRenegotiationNeeded() {
//     emit('negotiationneeded');
//   }

//   void _onIceCandidate(RTCIceCandidate candidate) {
//     emit(StringPayload.candidate, null, candidate);
//   }

//   Future<RTCSessionDescription?> createOffer() async {
//     try {
//       final sdp = await rtcPeerConnection!.createOffer();
//       await rtcPeerConnection!.setLocalDescription(sdp);
//       return sdp;
//     } catch (error) {
//       Logger.log(error);
//     }
//     return null;
//   }

//   Future<RTCSessionDescription> createAnswer() async {
//     final sdp = await rtcPeerConnection!.createAnswer();
//     await rtcPeerConnection!.setLocalDescription(sdp);
//     return sdp;
//   }

//   Future<void> setSdp(RTCSessionDescription sdp) async {
//     if (rtcPeerConnection != null) {
//       await rtcPeerConnection!.setRemoteDescription(sdp);
//     }
//   }

//   Future<void> setCandidate(RTCIceCandidate candidate) async {
//     if (rtcPeerConnection != null) {
//       await rtcPeerConnection!.addCandidate(candidate);
//     }
//   }

//   void close() {
//     if (rtcPeerConnection != null) {
//       rtcPeerConnection!.close();
//       rtcPeerConnection = null;
//     }
//     remoteRender.dispose();
//   }
// }
