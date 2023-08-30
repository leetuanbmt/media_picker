import '../../../../../core/config.dart';

class EditItem extends StatelessWidget {
  const EditItem({
    super.key,
    this.title,
    this.content,
    this.textContent,
    this.showTrailing = true,
  });
  final String? title, textContent;
  final Widget? content;
  final bool showTrailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: .5,
            color: AppTheme.textiked,
          ),
          top: BorderSide(
            width: 1,
            color: AppTheme.textiked,
          ),
        ),
      ),
      child: ListTile(
        style: ListTileStyle.drawer,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
        leading: title != null
            ? Text(
                title!,
                style: context.titleMedium?.copyWith(
                  fontSize: 14.sp,
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
      ),
    );
  }
}
