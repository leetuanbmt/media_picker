import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player/video_player.dart';
import '../../extensions/extension.dart';
import '../../utilities/utilities.dart';
import '../models.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@freezed
abstract class StoryModel with _$StoryModel {
  const StoryModel._();

  const factory StoryModel({
    String? id,
    required String author,
    required String url,
    required String thumbnail,
    required int height,
    required int width,
    required String type,
    required String name,
    required int duration,
    required int timestamp,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  bool get isVideo => type == DbKeys.video;
  bool get isImage => type == DbKeys.image;
  String get timeAgo => timestamp.timeAgo;
  double get aspectRatio => width / height;
}

class StoryList {
  const StoryList({required this.user, required this.stories});
  final UserModel user;
  final List<StoryItem> stories;

  void dispose() {
    for (var element in stories) {
      element.dispose();
    }
  }
}

class StoryItem {
  StoryItem({
    required this.info,
    this.player,
  });
  final StoryModel info;
  bool isLoading = false;
  VideoPlayerController? player;

  void dispose() {
    player?.dispose();
    player = null;
  }
}
