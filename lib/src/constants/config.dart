import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../constants/typedefs.dart';
import '../delegates/asset_picker_text_delegate.dart';
import '../delegates/sort_path_delegate.dart';
import 'constants.dart';
import 'enums.dart';

class AssetPickerConfig {
  const AssetPickerConfig({
    this.selectedAssets,
    this.maxAssets = defaultMaxAssetsCount,
    this.pageSize = defaultAssetsPerPage,
    this.gridThumbnailSize = defaultAssetGridPreviewSize,
    this.pathThumbnailSize = defaultPathThumbnailSize,
    this.previewThumbnailSize,
    this.requestType = RequestType.common,
    this.specialPickerType,
    this.keepScrollOffset = false,
    this.sortPathDelegate,
    this.sortPathsByModifiedDate = false,
    this.filterOptions,
    this.gridCount = 4,
    this.themeColor,
    this.pickerTheme,
    this.textDelegate,
    this.specialItemPosition = SpecialItemPosition.none,
    this.specialItemBuilder,
    this.loadingIndicatorBuilder,
    this.selectPredicate,
    this.shouldRevertGrid,
    this.limitedPermissionOverlayPredicate,
    this.pathNameBuilder,
    this.assetsChangeCallback,
    this.assetsChangeRefreshPredicate,
    this.shouldAutoplayPreview = false,
    this.dragToSelect,
  }) : assert(
         pickerTheme == null || themeColor == null,
         'pickerTheme and themeColor cannot be set at the same time.',
       ),
       assert(maxAssets > 0, 'maxAssets must be greater than 0.'),
       assert(pageSize > 0, 'pageSize must be greater than 0.'),
       assert(gridCount > 0, 'gridCount must be greater than 0.'),
       assert(
         pageSize % gridCount == 0,
         'pageSize must be a multiple of gridCount.',
       ),
       assert(
         specialPickerType != SpecialPickerType.review ||
             requestType == RequestType.common,
         'SpecialPickerType.wechatMoment and requestType '
         'cannot be set at the same time.',
       ),
       assert(
         (specialItemBuilder == null &&
                 identical(specialItemPosition, SpecialItemPosition.none)) ||
             (specialItemBuilder != null &&
                 !identical(specialItemPosition, SpecialItemPosition.none)),
         'Custom item did not set properly.',
       );

  final List<AssetEntity>? selectedAssets;

  final int maxAssets;

  final int pageSize;

  final ThumbnailSize gridThumbnailSize;

  final ThumbnailSize pathThumbnailSize;

  final ThumbnailSize? previewThumbnailSize;

  final RequestType requestType;

  final SpecialPickerType? specialPickerType;

  final bool keepScrollOffset;

  final SortPathDelegate<AssetPathEntity>? sortPathDelegate;

  final bool sortPathsByModifiedDate;

  final PMFilter? filterOptions;

  final int gridCount;

  final Color? themeColor;

  final ThemeData? pickerTheme;

  final AssetPickerTextDelegate? textDelegate;

  final SpecialItemPosition specialItemPosition;

  final SpecialItemBuilder<AssetPathEntity>? specialItemBuilder;

  final LoadingIndicatorBuilder? loadingIndicatorBuilder;

  final AssetSelectPredicate<AssetEntity>? selectPredicate;

  final bool? shouldRevertGrid;

  final LimitedPermissionOverlayPredicate? limitedPermissionOverlayPredicate;

  final PathNameBuilder<AssetPathEntity>? pathNameBuilder;

  final AssetsChangeCallback<AssetPathEntity>? assetsChangeCallback;

  final AssetsChangeRefreshPredicate<AssetPathEntity>?
  assetsChangeRefreshPredicate;

  final bool shouldAutoplayPreview;

  final bool? dragToSelect;
}
