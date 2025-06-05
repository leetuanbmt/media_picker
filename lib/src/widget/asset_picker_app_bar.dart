import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:picker_library/picker_library.dart';

class AssetPickerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AssetPickerAppBar({
    super.key,
    this.automaticallyImplyLeading = true,
    this.automaticallyImplyActions = true,
    this.brightness,
    this.title,
    this.leading,
    this.bottom,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation = 0,
    this.actions,
    this.actionsPadding,
    this.height,
    this.blurRadius = 0,
    this.iconTheme,
    this.semanticsBuilder,
  });

  final Widget? title;

  final Widget? leading;

  final List<Widget>? actions;

  final PreferredSizeWidget? bottom;

  final EdgeInsetsGeometry? actionsPadding;

  final bool automaticallyImplyLeading;

  final bool centerTitle;

  final bool automaticallyImplyActions;

  final Color? backgroundColor;

  final double? height;

  final double elevation;

  final double blurRadius;

  final Brightness? brightness;

  final IconThemeData? iconTheme;

  final Semantics Function(Widget appBar)? semanticsBuilder;

  bool canPop(BuildContext context) {
    if (Navigator.maybeOf(context)?.canPop() ?? false) {
      return automaticallyImplyLeading;
    }
    return false;
  }

  double get _barHeight => height ?? kToolbarHeight;

  double get effectiveHeight =>
      _barHeight + (bottom?.preferredSize.height ?? 0);

  @override
  Size get preferredSize => Size.fromHeight(effectiveHeight);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppBarTheme appBarTheme = theme.appBarTheme;

    final Widget? titleWidget;
    if (centerTitle) {
      titleWidget = Center(child: title);
    } else {
      titleWidget = title;
    }
    Widget child = Container(
      width: double.maxFinite,
      height: _barHeight + MediaQuery.paddingOf(context).top,
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
      child: Stack(
        children: <Widget>[
          if (canPop(context))
            PositionedDirectional(
              top: 0.0,
              bottom: 0.0,
              child: IconTheme.merge(
                data: appBarTheme.iconTheme ?? theme.iconTheme,
                child: leading ?? const BackButton(),
              ),
            ),
          if (titleWidget != null)
            PositionedDirectional(
              top: 0.0,
              bottom: 0.0,
              start: canPop(context) ? _barHeight : 0.0,
              end: automaticallyImplyActions ? _barHeight : 0.0,
              child: Align(
                alignment: centerTitle
                    ? Alignment.center
                    : AlignmentDirectional.centerStart,
                child: DefaultTextStyle(
                  style:
                      appBarTheme.titleTextStyle ??
                      theme.textTheme.titleLarge!.copyWith(fontSize: 23.0),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  child: titleWidget,
                ),
              ),
            ),
          if (canPop(context) && (actions?.isEmpty ?? true))
            SizedBox(width: _barHeight)
          else if (actions?.isNotEmpty ?? false)
            PositionedDirectional(
              top: 0.0,
              end: 0.0,
              height: _barHeight,
              child: IconTheme.merge(
                data: appBarTheme.actionsIconTheme ?? theme.iconTheme,
                child: Padding(
                  padding: actionsPadding ?? EdgeInsets.zero,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    if (bottom != null) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[child, bottom!],
      );
    }

    if (blurRadius > 0.0) {
      child = ClipRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius),
          child: child,
        ),
      );
    }

    child = IconTheme.merge(
      data: iconTheme ?? appBarTheme.iconTheme ?? theme.iconTheme,
      child: child,
    );

    final Color effectiveBackgroundColor =
        backgroundColor ??
        appBarTheme.backgroundColor ??
        theme.colorScheme.surface;
    final Brightness effectiveBrightness =
        brightness ??
        appBarTheme.systemOverlayStyle?.statusBarBrightness ??
        theme.brightness;
    final SystemUiOverlayStyle overlayStyle =
        appBarTheme.systemOverlayStyle ??
        SystemUiOverlayStyle(
          statusBarColor: effectiveBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: effectiveBrightness.reverse,
          statusBarBrightness: effectiveBrightness,
        );
    child = AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: child,
    );

    final Widget result = Material(
      color: Color.lerp(
        effectiveBackgroundColor,
        Colors.transparent,
        blurRadius > 0.0 ? 0.1 : 0.0,
      ),
      elevation: elevation,
      child: child,
    );
    return semanticsBuilder?.call(result) ??
        Semantics(
          sortKey: const OrdinalSortKey(0),
          explicitChildNodes: true,
          child: result,
        );
  }
}

class AssetPickerAppBarWrapper extends StatelessWidget {
  const AssetPickerAppBarWrapper({
    super.key,
    required this.appBar,
    required this.body,
  });

  final AssetPickerAppBar appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            top:
                MediaQuery.paddingOf(context).top + appBar.preferredSize.height,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: body,
            ),
          ),
          Positioned.fill(bottom: null, child: appBar),
        ],
      ),
    );
  }
}
