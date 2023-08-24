import 'package:flutter/services.dart';

import '../../core/config.dart';
import '../../routes/app_routes.gr.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    Key? key,
    this.title,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.centerTitle = false,
    this.onBack,
    this.actions,
    this.elevation = 1,
    this.background,
    this.toolbarHeight = 58,
    this.titleBuilder,
    this.bottom,
    this.systemOverlayStyle = AppTheme.lightStatusBar,
    this.titleSpacing = 0,
    this.showSearch = false,
    this.searchAppBar,
  }) : super(key: key);
  final String? title;
  final Widget? leading;
  final bool automaticallyImplyLeading, centerTitle, showSearch;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final double elevation, toolbarHeight;
  final double? titleSpacing;
  final Color? background;
  final Widget Function(String title)? titleBuilder;
  final PreferredSizeWidget? bottom;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Widget? searchAppBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: systemOverlayStyle,
      backgroundColor: background ?? AppTheme.primaryColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      titleSpacing: titleSpacing,
      title: searchAppBar ??
          (titleBuilder == null
              ? Text(title ?? '')
              : titleBuilder!(title ?? '')),
      leading: leading ??
          (automaticallyImplyLeading
              ? (ModalRoute.of(context)!.canPop
                  ? BackButton(
                      onPressed: onBack,
                      color: Colors.white,
                    )
                  : null)
              : null),
      actions: actions,
      centerTitle: centerTitle,
      elevation: elevation,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((toolbarHeight + (bottom?.preferredSize.height ?? 0)));
}

class QRLeading extends StatelessWidget {
  const QRLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.router.push(const QRRoute());
      },
      icon: const Icon(
        Icons.qr_code_scanner,
        color: Colors.white,
      ),
    );
  }
}
