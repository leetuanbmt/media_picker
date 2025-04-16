part of '../media_picker.dart';

typedef LoadingIndicatorBuilder = Widget Function(
  BuildContext context,
  bool isAssetsEmpty,
);

typedef SpecialItemBuilder<Path> = Widget? Function(
  BuildContext context,
  Path? path,
  int length,
);

typedef AssetSelectPredicate<Asset> = FutureOr<bool> Function(
  BuildContext context,
  Asset asset,
  bool isSelected,
);

typedef LimitedPermissionOverlayPredicate = bool Function(
  PermissionState permissionState,
);

typedef PathNameBuilder<Path> = String Function(Path path);
