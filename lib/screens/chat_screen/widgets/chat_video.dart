part of '../chat_screen.dart';

class MediaItem {
  MediaItem({
    this.width,
    this.height,
    required this.duration,
    required this.thumbnail,
    required this.url,
  });

  final int? width;
  final int? height;
  final int? duration;
  final String? thumbnail;
  final String? url;
}

class ChatVideo extends StatelessWidget {
  const ChatVideo(this.message, {super.key});
  final Message message;
  @override
  Widget build(BuildContext context) {
    final mediaItem = MediaItem(
      width: 576,
      height: 1024,
      duration: 65,
      thumbnail:
          'https://firebasestorage.googleapis.com/v0/b/codebase-57bc1.appspot.com/o/chat%2Fvideos%2Fthumbnails%2F1647482010685.png?alt=media&token=6085bc41-fc15-4036-b013-e52f43eaf3b1',
      url:
          'https://firebasestorage.googleapis.com/v0/b/codebase-57bc1.appspot.com/o/chat%2Fvideos%2F1647482014775.png?alt=media&token=798b41b0-056c-4584-a45b-134dbddc0c5c',
    );
    final size = AppUtils.sizeImage(
      mediaItem.width!.toDouble(),
      mediaItem.height!.toDouble(),
      targetWidth: context.screenWidth * .7,
      targetHeight: context.screenWidth * .7,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
      child: InkWell(
        onTap: () {
          PreviewMedia.show(
            context,
            files: [
              ZoomImageItem(
                path: mediaItem.url!,
                isVideo: true,
                thumbnail: mediaItem.thumbnail,
              ),
            ],
          );
        },
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.size10),
                child: RepaintBoundary(
                  child: CacheImage(
                    image: mediaItem.thumbnail,
                    dimension: size,
                  ),
                ),
              ),
              const Positioned.fill(
                child: Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
