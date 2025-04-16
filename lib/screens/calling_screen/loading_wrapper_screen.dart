import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../core/config.dart';
import '../../firebase_options.dart';
import '../../widgets/commons/app_lifecycle.dart';
import '../../widgets/commons/indicators/loading.dart';

final loadingProvider = StateProvider<bool>((ref) => false);

bool isFlutterLocalNotificationsInitialized = false;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupFlutterNotifications();

  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Handling a background message ${message.messageId}');
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launcher_icon',
        ),
      ),
    );
  }
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

class AppWrapperScreen extends StatefulHookConsumerWidget {
  const AppWrapperScreen({super.key, required this.child});
  final Widget child;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppWrapperScreenState();
}

class _AppWrapperScreenState extends ConsumerState<AppWrapperScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Request permissions and initialize the service.
      _initialize();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Consumer(
          builder: (context, ref, child) {
            return ref.watch(loadingProvider)
                ? ColoredBox(
                    color: Colors.black.withValues(alpha: 0.5),
                    child: const Loading(),
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }
}

Future<void> _initialize() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  /// Get the token each time the application loads
  /// android get token
  /// ios get APNs token
  String? token = Platform.isAndroid
      ? await firebaseMessaging.getToken()
      : await firebaseMessaging.getAPNSToken();

  Logger.log('FirebaseMessaging token: $token');
}

class BlurWidget extends HookWidget {
  const BlurWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final visibility = useState(0);

    return AppLifecycleWidget(
      onResumed: () => visibility.value = 0,
      onInactive: () => visibility.value = 1,
      child: AnimatedBuilder(
        animation: visibility,
        builder: (_, __) {
          return Visibility(
            visible: visibility.value != 0,
            child: _Blur(blur: 20, opacity: 0.5 * visibility.value),
          );
        },
      ),
    );
  }
}

class _Blur extends StatelessWidget {
  const _Blur({required this.blur, required this.opacity});
  final double blur, opacity;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(color: Colors.black.withValues(alpha: opacity)),
      ),
    );
  }
}
