import 'package:app_links/app_links.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';

import '../../config.dart';

final appLinks = AppLinks();

final linkStream = appLinks.allStringLinkStream.asBroadcastStream();

void useDeepLinking() {
  useEffect(() {
    Logger.log('useDeepLinking', tag: 'useDeepLinking');
    void uriListener(List<SharedFile> files) async {
      for (final file in files) {
        if (file.type != SharedMediaType.URL) continue;
        final url = Uri.parse(file.value!);
        if (url.pathSegments.length != 2) continue;
        Logger.log('Deep link: ${url.pathSegments}');
      }
    }

    //
    FlutterSharingIntent.instance.getInitialSharing().then(uriListener);

    // listen to share intent
    final mediaStream =
        FlutterSharingIntent.instance.getMediaStream().listen(uriListener);

    // listen to deep link
    final subscription = linkStream.listen((uri) async {
      Logger.log('Deep link: ${uri.toString()}');
    });
    return () {
      Logger.log('deepLinking cancel', tag: 'useDeepLinking');
      mediaStream.cancel();
      subscription.cancel();
    };
  }, []);
}
