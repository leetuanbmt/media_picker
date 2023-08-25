import '../core/config.dart';

class CustomDecoration extends Decoration {
  final Color? backgroundColor;
  final double frameSFactor;
  final double? gap;

  const CustomDecoration({
    this.backgroundColor = Colors.transparent,
    required this.frameSFactor,
    this.gap,
  });
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CustomDecorationPainter(
      backgroundColor: backgroundColor!,
      frameSFactor: frameSFactor,
      padding: gap ?? 0,
    );
  }
}

class CustomDecorationPainter extends BoxPainter {
  final Color backgroundColor;
  final double frameSFactor;
  final double padding;

  CustomDecorationPainter({
    required this.backgroundColor,
    required this.frameSFactor,
    required this.padding,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;
    final frameHWidth = configuration.size!.width * frameSFactor;

    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.w;

    /// background
    canvas.drawRRect(
      RRect.fromRectAndRadius(bounds, const Radius.circular(0)),
      paint..color = Colors.transparent,
    );

    paint.color = AppTheme.primaryColor;

    /// top left
    canvas.drawLine(
      bounds.topLeft + Offset(padding, padding),
      Offset(bounds.topLeft.dx + frameHWidth, bounds.topLeft.dy) +
          Offset(padding, padding),
      paint,
    );
    canvas.drawLine(
      bounds.topLeft + Offset(padding, padding),
      Offset(bounds.topLeft.dx, bounds.topLeft.dy + frameHWidth) +
          Offset(padding, padding),
      paint,
    );

    //top Right
    canvas.drawLine(
      Offset(bounds.topRight.dx - padding, bounds.topRight.dy + padding),
      Offset(
        bounds.topRight.dx - padding - frameHWidth,
        bounds.topRight.dy + padding,
      ),
      paint,
    );
    canvas.drawLine(
      Offset(bounds.topRight.dx - padding, bounds.topRight.dy + padding),
      Offset(
        bounds.topRight.dx - padding,
        bounds.topRight.dy + padding + frameHWidth,
      ),
      paint..color,
    );

    //bottom Right
    canvas.drawLine(
      Offset(bounds.bottomRight.dx - padding, bounds.bottomRight.dy - padding),
      Offset(
        bounds.bottomRight.dx - padding,
        bounds.bottomRight.dy - padding - frameHWidth,
      ),
      paint,
    );
    canvas.drawLine(
      Offset(bounds.bottomRight.dx - padding, bounds.bottomRight.dy - padding),
      Offset(
        bounds.bottomRight.dx - padding - frameHWidth,
        bounds.bottomRight.dy - padding,
      ),
      paint,
    );
//bottom Left
    canvas.drawLine(
      Offset(bounds.bottomLeft.dx + padding, bounds.bottomLeft.dy - padding),
      Offset(
        bounds.bottomLeft.dx + padding,
        bounds.bottomLeft.dy - padding - frameHWidth,
      ),
      paint,
    );
    canvas.drawLine(
      Offset(bounds.bottomLeft.dx + padding, bounds.bottomLeft.dy - padding),
      Offset(
        bounds.bottomLeft.dx + padding + frameHWidth,
        bounds.bottomLeft.dy - padding,
      ),
      paint,
    );
  }
}
