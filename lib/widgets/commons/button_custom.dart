import '../../core/config.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    this.isOutLine = false,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.fontSize = 14,
    required this.radius,
    required this.height,
    required this.width,
    required this.borderWidth,
    required this.borderColor,
    required this.textContent,
    this.onPressed,
  });

  final bool? isOutLine;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final double radius;
  final double height;
  final double width;
  final double borderWidth;
  final Color borderColor;
  final String textContent;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: (isOutLine! == true && onPressed != null)
              ? Colors.white
              : (isOutLine! == false && onPressed != null)
                  ? AppTheme.primaryColor
                  : Colors.grey,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: isOutLine == true
                ? BorderSide(
                    width: borderWidth,
                    color: borderColor,
                  )
                : BorderSide.none,
          ),
        ),
        child: Text(
          textContent,
          style: TextStyle(
            fontSize: fontSize,
            color: isOutLine! == true ? AppTheme.primaryColor : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
