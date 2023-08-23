import '../../core/config.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    Key? key,
    this.title,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.centerTitle = true,
    this.onBack,
    this.actions,
    this.elevation = 1,
    this.background,
    this.titleBuilder,
    this.bottom,
    this.leadingPadding,
    this.toolbarHeight = 58,
    this.titlePadding,
    this.actionPadding,
    this.actionRunSpacing = 3,
  }) : super(key: key);
  final String? title;
  final Widget? leading;
  final bool automaticallyImplyLeading, centerTitle;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final double elevation, toolbarHeight, actionRunSpacing;
  final EdgeInsets? leadingPadding, titlePadding, actionPadding;
  final Color? background;
  final Widget Function(String title)? titleBuilder;
  final PreferredSizeWidget? bottom;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      iconTheme: IconThemeData(
        color: AppTheme.primaryColor,
      ),
      backgroundColor: background,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Padding(
        padding: titlePadding ?? EdgeInsets.zero,
        child: titleBuilder == null
            ? Text(title ?? '')
            : titleBuilder!(title ?? ''),
      ),
      leading: Padding(
        padding: leadingPadding ??
            EdgeInsets.only(
              top: 3.5.h,
              left: 3.5.w,
            ),
        child: leading ??
            (automaticallyImplyLeading
                ? (ModalRoute.of(context)!.canPop
                    ? BackButton(
                        onPressed: () {},
                      )
                    : null)
                : null),
      ),
      actions: actionPadding == null
          ? actions
          : [
              Padding(
                padding: actionPadding!,
                child: Wrap(
                  runSpacing: actionRunSpacing.w,
                  children: actions ?? [],
                ),
              ),
            ],
      centerTitle: centerTitle,
      elevation: elevation,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((toolbarHeight + (bottom?.preferredSize.height ?? 0)).h);
}
