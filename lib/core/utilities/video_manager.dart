import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'utilities.dart';

class VideoManager extends ChangeNotifier {
// cache video list controller
  final Map<String, VideoPlayerController> _controllers = {};

  VideoPlayerController? video;

  bool get isPlaying => video?.value.isPlaying ?? false;

  bool get isInitialized => video?.value.isInitialized ?? false;

  bool _isInitNextVideo = false;

  Future<void> play(String url) async {
    video?.pause();
    notifyListeners();
    // check if video is already cached
    if (_controllers.containsKey(url)) {
      Logger.log('Play video from cache from state');
      video = _controllers[url];
    } else {
      // get video from cache and if not found download it
      final fileInfo = await CustomCacheManager.instance.getFile(
        url,
        isAutoDownload: true,
      );

      // if file is not found then initialize video controller with network url

      if (fileInfo == null) {
        Logger.log('Play video from network');
        video = VideoPlayerController.networkUrl(Uri.parse(url));
      } else {
        Logger.log('Play video from cache');
        video = VideoPlayerController.file(fileInfo.file);
      }

      // set video controller to cache list
      _controllers[url] = video!;
    }
    // if current video is not initialized then initialize it
    if (!isInitialized) {
      await video?.initialize();
      video?.setLooping(true);
    } else {
      video?.seekTo(Duration.zero);
    }
    await video?.play();
    notifyListeners();
  }

  // init next video
  void initializeNextVideo(String url) {
    if (_controllers.containsKey(url)) return;
    if (_isInitNextVideo) return;
    _isInitNextVideo = true;
    // get video from cache and if not found download it
    CustomCacheManager.instance
        .getFile(url, isAutoDownload: true)
        .then((fileInfo) {
      // if file is not found then initialize video controller with network url
      if (fileInfo == null) {
        Logger.log('Initialize next video from network');
        _controllers[url] = VideoPlayerController.networkUrl(Uri.parse(url));
      } else {
        Logger.log('Initialize next from cache');
        _controllers[url] = VideoPlayerController.file(fileInfo.file);
      }
      if (!_controllers[url]!.value.isInitialized) {
        _controllers[url]?.initialize().then((value) {
          _isInitNextVideo = false;
        });
      } else {
        _isInitNextVideo = false;
      }
    });
  }

  void resume() => video?.play();

  void pause() => video?.pause();

  void pauseAll() {
    for (var element in _controllers.values) {
      element.pause();
    }
  }
}
