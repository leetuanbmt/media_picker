import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import '../../gen/assets.gen.dart';
import '../../widgets/commons/indicators/loading_manager.dart';
import '../config.dart';
import '../utilities/utilities.dart';

extension ContextEx on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get primary => colorScheme.primary;

  Color get primaryContainer => colorScheme.primaryContainer;

  Color get secondary => colorScheme.secondary;

  Color get tertiary => colorScheme.tertiary;

  Color get secondaryContainer => colorScheme.secondaryContainer;

  Color get surface => colorScheme.surface;

  Color get background => colorScheme.background;

  Color get error => colorScheme.error;

  Color get onPrimary => colorScheme.onPrimary;

  Color get onSecondary => colorScheme.onSecondary;

  Color get onSurface => colorScheme.onSurface;

  Color get onBackground => colorScheme.onBackground;

  Color get onError => colorScheme.onError;

  TextTheme get textTheme => Theme.of(this).textTheme;

  // TextStyle get overline => Theme.of(this).textTheme.labelSmall!;

  // TextStyle get caption => Theme.of(this).textTheme.bodySmall!;

  // TextStyle get button => Theme.of(this).textTheme.labelLarge!;

  // TextStyle get bodyText2 => Theme.of(this).textTheme.bodyMedium!;

  // TextStyle get bodyText1 => Theme.of(this).textTheme.bodyLarge!;

  // TextStyle get subtitle2 => Theme.of(this).textTheme.titleSmall!;

  // TextStyle get subtitle1 => Theme.of(this).textTheme.titleMedium!;

  // TextStyle get headline1 => Theme.of(this).textTheme.displayLarge!;

  // TextStyle get headline2 => Theme.of(this).textTheme.displayMedium!;

  // TextStyle get headline3 => Theme.of(this).textTheme.displaySmall!;

  // TextStyle get headline4 => Theme.of(this).textTheme.headlineMedium!;

  // TextStyle get headline5 => Theme.of(this).textTheme.headlineSmall!;

  // TextStyle get headline6 => Theme.of(this).textTheme.titleLarge!;

  // Size get mediaSize => MediaQuery.of(this).size;

  // double get width => MediaQuery.of(this).size.width;

  // double get height => MediaQuery.of(this).size.height;

  // double get scale => MediaQuery.of(this).devicePixelRatio;

  // Orientation get orientation => MediaQuery.of(this).orientation;

  // Color get dividerColor => Theme.of(this).dividerColor;

  // Color get canvasColor => Theme.of(this).canvasColor;

  // EdgeInsets get padding => MediaQuery.of(this).padding;

  // double get widthScale => width > height ? height : width;

  // double get heightScale => width < height ? height : width;

  // int get widthPixels => (width * height).toInt();

  // int get heightPixels => (height * scale).toInt();
  void startLoading() => LoadingManager().show(this);
  void endLoading() => LoadingManager().hide(this);
  void toast(String? message) => AppUtils.toast(this, message ?? '');

  Future<dynamic> navigator(PageRouteInfo route) =>
      AutoRouter.of(this).navigate(route);

  ImageProvider imageProvider(String? image) {
    if (image == null) {
      return AssetImage(Assets.imagesFan.path);
    } else {
      return kIsWeb
          ? NetworkImage(image)
          : CachedNetworkImageProvider(image) as ImageProvider;
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
