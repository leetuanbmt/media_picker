import '../../core/config.dart';

enum ButtonType {
  normal,
  outline,
}

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    this.type = ButtonType.normal,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.fontSize = 14,
    this.radius = 0,
    this.borderWidth = 1,
    this.height,
    this.width,
    this.borderColor,
    this.onPressed,
    required this.textContent,
  });

  final ButtonType type;
  final Color? textColor, borderColor, backgroundColor;
  final double fontSize, radius, borderWidth;
  final double? height, width;
  final VoidCallback? onPressed;
  final String textContent;

  @override
  Widget build(BuildContext context) {
    Size? size;
    if (width != null && height != null) {
      size = Size(width!, height!);
    } else if (width != null) {
      size = Size.fromWidth(width!);
    } else if (height != null) {
      size = Size.fromHeight(height!);
    }

    BorderSide side = switch (type) {
      ButtonType.outline => BorderSide(
          width: borderWidth,
          color: borderColor ?? AppTheme.primaryColor,
        ),
      _ => BorderSide.none
    };

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null
            ? const Color(0xffC0C8CD)
            : type == ButtonType.normal
                ? AppTheme.primaryColor
                : backgroundColor,
        fixedSize: size,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: side,
        ),
      ),
      child: Text(
        textContent,
        style: TextStyle(
          fontSize: fontSize,
          color: type == ButtonType.outline ? AppTheme.primaryColor : textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
