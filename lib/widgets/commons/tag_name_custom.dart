import '../../core/config.dart';

class TagName extends StatelessWidget {
  const TagName({
    super.key,
    required this.name,
    this.textColor = Colors.black,
    this.fontSize = 12,
  });
  final String name;
  final Color? textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: context.labelMedium?.copyWith(
            color: textColor,
            fontSize: fontSize.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        2.widthBox,
        CircleAvatar(
          radius: 8.r,
          child: Icon(Icons.check, size: 12.sp),
        ),
      ],
    );
  }
}
