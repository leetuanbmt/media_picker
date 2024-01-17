// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../../core/config.dart';

class EditItem extends StatelessWidget {
  const EditItem({
    super.key,
    this.textContent,
    this.content,
    this.showTrailing = true,
    this.onTap,
    this.title,
    this.isLastItem = false,
  });
  final String? title, textContent;
  final Widget? content;
  final bool showTrailing;
  final VoidCallback? onTap;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: AppTheme.textiked),
          bottom: isLastItem
              ? const BorderSide(color: AppTheme.textiked)
              : BorderSide.none,
        ),
      ),
      child: ListTile(
        style: ListTileStyle.drawer,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
        leading: title != null
            ? Text(
                title!,
                style: context.bodyMedium?.copyWith(
                  color: AppTheme.fontGrayLead,
                  fontWeight: FontWeight.w300,
                ),
              )
            : null,
        title: content ??
            (textContent != null
                ? Text(
                    textContent!,
                    style: context.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.end,
                  )
                : null),
        trailing: showTrailing
            ? const Icon(
                Icons.keyboard_arrow_right_outlined,
                color: AppTheme.icon,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
