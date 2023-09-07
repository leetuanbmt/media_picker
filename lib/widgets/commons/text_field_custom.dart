import '../../core/config.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    this.textController,
    this.hintText,
    this.obscureText = false,
    this.fontSize = 16,
    this.radius = 4,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.textAlign = TextAlign.start,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
  });

  final TextEditingController? textController;
  final bool obscureText;
  final double fontSize, radius;
  final String? hintText, errorText;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final bool? readOnly, autofocus;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final style = context.titleMedium!.copyWith(
      fontSize: fontSize,
      color: AppTheme.blackBold,
      fontWeight: FontWeight.w300,
    );

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: AppTheme.box),
      borderRadius: BorderRadius.circular(radius),
    );

    return TextField(
      controller: textController,
      style: style,
      textAlign: textAlign,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autofocus: autofocus!,
      obscuringCharacter: '●',
      readOnly: readOnly!,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10.w),
        hintText: hintText,
        errorText: errorText,
        hintStyle: style.copyWith(color: AppTheme.fontGray),
        suffixIcon: suffixIcon,
        focusedBorder: border,
        enabledBorder: border,
      ),
      onTap: onTap,
    );
  }
}
