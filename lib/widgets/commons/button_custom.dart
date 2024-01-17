import '../../core/config.dart';
import 'indicators/loading_indicator.dart';

enum ButtonType {
  normal,
  outline,
  text,
}

class ButtonCustom extends StatelessWidget {
  const ButtonCustom(
    this.textContent, {
    super.key,
    this.type = ButtonType.normal,
    this.textColor,
    this.backgroundColor,
    this.fontSize = 14,
    this.radius = 30,
    this.borderWidth = 1,
    this.height,
    this.width,
    this.borderColor,
    this.onPressed,
    this.elevation = 0,
    this.tapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.padding,
    this.fontWeight = FontWeight.w600,
    this.isLoading = false,
  });

  final ButtonType type;
  final Color? textColor, borderColor, backgroundColor;
  final double fontSize, radius, borderWidth, elevation;
  final double? height, width;
  final VoidCallback? onPressed;
  final String textContent;
  final MaterialTapTargetSize? tapTargetSize;
  final EdgeInsetsGeometry? padding;
  final FontWeight fontWeight;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    Size? size;
    Size minimumSize = const Size(64, 36);
    if (width != null && height != null) {
      size = Size(width!, height!);
      minimumSize = size;
    } else if (width != null) {
      size = Size.fromWidth(width!);
      minimumSize = Size(width!, minimumSize.height);
    } else if (height != null) {
      size = Size.fromHeight(height!);
      minimumSize = Size(minimumSize.width, height!);
    }

    BorderSide side = switch (type) {
      ButtonType.outline => BorderSide(
          width: borderWidth,
          color: borderColor ?? textColor ?? context.primaryColor,
        ),
      _ => BorderSide.none
    };

    Color bgColor = backgroundColor ??
        (type == ButtonType.outline ? Colors.white : context.primaryColor);

    Color? titleColor = textColor ??
        (type == ButtonType.outline ? context.primaryColor : Colors.white);
    return switch (type) {
      ButtonType.text => TextButton(
          style: TextButton.styleFrom(
            padding: padding,
            tapTargetSize: tapTargetSize,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            textContent,
            style: context.bodyMedium!.copyWith(
              fontSize: fontSize,
              color: textColor ?? context.primaryColor,
              fontWeight: fontWeight,
            ),
          ),
        ),
      _ => ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            fixedSize: size,
            minimumSize: minimumSize,
            elevation: elevation,
            tapTargetSize: tapTargetSize,
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: side,
            ),
          ),
          child: isLoading
              ? LoadingIndicator(
                  color: titleColor,
                )
              : AutoSizeText(
                  textContent,
                  style: context.bodyMedium!.copyWith(
                    fontSize: fontSize,
                    color: titleColor,
                    fontWeight: fontWeight,
                  ),
                  maxLines: 1,
                ),
        )
    };
  }
}
