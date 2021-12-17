library media_picker;

import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

export 'package:photo_manager/photo_manager.dart';

part 'media_picker/asset_entity_image_provider.dart';
part 'media_picker/asset_picker_builder.dart';
part 'media_picker/media_builder_preview.dart';
part 'widgets/thumbnail.dart';
part 'widgets/path_entity_selector.dart';
part 'widgets/path_entity_widget.dart';
part 'widgets/path_list_entity.dart';
part 'media_builder/audio_page_builder.dart';
part 'media_builder/image_page_builder.dart';
part 'media_builder/video_page_builder.dart';
part 'media_builder/video_progress.dart';

class ZoomImageItem {
  ZoomImageItem({this.path, this.isVideo = false, this.thumbnail});
  final String? path;
  final bool isVideo;
  final String? thumbnail;
}

typedef MulCallback = void Function(List<AssetEntity>);

typedef SingleCallback = void Function(AssetEntity);

typedef Callback = void Function(AssetEntity);

class MediaPicker {
  factory MediaPicker() {
    return _instance;
  }
  MediaPicker._internal();
  static final MediaPicker _instance = MediaPicker._internal();
  static void assetPicker(
    BuildContext context, {
    RequestType type = RequestType.common,
    int limit = 10,
    Color appBarColor = Colors.black,
    MulCallback? mulCallback,
    SingleCallback? singleCallback,
    int? limitSize,
    Duration? maxDuration,
    Duration routeDuration = const Duration(milliseconds: 300),
    bool isSingleAssetMode = false,
    bool isReview = true,
    WidgetBuilder? leadingBuilder,
    FilterOptionGroup? filterOptions,
  }) async {
    final bool isPermissionGranted = await PhotoManager.requestPermission();
    if (isPermissionGranted) {
      Navigator.of(context)
          .push(
        MaterialPageRoute(
          builder: (_) => AssetPickerBuilder(
            routeDuration: routeDuration,
            type: type,
            appBarColor: appBarColor,
            isSingleAssetMode: isSingleAssetMode,
            limit: limit,
            maxDuration: maxDuration,
            leadingBuilder: leadingBuilder,
            filterOptions: filterOptions,
            isReview: isReview,
          ),
        ),
      )
          .then(
        (data) {
          if (data != null) {
            if (mulCallback != null && !isSingleAssetMode) {
              mulCallback(data as List<AssetEntity>);
            } else if (singleCallback != null && isSingleAssetMode) {
              singleCallback.call(data.first as AssetEntity);
            }
          }
        },
      );
    } else {
      PhotoManager.openSetting();
    }
  }

  static String formatDuration(Duration duration) {
    return <int>[duration.inMinutes, duration.inSeconds]
        .map((int e) => e.remainder(60).toString().padLeft(2, "0"))
        .join(':');
  }

  static void log(dynamic message, {String tag = ''}) {
    developer.log(message, name: tag);
  }

  static Size sizeImage(
    double currentWidth,
    double currentHeight, {
    required double targetWidth,
    required double targetHeight,
  }) {
    double w = currentWidth;
    double h = currentHeight;
    final double wd = w / targetWidth;
    final double hd = h / targetHeight;
    final double be = math.max(1, math.max(wd, hd));
    w = w / be;
    h = h / be;
    return Size(w, h);
  }
}

extension ContextExt on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Color get primary => colorScheme.primary;
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;
  int get gridCount => (width / 100) ~/ math.min(1, (width / 100) / 4);
  EdgeInsets get padding => mediaQuery.padding;
}

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
    this.width = 50.0,
    this.padding,
    this.isSeparatePlatform = true,
    this.color,
  }) : super(key: key);

  final double width;
  final Color? color;
  final EdgeInsets? padding;
  final bool isSeparatePlatform;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(10.0),
        child: SizedBox(
          width: width,
          height: width,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? context.primary,
            ),
          ),
        ),
      ),
    );
  }
}
