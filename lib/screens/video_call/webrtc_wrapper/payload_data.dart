part of webrtc_wrapper;

class OfferSdpData {
  String callerId;
  RTCSessionDescription sdpOffer;

  OfferSdpData({required this.callerId, required this.sdpOffer});

  factory OfferSdpData.fromJson(dynamic json) {
    return OfferSdpData(
      callerId: json['callerId'],
      sdpOffer: RTCSessionDescription(
        json['sdpOffer']['sdp'],
        json['sdpOffer']['type'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'callerId': callerId,
      'sdpOffer': sdpOffer.toMap(),
    };
  }
}

class IceCandidateData {
  String calleeId;
  String? name;
  RTCIceCandidate candidate;

  IceCandidateData({
    required this.calleeId,
    this.name,
    required this.candidate,
  });

  factory IceCandidateData.fromJson(dynamic json) {
    return IceCandidateData(
      calleeId: json['calleeId'],
      candidate: RTCIceCandidate(
        json['iceCandidate']['candidate'],
        json['iceCandidate']['sdpMid'],
        json['iceCandidate']['sdpMLineIndex'],
      ),
    );
  }
}
