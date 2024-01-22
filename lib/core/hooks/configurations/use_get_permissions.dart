import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../config.dart';
import '../utils/use_async_effect.dart';

void useGetStoragePermissions() {
  useAsyncEffect(
    () async {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      Logger.log('Android SDK: ${androidInfo.version.sdkInt}');
      final hasNoStoragePerm = androidInfo.version.sdkInt < 33 &&
          !await Permission.storage.isGranted &&
          !await Permission.storage.isLimited;

      final hasNoAudioPerm = androidInfo.version.sdkInt >= 33 &&
          !await Permission.audio.isGranted &&
          !await Permission.audio.isLimited;

      if (hasNoStoragePerm) {
        await Permission.storage.request();
      }
      if (hasNoAudioPerm) {
        await Permission.audio.request();
      }
    },
    keys: [],
  );
}

void useGetCameraPermissions({bool isAudio = false}) {
  // request permissions for calling screen
  useAsyncEffect(
    () async {
      await Permission.camera.request();
      if (isAudio) {
        await Permission.microphone.request();
      }
    },
    keys: [],
  );
}
