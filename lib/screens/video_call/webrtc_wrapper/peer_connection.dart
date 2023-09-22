part of webrtc_wrapper;

class Connection extends PeerConnection {
  String? userId;
  String? connectionType;
  String? name;
  bool? videoEnabled = true;
  bool? audioEnabled = true;

  Connection({
    this.userId,
    this.connectionType,
    this.name,
    this.audioEnabled,
    this.videoEnabled,
  });

  void toggleVideo(bool val) {
    videoEnabled = val;
  }

  void toggleAudio(bool val) {
    audioEnabled = val;
  }
}

class PeerConnection extends EventEmitter {
  PeerConnection();

  MediaStream? remoteStream;

  RTCVideoRenderer remoteRender = RTCVideoRenderer();

  RTCPeerConnection? rtcPeerConnection;

  final Map<String, dynamic> configuration = {
    'iceServers': [
      {
        "urls": [
          'stun:stun.l.google.com:19302',
          'stun:stun1.l.google.com:19302',
        ],
      }
    ],
  };
  final Map<String, dynamic> loopbackConstraints = {
    "mandatory": {},
    "optional": [
      {"DtlsSrtpKeyAgreement": true},
    ],
  };

  final Map<String, dynamic> offerSdpConstraints = {
    "mandatory": {
      "OfferToReceiveAudio": true,
      "OfferToReceiveVideo": true,
    },
    "optional": [],
  };

  Future<void> start() async {
    remoteRender.initialize();
    rtcPeerConnection = await createPeerConnection(
      configuration,
      loopbackConstraints,
    );
    rtcPeerConnection!.onAddStream = _onAddStream;
    rtcPeerConnection!.onRemoveStream = _onRemoveStream;
    rtcPeerConnection!.onRenegotiationNeeded = _onRenegotiationNeeded;
    rtcPeerConnection!.onIceCandidate = _onIceCandidate;
    rtcPeerConnection!.onTrack = _onTrack;
  }

  void _onTrack(RTCTrackEvent event) {
    if (event.track.kind == 'video') {
      remoteRender.srcObject = event.streams[0];
      emit('user-joined');
      Logger.log('user-joined');
    }
  }

  void _onAddStream(MediaStream stream) {
    remoteStream = stream;
    remoteRender.srcObject = stream;
  }

  void _onRemoveStream(MediaStream stream) {
    remoteStream = null;
    remoteRender.srcObject = null;
    Logger.log('user-left');
    emit('user-left');
  }

  void _onRenegotiationNeeded() {
    emit('negotiationneeded');
  }

  void _onIceCandidate(RTCIceCandidate candidate) {
    emit('candidate', null, candidate);
  }

  Future<RTCSessionDescription?> createOffer() async {
    try {
      final RTCSessionDescription sdp = await rtcPeerConnection!.createOffer(
        offerSdpConstraints,
      );
      await rtcPeerConnection!.setLocalDescription(sdp);
      return sdp;
    } catch (error) {
      Logger.log(error);
    }
    return null;
  }

  Future<void> setOfferSdp(RTCSessionDescription sdp) async {
    if (rtcPeerConnection != null) {
      await rtcPeerConnection!.setRemoteDescription(sdp);
    }
  }

  Future<RTCSessionDescription> createAnswer() async {
    final RTCSessionDescription sdp = await rtcPeerConnection!.createAnswer(
      offerSdpConstraints,
    );
    await rtcPeerConnection!.setLocalDescription(sdp);
    return sdp;
  }

  Future<void> setAnswerSdp(RTCSessionDescription sdp) async {
    if (rtcPeerConnection != null) {
      await rtcPeerConnection!.setRemoteDescription(sdp);
    }
  }

  Future<void> setCandidate(RTCIceCandidate candidate) async {
    if (rtcPeerConnection != null) {
      await rtcPeerConnection!.addCandidate(candidate);
    }
  }

  void close() {
    if (rtcPeerConnection != null) {
      rtcPeerConnection!.close();
      rtcPeerConnection = null;
    }
    remoteRender.dispose();

    remoteStream = null;
  }
}
