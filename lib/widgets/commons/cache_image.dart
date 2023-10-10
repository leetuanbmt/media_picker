import 'package:photo_view/photo_view.dart';
import 'package:uuid/uuid.dart';
import '../../core/config.dart';
import 'shimmer.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
    this.image,
    this.radius = 0,
    this.dimension = 0,
  });
  final String? image;
  final double radius, dimension;
  @override
  Widget build(BuildContext context) {
    final tag = const Uuid().v4();
    return SizedBox.square(
      dimension: dimension,
      child: Hero(
        tag: tag,
        child: GestureDetector(
          onTap: () {
            if (image.isEmptyOrNull && isZoom) {
              Navigator.of(context, rootNavigator: true).push(
                PageRouteBuilder(
                  settings: const RouteSettings(name: 'PhotoViewScreen'),
                  pageBuilder: (context, animation, secondaryAnimation) {
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
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              image: image == null
                  ? null
                  : DecorationImage(
                      image: context.imageProvider(image),
                      fit: BoxFit.cover,
                    ),
            ),
            child: image == null ? ItemLoading(radius: radius) : null,
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
