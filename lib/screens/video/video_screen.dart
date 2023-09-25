// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:media_kit/media_kit.dart';
// import 'package:media_kit_video/media_kit_video.dart';
// import 'package:socket_io_client/socket_io_client.dart';

// import '../../core/config.dart';

// class VideoScreen extends StatefulWidget {
//   const VideoScreen({super.key});

//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }

// class _VideoScreenState extends State<VideoScreen> {
//   // Create a [Player] to control playback.
//   late final player = Player();
//   // Create a [VideoController] to handle video output from [Player].
//   late final controller = VideoController(player);

//   @override
//   void initState() {
//     super.initState();
//     // Play a [Media] or [Playlist].

//     player.open(
//       Media(
//         'https://firebasestorage.googleapis.com/v0/b/angular-5facb.appspot.com/o/files%2F1594783936888-gforce_marydelle_106659169_300890047946824_3271753646738026597_n.mp4?alt=media&token=51dce9b5-87a6-4301-96c3-978a69c5de8b',
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.width * 9.0 / 16.0,
//           child: Video(
//             controller: controller,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SignallingService {
//   // instance of Socket
//   Socket? socket;

//   SignallingService._();
//   static final instance = SignallingService._();

//   init({required String websocketUrl, required String selfCallerID}) {
//     // init Socket
//     socket = io(websocketUrl, {
//       "transports": ['websocket'],
//       "query": {"callerId": selfCallerID},
//     });

//     // listen onConnect event
//     socket!.onConnect((data) {
//       Logger.log("Socket connected !!");
//     });

//     // listen onConnectError event
//     socket!.onConnectError((data) {
//       Logger.log("Connect Error $data");
//     });

//     // connect socket
//     socket!.connect();
//   }
// }

// class CallVideo extends StatefulHookConsumerWidget {
//   const CallVideo({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CallVideoState();
// }

// class _CallVideoState extends ConsumerState<CallVideo> {
// // mediaStream for localPeer
//   MediaStream? _localStream;

//   // videoRenderer for localPeer
//   final _localRTCVideoRenderer = RTCVideoRenderer();

//   // videoRenderer for remotePeer
//   final _remoteRTCVideoRenderer = RTCVideoRenderer();

//   @override
//   void initState() {
//     // init Socket new instance with self caller id

//     // final socket = ref.read(socketProvider);

//     _localRTCVideoRenderer.initialize();
//     _remoteRTCVideoRenderer.initialize();

//     // setup Peer Connection
//     _setupPeerConnection();

//     super.initState();
//   }

//   // RTC peer connection
//   RTCPeerConnection? _rtcPeerConnection;

//   // list of rtcCandidates to be sent over signalling
//   List<RTCIceCandidate> rtcIceCandidates = [];

//   // media status
//   bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;

//   Future<void> _setupPeerConnection() async {
//     _rtcPeerConnection = await createPeerConnection(
//       {
//         'iceServers': [
//           {
//             'urls': [
//               'stun:stun1.l.google.com:19302',
//               'stun:stun2.l.google.com:19302',
//             ],
//           },
//         ],
//       },
//     );
//     // listen for remotePeer mediaTrack event
//     _rtcPeerConnection!.onTrack = (event) {
//       _remoteRTCVideoRenderer.srcObject = event.streams[0];
//       setState(() {});
//     };
//     // get localStream
//     _localStream = await navigator.mediaDevices.getUserMedia({
//       'audio': isAudioOn,
//       'video': isVideoOn
//           ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
//           : false,
//     });

//     // add mediaTrack to peerConnection
//     _localStream!.getTracks().forEach((track) {
//       _rtcPeerConnection!.addTrack(track, _localStream!);
//     });

//     // set source for local video renderer
//     _localRTCVideoRenderer.srcObject = _localStream;

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _localRTCVideoRenderer.dispose();
//     _remoteRTCVideoRenderer.dispose();
//     _localStream?.dispose();
//     _rtcPeerConnection?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _remoteRTCVideoRenderer.srcObject != null
//             ? RTCVideoView(_remoteRTCVideoRenderer)
//             : const Text("Waiting for remote stream"),
//       ),
//     );
//   }
// }
