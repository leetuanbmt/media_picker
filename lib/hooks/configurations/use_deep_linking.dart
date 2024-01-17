import 'package:app_links/app_links.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';

import '../../core/config.dart';

final appLinks = AppLinks();
final linkStream = appLinks.allStringLinkStream.asBroadcastStream();

void useDeepLinking() {
  useEffect(() {
    void uriListener(List<SharedFile> files) async {
      for (final file in files) {
        if (file.type != SharedMediaType.URL) continue;
        final url = Uri.parse(file.value!);
        if (url.pathSegments.length != 2) continue;
        Logger.log('Deep link: ${url.pathSegments}');
      }
    }

    FlutterSharingIntent.instance.getInitialSharing().then(uriListener);

    final mediaStream =
        FlutterSharingIntent.instance.getMediaStream().listen(uriListener);
    final subscription = linkStream.listen((uri) async {
      Logger.log('Deep link: ${uri.toString()}');
    });
    return () {
      mediaStream.cancel();
      subscription.cancel();
    };
  }, []);
}
