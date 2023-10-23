import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../config.dart';

export 'db_helper.dart';
export 'language.dart';
export 'logger.dart';
export 'preferences.dart';

class AppUtils {
  AppUtils._();

  static void toast(BuildContext context, String? msg) {
    WidgetsBinding.instance.endOfFrame.then((value) {
      VxToast.show(
        context,
        msg: msg ?? '',
        bgColor: AppTheme.primaryColor,
        textColor: Colors.white,
      );
    });
  }

  static Timestamp? toJsonTime(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }

  static DateTime? fromJsonTime(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  static String formatDuration(Duration duration) {
    return <int>[duration.inMinutes, duration.inSeconds]
        .map((int e) => e.remainder(60).toString().padLeft(2, "0"))
        .join(':');
  }

  static double getTextHeight(
    String text,
    TextStyle textStyle,
    double textWidth,
  ) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: textWidth);
    return textPainter.height;
  }
}

class CustomCacheManager {
  CustomCacheManager._();

  factory CustomCacheManager() => instance;

  static final CustomCacheManager instance = CustomCacheManager._();

  static const key = 'goTipCache';

  static final cache = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );

  Future<FileInfo?> getFile(String url, {bool isAutoDownload = false}) async {
    final fileInfo = await cache.getFileFromCache(url);
    if (isAutoDownload && fileInfo == null) {
      downloadFile(url).then((value) => Logger.log("Download Success"));
    }
    return fileInfo;
  }

  Future<void> downloadFile(String url) async {
    await cache.downloadFile(url);
  }
}
