library webrtc_wrapper;

import 'package:eventify/eventify.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../core/utilities/logger.dart';
part 'peer_connection.dart';
part 'payload_data.dart';

class WebRtcWrapper extends EventEmitter {
  WebRtcWrapper({
    required this.socket,
    required this.calleeId,
    required this.callerId,
    this.name,
    this.maxRetryCount = 3,
    this.autoConnect = true,
    this.offer,
  });
  RTCSessionDescription? offer;
  String callerId, calleeId;
  List<Connection> connections = [];
  bool joined = false;
  bool connected = false;
  String? name;
  bool? videoEnabled = true;
  bool? audioEnabled = true;
  int? maxRetryCount;
  bool? autoConnect;
  Socket socket;

  MediaStream? localStream;

  Connection? connection;

  final localRender = RTCVideoRenderer();

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

  Future<Connection?> initialize() async {
    // create connection by caller

    final localUser = UserJoinedData(userId: callerId, name: name);

    connection = await createConnection(localUser);
    await setLocalStream();
    if (offer != null) {
      // listen to ice candidate
      socket.on("IceCandidate", setIceCandidate);

      final sdp = OfferSdpData(callerId: callerId, sdpOffer: offer);
      // send offer sdp to callee
      _sendAnswerSdp(sdp);
    } else {
      // listen to call answered
      socket.on("callAnswered", callAnswered);
      // send offer sdp to callee

      _sendOfferSdp(calleeId);
    }

    return connection;
  }

  Future<void> callAnswered(dynamic data) async {
    Logger.log(data);
    final OfferSdpData offerSdpData = OfferSdpData.fromJson(data);
    final connection = await createConnection(data);
    await connection?.setOfferSdp(offerSdpData.sdpOffer!);
  }

  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;

  Future<void> setLocalStream() async {
    localRender.initialize();
    localStream = await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': isVideoOn
          ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
          : false,
    });

    localStream!.getTracks().forEach((track) {
      connection?.rtcPeerConnection?.addTrack(track, localStream!);
    });

    localRender.srcObject = localStream;
  }

  void sendMessage(String type, dynamic data) {
    socket.emit(type, data);
  }

  void _sendAnswerSdp(OfferSdpData offerSdpData) async {
    final connection = getConnection(offerSdpData.callerId);
    if (connection != null) {
      await connection.setOfferSdp(offerSdpData.sdpOffer!);

      final answerSdp = await connection.createAnswer();

      sendMessage('answerCall', {
        'callerId': callerId,
        'sdpAnswer': answerSdp.toMap(),
      });
    }
  }

  void _sendOfferSdp(String otherUserId) async {
    final connection = getConnection(otherUserId);
    if (connection != null) {
      final sdp = await connection.createOffer();
      sendMessage('makeCall', {
        'calleeId': otherUserId,
        "sdpOffer": sdp?.toMap(),
      });
    }
  }

  void setIceCandidate(dynamic data) async {
    final dataCandidate = IceCandidateData.fromJson(data);
    final connection = getConnection(dataCandidate.calleeId!);
    await connection?.setCandidate(dataCandidate.candidate!);
  }

  Connection? getConnection(String? userId) {
    final find = connections.where((e) => e.userId == userId);
    if (find.isNotEmpty) {
      return find.first;
    }
    return null;
  }

  void sendIceCandidate(String otherUserId, RTCIceCandidate candidate) {
    sendMessage('IceCandidate', {
      "calleeId": otherUserId,
      "iceCandidate": candidate.toMap(),
    });
  }

  Future<Connection?>? createConnection(UserJoinedData data) async {
    final connection = Connection(
      connectionType: 'incoming',
      userId: data.userId,
      name: data.name,
      audioEnabled: true,
      videoEnabled: true,
    );

    connection.on('user-joined', null, (ev, context) {
      Logger.log('user-joined');
      emit('user-joined');
    });
    connection.on('user-left', null, (ev, context) {
      Logger.log('user-left');
      emit('user-left');
    });
    connection.on('candidate', null, (ev, context) {
      Logger.log('candidate');
      sendIceCandidate(connection.userId!, ev.eventData as RTCIceCandidate);
    });

    connections.add(connection);
    await connection.start();
    return connection;
  }

  bool toggleVideo() {
    if (localStream == null) return false;
    final videoTrack = localStream!.getVideoTracks()[0];
    final bool videoEnabled = videoTrack.enabled = !videoTrack.enabled;
    this.videoEnabled = videoEnabled;
    emit('video-toggle', null, {
      'userId': calleeId,
      'videoEnabled': videoEnabled,
    });
    return videoEnabled;
  }

  bool toggleAudio() {
    if (localStream == null) return false;
    final audioTrack = localStream!.getAudioTracks()[0];
    final bool audioEnabled = audioTrack.enabled = !audioTrack.enabled;
    this.audioEnabled = audioEnabled;

    emit('audio-toggle', null, {
      'userId': calleeId,
      'audioEnabled': audioEnabled,
    });
    return audioEnabled;
  }

  void close() {
    for (var connection in connections) {
      connection.close();
    }
    localRender.dispose();
    localStream?.dispose();
    connections = [];
    connected = false;
    joined = false;
  }

  void reset() {
    connections = [];
    joined = false;
    connected = false;
  }
}
