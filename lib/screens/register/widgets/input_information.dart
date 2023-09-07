import '../../../core/config.dart';
import '../../../widgets/commons/text_field_custom.dart';

class InputInformation extends StatelessWidget {
  const InputInformation({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.onTap,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final style = context.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.fontBoldLight,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: style,
        ),
        SizedBox(height: 5.h),
        TextFieldCustom(
          hintText: hintText,
          readOnly: onTap != null,
          suffixIcon: onTap != null
              ? const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppTheme.icon,
                )
              : null,
          textController: controller,
          onTap: onTap,
        ),
      ],
    );
  }
}
