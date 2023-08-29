import '../../core/config.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    this.textController,
    this.hintText,
    this.obscureText = false,
    this.fontSize = 16,
    this.radius = 4,
    this.keyboardType,
    this.errorText,
    this.textAlign = TextAlign.start,
  });

  final TextEditingController? textController;
  final bool? obscureText;
  final double? fontSize, radius;
  final String? hintText, errorText;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final style = context.titleMedium!.copyWith(
      color: AppTheme.blackBold,
      fontWeight: FontWeight.w300,
    );

    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: AppTheme.box,
      ),
      borderRadius: BorderRadius.circular(radius!),
    );

    return TextField(
      controller: textController,
      style: style,
      textAlign: textAlign!,
      keyboardType: keyboardType,
      obscureText: obscureText!,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        hintStyle: style.copyWith(color: AppTheme.fontGray),
        focusedBorder: border,
        enabledBorder: border,
      ),
    );
  }
}
