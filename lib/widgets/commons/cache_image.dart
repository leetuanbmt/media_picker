import 'dart:math';

import 'package:photo_view/photo_view.dart';

import '../../core/config.dart';
import 'shimmer.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
    this.image,
    this.radius = 0,
    this.dimension = 0,
    this.isZoom = false,
  });
  final String? image;
  final double radius, dimension;
  final bool isZoom;
  @override
  Widget build(BuildContext context) {
    final tag = Random().nextInt(1000).toString();
    return SizedBox.square(
      dimension: dimension,
      child: Hero(
        tag: tag,
        child: GestureDetector(
          onTap: () {
            if (image != null && isZoom) {
              Navigator.of(context, rootNavigator: true).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: PhotoViewScreen(
                        imageProvider: NetworkImage(image!),
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
    return PhotoView(
      imageProvider: imageProvider,
      heroAttributes: PhotoViewHeroAttributes(tag: tag),
    );
  }
}
