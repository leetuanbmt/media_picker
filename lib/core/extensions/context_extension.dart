import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';

import '../../widgets/commons/indicators/loading_manager.dart';
import '../config.dart';

extension ContextEx on BuildContext {
  AppLocalizations get lang => AppLocalizations.of(this)!;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get theme => Theme.of(this);

  Color get primary => colorScheme.primary;

  Color get primaryContainer => colorScheme.primaryContainer;

  Color get secondary => colorScheme.secondary;

  Color get tertiary => colorScheme.tertiary;

  Color get secondaryContainer => colorScheme.secondaryContainer;

  Color get surface => colorScheme.surface;

  Color get error => colorScheme.error;

  Color get onPrimary => colorScheme.onPrimary;

  Color get onSecondary => colorScheme.onSecondary;

  Color get onSurface => colorScheme.onSurface;

  Color get onError => colorScheme.onError;

  TextTheme get textTheme => theme.textTheme;

  Color get primaryColor => theme.primaryColor;

  EdgeInsets get padding => MediaQuery.paddingOf(this);

  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  Size get screenSize => MediaQuery.sizeOf(this);

  void startLoading() => LoadingManager().show(this);

  void endLoading() => LoadingManager().hide(this);

  void toast(String? message) => showSnackBar(message ?? '');

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
        ),
      );
  }

  Future<dynamic> navigator(PageRouteInfo route) =>
      AutoRouter.of(this).navigate(route);

  ImageProvider imageProvider(String? image) {
    if (image == null) {
      return AssetImage(Assets.imagesFan.path);
    } else {
      return kIsWeb
          ? NetworkImage(image)
          : ExtendedNetworkImageProvider(image, cache: true) as ImageProvider;
    }
  }
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}
