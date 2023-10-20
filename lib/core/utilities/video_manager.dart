import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'utilities.dart';

// class CacheVideoItem {
//   CacheVideoItem(this.url, this.controller);
//   final String url;
//   final VideoPlayerController controller;
// }

class VideoManager extends ChangeNotifier {
// cache video list controller
  final Map<String, VideoPlayerController> _controllers = {};

  VideoPlayerController? video;

  bool get isPlaying => video?.value.isPlaying ?? false;

  bool get isInitialized => video?.value.isInitialized ?? false;

  bool isLoading = false;

  Future<void> play(String url) async {
    video?.pause();
    isLoading = true;
    notifyListeners();
    // check if video is already cached
    if (_controllers.containsKey(url)) {
      Logger.log("Play video from cache from state");
      video = _controllers[url];
    } else {
      // get video from cache and if not found download it
      final fileInfo = await CustomCacheManager.instance.getFile(
        url,
        isAutoDownload: true,
      );

      // if file is not found then initialize video controller with network url

      if (fileInfo == null) {
        Logger.log("Play video from network");
        video = VideoPlayerController.networkUrl(Uri.parse(url));
      }
      Logger.log("Play video from cache");
      video = VideoPlayerController.file(fileInfo!.file);

      // initialize video controller

      // set video controller to cache list
      _controllers[url] = video!;
    }
    // if current video is not initialized then initialize it
    if (!isInitialized) {
      await video?.initialize();
      video?.play();
      video?.setLooping(true);
    } else {
      // if video is already initialized then play it and seek to start
      video?.seekTo(const Duration());
      video?.play();
    }
    isLoading = false;
    notifyListeners();
  }

  // // init next video
  // void initializeNextVideo(String url) async {
  //   if (_controllers.containsKey(url)) {
  //     Logger.log("Play video from cache from state");
  //     video = _controllers[url];
  //   } else {
  //     // get video from cache and if not found download it
  //     final fileInfo = await CustomCacheManager.instance.getFile(
  //       url,
  //       isAutoDownload: true,
  //     );

  //     // if file is not found then initialize video controller with network url

  //     if (fileInfo == null) {
  //       Logger.log("Play video from network");
  //       video = VideoPlayerController.networkUrl(Uri.parse(url));
  //     }
  //     Logger.log("Play video from cache");
  //     video = VideoPlayerController.file(fileInfo!.file);

  //     // initialize video controller
  //     video?.initialize();
  //     // set video controller to cache list
  //     _controllers[url] = video!;
  //   }
  // }

  void resume() {
    video?.play();
  }

  void pause() {
    video?.pause();
  }

  void pauseAll() {
    for (var element in _controllers.values) {
      element.pause();
    }
  }
}
