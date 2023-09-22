part of webrtc_wrapper;

class MessagePayload {
  String? type;
  dynamic data;

  MessagePayload({this.type, this.data});

  factory MessagePayload.fromJson(dynamic json) {
    return MessagePayload(type: json['type'], data: json['data']);
  }
}

class JoinedMeetingData {
  String? userId;
  String? name;

  JoinedMeetingData({this.userId, this.name});

  factory JoinedMeetingData.fromJson(dynamic json) {
    return JoinedMeetingData(
      userId: json['userId'],
      name: json['name'],
    );
  }
}

class Config {
  bool? videoEnabled;
  bool? audioEnabled;

  Config({this.videoEnabled, this.audioEnabled});
}

class UserJoinedData {
  String? userId;
  String? name;
  Config? config;

  UserJoinedData({this.userId, this.name, this.config});

  factory UserJoinedData.fromJson(dynamic json) {
    return UserJoinedData(
      userId: json['callerId'],
      name: json['name'],
      config: Config(
        audioEnabled: json['config']['audioEnabled'],
        videoEnabled: json['config']['videoEnabled'],
      ),
    );
  }
}

class IncomingConnectionRequestData {
  String? userId;
  String? name;
  Config? config;

  IncomingConnectionRequestData({this.userId, this.name, this.config});

  factory IncomingConnectionRequestData.fromJson(dynamic json) {
    return IncomingConnectionRequestData(
      userId: json['userId'],
      name: json['name'],
      config: Config(
        audioEnabled: json['config']['audioEnabled'],
        videoEnabled: json['config']['videoEnabled'],
      ),
    );
  }
}

class OfferSdpData {
  String? callerId;
  String? name;
  RTCSessionDescription? sdpOffer;

  OfferSdpData({this.callerId, this.name, this.sdpOffer});

  factory OfferSdpData.fromJson(dynamic json) {
    return OfferSdpData(
      callerId: json['callerId'],
      name: json['name'],
      sdpOffer: RTCSessionDescription(
        json['sdpOffer']['sdp'],
        json['sdpOffer']['type'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'callerId': callerId,
      'name': name,
      'sdpOffer': sdpOffer?.toMap(),
    };
  }
}

class AnswerSdpData {
  String? userId;
  String? name;
  RTCSessionDescription? sdpOffer;

  AnswerSdpData({this.userId, this.name, this.sdpOffer});

  factory AnswerSdpData.fromJson(dynamic json) {
    return AnswerSdpData(
      userId: json['userId'],
      name: json['name'],
      sdpOffer: RTCSessionDescription(
        json['sdpOffer']['sdp'],
        json['sdp']['type'],
      ),
    );
  }
}

class MeetingEndedData {
  String? userId;
  String? name;

  MeetingEndedData({this.userId, this.name});

  factory MeetingEndedData.fromJson(dynamic json) {
    return MeetingEndedData(
      userId: json['userId'],
      name: json['name'],
    );
  }
}

class UserLeftData {
  String? userId;
  String? name;

  UserLeftData({this.userId, this.name});

  factory UserLeftData.fromJson(dynamic json) {
    return UserLeftData(
      userId: json['userId'],
      name: json['name'],
    );
  }
}

class IceCandidateData {
  String? calleeId;
  String? name;
  RTCIceCandidate? candidate;

  IceCandidateData({this.calleeId, this.name, this.candidate});

  factory IceCandidateData.fromJson(dynamic json) {
    return IceCandidateData(
      calleeId: json['sender'].toString(),
      candidate: RTCIceCandidate(
        json['iceCandidate']['candidate'],
        json['iceCandidate']['id'],
        json['iceCandidate']['label'],
      ),
    );
  }
}

class VideoToggleData {
  String? userId;
  bool? videoEnabled;

  VideoToggleData({this.userId, this.videoEnabled});

  factory VideoToggleData.fromJson(dynamic json) {
    return VideoToggleData(
      userId: json['userId'],
      videoEnabled: json['videoEnabled'],
    );
  }
}

class AudioToggleData {
  String? userId;
  bool? audioEnabled;

  AudioToggleData({this.userId, this.audioEnabled});

  factory AudioToggleData.fromJson(dynamic json) {
    return AudioToggleData(
      userId: json['userId'],
      audioEnabled: json['audioEnabled'],
    );
  }
}
