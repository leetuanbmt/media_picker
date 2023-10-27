library media_review;

import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

import '../../../core/utilities/utilities.dart';

part 'asset_entity_image_provider.dart';
part 'image_page_builder.dart';
part 'video_page_builder.dart';
part 'audio_page_builder.dart';
part 'video_progress.dart';

class ZoomImageItem {
  ZoomImageItem({required this.path, this.isVideo = false, this.thumbnail});
  final String path;
  final bool isVideo;
  final String? thumbnail;
}

String formatDuration(Duration duration) {
  return <int>[duration.inMinutes, duration.inSeconds]
      .map((int e) => e.remainder(60).toString().padLeft(2, "0"))
      .join(':');
}

class ZoomMedia {
  ZoomMedia.show(
    BuildContext context, {
    required List<ZoomImageItem> files,
    int index = 0,
  }) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        settings: const RouteSettings(
          name: 'ZoomMedia',
        ),
        pageBuilder: (_, animation, __) {
          return FadeTransition(
            opacity: animation,
            child: _MediaBuilderPreviewBuilder(
              files: files,
              index: index,
            ),
          );
        },
      ),
    );
  }
}

class _MediaBuilderPreviewBuilder extends StatefulWidget {
  const _MediaBuilderPreviewBuilder({
    this.files,
    this.assets,
    this.index = 0,
  }) : assert(files == null || assets == null, 'only exit assets or files');
  final List<ZoomImageItem>? files;
  final List<AssetEntity>? assets;
  final int index;

  @override
  _MediaBuilderPreviewBuilderState createState() =>
      _MediaBuilderPreviewBuilderState();
}

class _MediaBuilderPreviewBuilderState
    extends State<_MediaBuilderPreviewBuilder>
    with SingleTickerProviderStateMixin {
  final StreamController<int> _pageStreamController =
      StreamController<int>.broadcast();
  final ValueNotifier<bool> _showAppBar = ValueNotifier<bool>(true);
  late AnimationController _doubleTapAnimationController;
  late Animation<double> _doubleTapCurveAnimation;
  Animation<double>? _doubleTapAnimation;
  late ExtendedPageController pageController;
  late VoidCallback _doubleTapListener;
  late int _currentIndex;
  int get currentIndex => _currentIndex;
  int get total =>
      widget.files == null ? widget.assets!.length : widget.files!.length;

  set currentIndex(int value) {
    if (_currentIndex == value) {
      return;
    }
    _currentIndex = value;
  }

  @override
  void initState() {
    _doubleTapAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _doubleTapCurveAnimation = CurvedAnimation(
      parent: _doubleTapAnimationController,
      curve: Curves.easeInOut,
    );
    _currentIndex = widget.index;
    pageController = ExtendedPageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _showAppBar.dispose();
    _doubleTapAnimationController.dispose();
    _pageStreamController.close();
    super.dispose();
  }

  void updateAnimation(ExtendedImageGestureState? state) {
    final double? begin = state?.gestureDetails?.totalScale;
    final double end = state?.gestureDetails?.totalScale == 1.0 ? 3.0 : 1.0;
    final Offset? pointerDownPosition = state?.pointerDownPosition;

    _doubleTapAnimation?.removeListener(_doubleTapListener);
    _doubleTapAnimationController
      ..stop()
      ..reset();
    _doubleTapListener = () {
      state?.handleDoubleTap(
        scale: _doubleTapAnimation?.value,
        doubleTapPosition: pointerDownPosition,
      );
    };
    _doubleTapAnimation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(_doubleTapCurveAnimation)
      ..addListener(_doubleTapListener);

    _doubleTapAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ExtendedImageGesturePageView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: pageController,
              itemCount: total,
              scrollDirection: Axis.horizontal,
              itemBuilder: assetPageBuilder,
              onPageChanged: (int index) {
                currentIndex = index;
                _pageStreamController.add(index);
                _showAppBar.value = true;
              },
            ),
          ),
          appBar(context),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ValueListenableBuilder<bool>(
      valueListenable: _showAppBar,
      builder: (_, bool value, Widget? child) {
        return AnimatedPositioned(
          duration: kThemeAnimationDuration,
          curve: Curves.easeInOut,
          top: value ? 0.0 : -(padding.top + kToolbarHeight),
          left: 0.0,
          right: 0.0,
          height: padding.top + kToolbarHeight,
          child: Container(
            padding: EdgeInsets.only(top: padding.top, right: 12.0),
            child: Row(
              children: <Widget>[
                const CloseButton(color: Colors.white),
                StreamBuilder<int>(
                  initialData: currentIndex,
                  stream: _pageStreamController.stream,
                  builder: (BuildContext _, AsyncSnapshot<int> snapshot) {
                    return Text(
                      '${snapshot.data! + 1}/$total',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget assetPageBuilder(BuildContext context, int index) {
    if (widget.files != null) {
      final ZoomImageItem asset = widget.files![index];
      if (asset.isVideo) {
        return VideoPageBuilder(
          url: asset.path,
          thumbnail:
              ExtendedNetworkImageProvider(asset.thumbnail!, cache: true),
          autoPlay: true,
          onFinish: () {
            if (index < total - 1) {
              currentIndex = index + 1;
              _pageStreamController.add(index + 1);
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.bounceInOut,
              );
            }
          },
          toggleShowAppBar: (bool value) {
            _showAppBar.value = value;
          },
        );
      } else {
        return ImagePageBuilder(
          url: asset.path,
          updateAnimation: updateAnimation,
        );
      }
    } else {
      final AssetEntity asset = widget.assets!.elementAt(index);
      switch (asset.type) {
        case AssetType.audio:
          return AudioPageBuilder(asset: asset);
        case AssetType.image:
          return ImagePageBuilder(
            asset: asset,
            updateAnimation: updateAnimation,
          );
        case AssetType.video:
          return VideoPageBuilder(
            asset: asset,
            toggleShowAppBar: (bool value) {
              _showAppBar.value = value;
            },
          );
        default:
          return const Center(child: Text('Not support type'));
      }
    }
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox.square(
          dimension: 30,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }
}
