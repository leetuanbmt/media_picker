import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../config.dart';

export 'db_helper.dart';
export 'logger.dart';
export 'preferences.dart';

class AppUtils {
  AppUtils._();

  factory AppUtils() => instance;

  static final AppUtils instance = AppUtils._();

// show toast message
  static void toast(BuildContext context, String? msg) {
    WidgetsBinding.instance.endOfFrame.then((value) {
      VxToast.show(
        context,
        msg: msg ?? '',
        bgColor: context.primaryColor,
        textColor: Colors.white,
      );
    });
  }

// format timestamp to date time
  static Timestamp? toJsonTime(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }

// format date time to timestamp
  static DateTime? fromJsonTime(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

// convert string to duration
  static String formatDuration(Duration duration) {
    return <int>[duration.inMinutes, duration.inSeconds]
        .map((int e) => e.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

// get text height by text style
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

  // crop and share screenshot widget by key
  static Future<void> cropAndShareByKey(GlobalKey globalKey) async {
    final BuildContext? context = globalKey.currentContext;
    if (context == null) return;
    final boundary = context.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();
    if (pngBytes == null) return;
    final directory = (await getApplicationDocumentsDirectory()).path;
    final imgFile = File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes).then((value) {
      Share.shareXFiles([XFile(value.path)]);
    });
  }

// get image size by target size
  static Size sizeImage(
    double currentWidth,
    double currentHeight, {
    required double targetWidth,
    required double targetHeight,
    bool isMax = false,
  }) {
    double w = currentWidth;
    double h = currentHeight;
    final double wd = w / targetWidth;
    final double hd = h / targetHeight;
    final double be = isMax
        ? math.min(1, math.min(wd, hd))
        : math.max(
            1,
            math.max(wd, hd),
          );
    w = w / be;
    h = h / be;
    return Size(w, h);
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
      downloadFile(url).then((value) => Logger.log('Download Success'));
    }
    return fileInfo;
  }

  Future<void> downloadFile(String url) async {
    await cache.downloadFile(url);
  }
}
