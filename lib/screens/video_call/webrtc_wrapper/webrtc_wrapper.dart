library webrtc_wrapper;

import 'dart:async';

import 'package:eventify/eventify.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../core/utilities/logger.dart';
part 'string_payload.dart';
part 'payload_data.dart';
// part 'transport.dart';

class WebRtcWrapper extends EventEmitter {
  WebRtcWrapper({
    required this.socket,
    required this.calleeId,
    required this.callerId,
    this.name,
    this.offer,
  });
  RTCSessionDescription? offer;
  String callerId, calleeId;
  String? name;
  bool videoEnabled = true;
  bool audioEnabled = true;
  bool isFrontCameraSelected = true;
  Socket socket;

  late MediaStream localStream;

  late RTCPeerConnection _connection;

  final localRender = RTCVideoRenderer();

  final remoteRender = RTCVideoRenderer();

  List<RTCIceCandidate> candidates = [];

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
  void sendMessage(String type, dynamic data) {
    socket.emit(type, data);
  }

  Future<void> initialize() async {
    try {
      // setup Peer Connection
      localRender.initialize();

      remoteRender.initialize();

      // create peer connection
      _connection = await createPeerConnection(configuration);

      // listen for remotePeer mediaTrack event
      _connection.onTrack = _onTrack;

// get localStream
      localStream = await navigator.mediaDevices.getUserMedia({
        'audio': audioEnabled,
        'video': videoEnabled
            ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
            : false,
      });

// add mediaTrack to peerConnection
      localStream.getTracks().forEach((track) {
        _connection.addTrack(track, localStream);
      });

      // set source for local video renderer
      localRender.srcObject = localStream;

      emit(StringPayload.userJoin);

      listenMessage();
    } catch (e) {
      Logger.log(e);
    }
  }

  Future<void> listenMessage() async {
    // for Incoming call
    if (offer != null) {
      // send iceCandidate generated to remote peer over signalling
      _connection.onIceCandidate = _onIceCandidate;

      // listen for local iceCandidate and add it to the list of IceCandidate
      socket.on(SocketEvent.iceCandidate, setIceCandidate);

      // create SDP Answer
      final sdp = OfferSdpData(callerId: callerId, sdpOffer: offer!);

      // set SDP offer as remoteDescription for peerConnection
      await _connection.setRemoteDescription(sdp.sdpOffer);

      // create SDP Answer
      final answer = await _connection.createAnswer();

      // set SDP answer as localDescription for peerConnection
      await _connection.setLocalDescription(answer);
      sendMessage(SocketEvent.answerCall, {
        'callerId': callerId,
        'sdpOffer': answer.toMap(),
      });
    } else {
      // for Outgoing call

      // listen for local iceCandidate and add it to the list of IceCandidate

      _connection.onIceCandidate = (candidate) => candidates.add(candidate);

      // listen for callAnswered event
      socket.on(SocketEvent.callAnswered, callAnswered);

      // create SDP Offer
      final offer = await _connection.createOffer();

      // set SDP offer as localDescription for peerConnection
      await _connection.setLocalDescription(offer);

      // make a call to remote peer over signalling
      sendMessage(SocketEvent.makeCall, {
        'calleeId': calleeId,
        "sdpOffer": offer.toMap(),
      });
    }
  }

  void sendIceCandidate(RTCIceCandidate candidate) {
    sendMessage(SocketEvent.iceCandidate, {
      "calleeId": calleeId,
      "iceCandidate": candidate.toMap(),
    });
  }

  void callAnswered(dynamic data) async {
    final sdpOffer = OfferSdpData.fromJson(data);
    // set SDP answer as remoteDescription for peerConnection
    await _connection.setRemoteDescription(sdpOffer.sdpOffer);

    // send iceCandidate generated to remote peer over signalling
    for (var element in candidates) {
      sendIceCandidate(element);
    }
  }

  void setIceCandidate(dynamic data) {
    Logger.log('setIceCandidate $data');
    final candidate = IceCandidateData.fromJson(data);
    _connection.addCandidate(candidate.candidate);
  }

  void _onTrack(RTCTrackEvent event) {
    if (event.streams.isEmpty) return;
    remoteRender.srcObject = event.streams.first;
    emit(StringPayload.userJoin);
  }

  void _onIceCandidate(RTCIceCandidate candidate) {
    sendMessage(SocketEvent.iceCandidate, {
      "calleeId": calleeId,
      "iceCandidate": candidate.toMap(),
    });
  }

  void close() {
    try {
      remoteRender.dispose();
      localRender.dispose();
      localStream.dispose();
      _connection.dispose();
    } catch (e) {
      Logger.log(e);
    }
  }
}
