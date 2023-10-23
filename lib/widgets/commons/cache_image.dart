import 'package:extended_image/extended_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uuid/uuid.dart';
import '../../core/config.dart';
import 'shimmer.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
    this.image,
    this.radius = 0,
    this.isZoom = false,
    this.isHighlighted = false,
    this.dimension = const Size.square(100),
    this.onTap,
  });
  final String? image;
  final double radius;
  final Size dimension;
  final bool isZoom, isHighlighted;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final tag = const Uuid().v4();
    return SizedBox.fromSize(
      size: dimension,
      child: Hero(
        tag: tag,
        child: GestureDetector(
          onTap: onTap ??
              (isZoom
                  ? () {
                      if (image.isNotEmptyAndNotNull && isZoom) {
                        Navigator.of(context, rootNavigator: true).push(
                          PageRouteBuilder(
                            settings:
                                const RouteSettings(name: 'PhotoViewScreen'),
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return FadeTransition(
                                opacity: animation,
                                child: PhotoViewScreen(
                                  imageProvider: context.imageProvider(image),
                                  tag: tag,
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                  : null),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              gradient: isHighlighted ? AppTheme.storyGradient : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(isHighlighted ? 2.0 : 0),
              child: ExtendedImage(
                fit: BoxFit.cover,
                image: ExtendedNetworkImageProvider(
                  image ?? 'https://i.stack.imgur.com/l60Hf.png',
                  cache: true,
                ),
                loadStateChanged: (state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return Shimmer.fromColors(
                        highlightColor: Colors.grey[100]!,
                        baseColor: Colors.grey[300]!,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: Colors.grey[300],
                          ),
                        ),
                      );
                    case LoadState.completed:
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          image: DecorationImage(
                            image: state.imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    case LoadState.failed:
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          color: Colors.grey[300],
                        ),
                        child: const Icon(Icons.error, color: Colors.red),
                      );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({
    super.key,
    required this.imageProvider,
    required this.tag,
  });
  final ImageProvider imageProvider;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoView(
          imageProvider: imageProvider,
          heroAttributes: PhotoViewHeroAttributes(tag: tag),
          minScale: 0.1,
          maxScale: 5.0,
        ),
        Positioned(
          top: 10,
          right: 10,
          child: SafeArea(
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.surface.withOpacity(0.3),
              ),
              child: SizedBox.square(
                dimension: 30.r,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: context.surface,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
