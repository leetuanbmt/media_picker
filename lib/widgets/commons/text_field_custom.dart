import '../../core/config.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    this.textController,
    this.hintText,
    this.obscureText = false,
    this.fontSize = 16,
    this.hintSize = 16,
    this.radius = 4,
    this.keyboardType,
    this.errorText,
  });

  final TextEditingController? textController;
  final bool? obscureText;
  final double? fontSize, hintSize, radius;
  final String? hintText, errorText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    double size = obscureText! ? 24 : fontSize!;
    double paddingText = (44 - size) / 2;

    return TextField(
      controller: textController,
      style: context.titleMedium!.copyWith(
        fontSize: size,
        color: AppTheme.blackBold,
        fontWeight: FontWeight.w300,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText!,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        hintStyle: context.bodyLarge!.copyWith(
          fontSize: hintSize,
          color: AppTheme.fontGray,
          fontWeight: FontWeight.w300,
        ),
        contentPadding: EdgeInsets.fromLTRB(
          10,
          paddingText,
          0,
          paddingText,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppTheme.box,
          ),
          borderRadius: BorderRadius.circular(radius!),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppTheme.box,
          ),
          borderRadius: BorderRadius.circular(radius!),
        ),
      ),
    );
  }
}
