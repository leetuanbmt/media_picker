import '../../core/config.dart';

class TagName extends StatelessWidget {
  const TagName({
    super.key,
    required this.name,
    this.textColor = Colors.black,
    this.fontSize = 12,
    this.isExpanded = false,
  });
  final String name;
  final Color? textColor;
  final double fontSize;
  final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    final title = Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.labelMedium?.copyWith(
        color: textColor,
        fontSize: fontSize.sp,
        fontWeight: FontWeight.w600,
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isExpanded ? Flexible(child: title) : title,
          Gap(2.w),
          CircleAvatar(
            radius: 8.r,
            child: Icon(Icons.check, size: 12.sp),
          ),
        ],
      ),
    );
  }
}
