import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../core/utilities/logger.dart';

typedef StreamStateCallback = void Function(MediaStream stream);

class PeerConnection {
  factory PeerConnection() => _instance;
  PeerConnection._internal();
  static final PeerConnection _instance = PeerConnection._internal();

  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302',
        ],
      }
    ],
  };

  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  String? roomId;
  String? currentRoomText;
  StreamStateCallback? onAddRemoteStream;
  final List<StreamSubscription> _subscriptions = [];
  Future<String> createRoom(String roomId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef = db.collection('rooms').doc(roomId);

    Logger.log('Create PeerConnection with configuration: $configuration');

    peerConnection = await createPeerConnection(configuration);

    registerPeerConnectionListeners();

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    // Code for collecting ICE candidates below
    final callerCandidatesCollection = roomRef.collection('callerCandidates');

    peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      Logger.log('Got candidate: ${candidate.toMap()}');
      callerCandidatesCollection.add(candidate.toMap());
    };
    // Finish Code for collecting ICE candidate

    // Add code for creating a room
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);
    Logger.log('Created offer: $offer');

    Map<String, dynamic> roomWithOffer = {'offer': offer.toMap()};

    await roomRef.set(roomWithOffer);
    Logger.log('New room created with SDK offer. Room ID: $roomId');
    currentRoomText = 'Current room is $roomId - You are the caller!';
    // Created a Room

    peerConnection?.onTrack = (RTCTrackEvent event) {
      Logger.log('Got remote track: ${event.streams[0]}');

      event.streams[0].getTracks().forEach((track) {
        Logger.log('Add a track to the remoteStream $track');
        remoteStream?.addTrack(track);
      });
    };

    // Listening for remote session description below
    final roomAsync = roomRef.snapshots().listen((snapshot) async {
      Logger.log('Got updated room: ${snapshot.data()}');

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (peerConnection?.getRemoteDescription() != null &&
          data['answer'] != null) {
        var answer = RTCSessionDescription(
          data['answer']['sdp'],
          data['answer']['type'],
        );

        Logger.log("Someone tried to connect");
        await peerConnection?.setRemoteDescription(answer);
      }
    });
    _subscriptions.add(roomAsync);
    // Listening for remote session description above

    // Listen for remote Ice candidates below
    final candidateAsync =
        roomRef.collection('calleeCandidates').snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
          Logger.log('Got new remote ICE candidate: ${jsonEncode(data)}');
          peerConnection!.addCandidate(
            RTCIceCandidate(
              data['candidate'],
              data['sdpMid'],
              data['sdpMLineIndex'],
            ),
          );
        }
      }
    });
    _subscriptions.add(candidateAsync);
    // Listen for remote ICE candidates above

    return roomId;
  }

  Future<void> joinRoom(String roomId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Logger.log(roomId);
    final DocumentReference roomRef = db.collection('rooms').doc(roomId);
    final roomSnapshot = await roomRef.get();
    Logger.log('Got room ${roomSnapshot.exists}');

    if (roomSnapshot.exists) {
      Logger.log('Create PeerConnection with configuration: $configuration');
      peerConnection = await createPeerConnection(configuration);

      registerPeerConnectionListeners();

      localStream?.getTracks().forEach((track) {
        peerConnection?.addTrack(track, localStream!);
      });

      // Code for collecting ICE candidates below
      var calleeCandidatesCollection = roomRef.collection('calleeCandidates');
      peerConnection!.onIceCandidate = (RTCIceCandidate? candidate) {
        if (candidate == null) {
          Logger.log('onIceCandidate: complete!');
          return;
        }
        Logger.log('onIceCandidate: ${candidate.toMap()}');
        calleeCandidatesCollection.add(candidate.toMap());
      };
      // Code for collecting ICE candidate above

      peerConnection?.onTrack = (RTCTrackEvent event) {
        Logger.log('Got remote track: ${event.streams[0]}');
        event.streams[0].getTracks().forEach((track) {
          Logger.log('Add a track to the remoteStream: $track');
          remoteStream?.addTrack(track);
        });
      };

      // Code for creating SDP answer below
      final data = roomSnapshot.data() as Map<String, dynamic>;
      Logger.log('Got offer $data');
      final offer = data['offer'];
      await peerConnection?.setRemoteDescription(
        RTCSessionDescription(offer['sdp'], offer['type']),
      );
      final answer = await peerConnection!.createAnswer();
      Logger.log('Created Answer $answer');

      await peerConnection!.setLocalDescription(answer);

      Map<String, dynamic> roomWithAnswer = {
        'answer': {'type': answer.type, 'sdp': answer.sdp},
      };

      await roomRef.update(roomWithAnswer);
      // Finished creating SDP answer

      // Listening for remote ICE candidates below
      final candidateAsync =
          roomRef.collection('callerCandidates').snapshots().listen((snapshot) {
        for (var document in snapshot.docChanges) {
          final data = document.doc.data() as Map<String, dynamic>;
          Logger.log(data);
          Logger.log('Got new remote ICE candidate: $data');
          peerConnection!.addCandidate(
            RTCIceCandidate(
              data['candidate'],
              data['sdpMid'],
              data['sdpMLineIndex'],
            ),
          );
        }
      });
      _subscriptions.add(candidateAsync);
    }
  }

  Future<void> openUserMedia(
    RTCVideoRenderer localVideo,
    RTCVideoRenderer remoteVideo,
  ) async {
    final stream = await navigator.mediaDevices.getUserMedia(
      {
        'audio': false,
        'video': {
          'mandatory': {
            'minWidth': '1920',
            'minHeight': '1080',
            'minFrameRate': '60',
          },
          'facingMode': 'user',
          'optional': [],
        },
      },
    );

    localVideo.srcObject = stream;
    localStream = stream;

    // remoteVideo.srcObject = await createLocalMediaStream('key');
  }

  Future<void> hangUp(RTCVideoRenderer localVideo) async {
    List<MediaStreamTrack> tracks = localVideo.srcObject!.getTracks();
    for (var track in tracks) {
      track.stop();
    }

    if (remoteStream != null) {
      remoteStream!.getTracks().forEach((track) => track.stop());
    }
    if (peerConnection != null) peerConnection!.close();

    if (roomId != null) {
      final db = FirebaseFirestore.instance;
      final roomRef = db.collection('rooms').doc(roomId);
      final calleeCandidates =
          await roomRef.collection('calleeCandidates').get();
      for (final document in calleeCandidates.docs) {
        document.reference.delete();
      }

      var callerCandidates = await roomRef.collection('callerCandidates').get();
      for (final document in callerCandidates.docs) {
        document.reference.delete();
      }

      await roomRef.delete();
    }

    localStream!.dispose();
    remoteStream?.dispose();
  }

  void registerPeerConnectionListeners() {
    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      Logger.log('ICE gathering state changed: $state');
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      Logger.log('Connection state change: $state');
    };

    peerConnection?.onSignalingState = (RTCSignalingState state) {
      Logger.log('Signaling state change: $state');
    };

    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      Logger.log('ICE connection state change: $state');
    };

    peerConnection?.onAddStream = (MediaStream stream) {
      Logger.log("Add remote stream");
      onAddRemoteStream?.call(stream);
      remoteStream = stream;
    };
  }

  void toggleAudio() async {
    if (localStream != null) {
      localStream!.getAudioTracks().forEach((track) {
        track.enabled = !track.enabled;
      });
    }
  }

  void toggleVideo() async {
    if (localStream != null) {
      localStream!.getVideoTracks().forEach((track) {
        track.enabled = !track.enabled;
      });
    }
  }

  void switchCamera() {
    localStream?.getVideoTracks().forEach((track) {
      Helper.switchCamera(track);
    });
  }

  void dispose() {
    peerConnection?.close();
    peerConnection = null;
    for (var element in _subscriptions) {
      element.cancel();
    }
  }
}
