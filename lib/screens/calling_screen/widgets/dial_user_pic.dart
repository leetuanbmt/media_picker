import 'package:flutter/material.dart';

import '../../../widgets/commons/cache_image.dart';

class DialUserPic extends StatelessWidget {
  const DialUserPic({
    Key? key,
    this.dimension = 192,
    required this.image,
  }) : super(key: key);

  final double dimension;
  final String image;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .4;
    return Container(
      padding: EdgeInsets.all(30 / 192 * dimension),
      height: width,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.white.withOpacity(0.02),
            Colors.white.withOpacity(0.05),
          ],
          stops: const [.5, 1],
        ),
      ),
      child: CacheImage(
        image: image,
        dimension: Size.square(dimension),
      ),
    );
  }
}
