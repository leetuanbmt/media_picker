part of webrtc_wrapper;

class StringPayload {
  StringPayload._();
  static const userJoin = 'user-join';
  static const userLeft = 'user-left';
  static const videoToggle = 'video-toggle';
  static const audioToggle = 'audio-toggle';
  static const candidate = 'candidate';
}

class SocketEvent {
  SocketEvent._();
  static const iceCandidate = 'iceCandidate';
  static const callAnswered = 'callAnswered';
  static const answerCall = 'answerCall';
  static const makeCall = 'makeCall';
  static const newCall = 'newCall';
  static const callEnded = 'callEnded';
}
