import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_manager/photo_manager.dart' show PermissionState;
import 'package:provider/provider.dart';

typedef CNP<T extends ChangeNotifier?> = ChangeNotifierProvider<T>;

typedef LoadingIndicatorBuilder =
    Widget Function(BuildContext context, bool isAssetsEmpty);

typedef SpecialItemBuilder<Path> =
    Widget? Function(BuildContext context, Path? path, int length);

typedef AssetSelectPredicate<Asset> =
    FutureOr<bool> Function(BuildContext context, Asset asset, bool isSelected);

typedef LimitedPermissionOverlayPredicate =
    bool Function(PermissionState permissionState);

typedef PathNameBuilder<Path> = String Function(Path path);

typedef AssetsChangeCallback<Path> =
    void Function(PermissionState permission, MethodCall call, Path? path);

typedef AssetsChangeRefreshPredicate<Path> =
    bool Function(PermissionState permission, MethodCall call, Path? path);
