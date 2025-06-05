import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picker_library/picker_library.dart';
import 'package:video_player/video_player.dart';

import '../../constants/constants.dart';
import '../../internals/singleton.dart';

class AudioPageBuilder extends StatefulWidget {
  const AudioPageBuilder({
    super.key,
    required this.asset,
    this.shouldAutoplayPreview = false,
  });

  final AssetEntity asset;

  final bool shouldAutoplayPreview;

  @override
  State<StatefulWidget> createState() => _AudioPageBuilderState();
}

class _AudioPageBuilderState extends State<AudioPageBuilder> {
  final StreamController<Duration> durationStreamController =
      StreamController<Duration>.broadcast();

  VideoPlayerController get controller => _controller!;
  VideoPlayerController? _controller;

  bool isLoaded = false;

  bool isPlaying = false;

  bool get isControllerPlaying => _controller?.value.isPlaying == true;

  Duration assetDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    openAudioFile();
  }

  @override
  void didUpdateWidget(AudioPageBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.asset != oldWidget.asset) {
      _controller
        ?..removeListener(audioPlayerListener)
        ..pause()
        ..dispose();
      isLoaded = false;
      isPlaying = false;
      assetDuration = Duration.zero;
      openAudioFile();
    }
  }

  @override
  void dispose() {
    _controller
      ?..removeListener(audioPlayerListener)
      ..pause()
      ..dispose();
    super.dispose();
  }

  Future<void> openAudioFile() async {
    try {
      final String? url = await widget.asset.getMediaUrl();
      assetDuration = Duration(seconds: widget.asset.duration);
      _controller = VideoPlayerController.networkUrl(Uri.parse(url!));
      await controller.initialize();
      controller.addListener(audioPlayerListener);
      if (widget.shouldAutoplayPreview) {
        controller.play();
      }
    } catch (e, s) {
      FlutterError.presentError(
        FlutterErrorDetails(
          exception: e,
          stack: s,
          library: packageName,
          silent: true,
        ),
      );
    } finally {
      isLoaded = true;
      safeSetState(() {});
    }
  }

  void audioPlayerListener() {
    if (isControllerPlaying != isPlaying) {
      isPlaying = isControllerPlaying;
      safeSetState(() {});
    }

    durationStreamController.add(controller.value.position);
  }

  void playButtonCallback() {
    if (isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  Widget get titleWidget {
    return ExcludeSemantics(
      child: ScaleText(
        widget.asset.title ?? '',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget get audioControlButton {
    return GestureDetector(
      onTap: playButtonCallback,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12)],
          shape: BoxShape.circle,
        ),
        child: Icon(
          isPlaying ? Icons.pause_circle_outline : Icons.play_circle_filled,
          size: 70,
        ),
      ),
    );
  }

  Widget get durationIndicator {
    final String Function(Duration) durationBuilder =
        Singleton.textDelegate.durationIndicatorBuilder;
    final String Function(Duration) semanticsDurationBuilder =
        Singleton.textDelegate.semanticsTextDelegate.durationIndicatorBuilder;
    return StreamBuilder<Duration>(
      initialData: Duration.zero,
      stream: durationStreamController.stream,
      builder: (BuildContext _, AsyncSnapshot<Duration> data) {
        return ScaleText(
          '${durationBuilder(data.data!)} / ${durationBuilder(assetDuration)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          semanticsLabel:
              '${semanticsDurationBuilder(data.data!)}'
              ' / '
              '${semanticsDurationBuilder(assetDuration)}',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      onLongPress: playButtonCallback,
      onLongPressHint:
          Singleton.textDelegate.semanticsTextDelegate.sActionPlayHint,
      child: ColoredBox(
        color: context.theme.colorScheme.surface,
        child: isLoaded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  titleWidget,
                  audioControlButton,
                  durationIndicator,
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
