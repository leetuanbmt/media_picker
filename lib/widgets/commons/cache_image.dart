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
    return SizedBox.square(
      dimension: dimension,
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
    );
  }
}
