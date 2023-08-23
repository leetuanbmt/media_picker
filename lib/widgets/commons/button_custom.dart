import '../../core/config.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    this.isOutLine = false,
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.radius = 30,
    this.height = 50,
    this.width = 315,
    this.backgroundColor,
    this.borderWidth,
    this.borderColor,
    this.onPressed,
    required this.textContent,
  });

  final bool? isOutLine;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final double? radius;
  final double? height;
  final double? width;
  final double? borderWidth;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final String textContent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: (isOutLine! && onPressed != null)
              ? Colors.white
              : (!isOutLine! && onPressed != null)
                  ? AppTheme.primaryColor
                  : const Color(0xffC0C8CD),
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
            side: isOutLine!
                ? BorderSide(
                    width: borderWidth ?? 1,
                    color: borderColor ?? AppTheme.primaryColor,
                  )
                : BorderSide.none,
          ),
        ),
        child: Text(
          textContent,
          style: TextStyle(
            fontSize: fontSize,
            color: isOutLine! ? AppTheme.primaryColor : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
