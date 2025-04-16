part of '../media_picker.dart';

class AssetPickerConfig {
  const AssetPickerConfig({
    this.selectedAssets,
    this.maxAssets = defaultMaxAssetsCount,
    this.pageSize = defaultAssetsPerPage,
    this.gridThumbnailSize = defaultAssetGridPreviewSize,
    this.pathThumbnailSize = defaultPathThumbnailSize,
    this.previewThumbnailSize,
    this.requestType = RequestType.common,
    this.specialPickerType = SpecialPickerType.review,
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
  })  : assert(
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
          specialPickerType != SpecialPickerType.moment ||
              requestType == RequestType.common,
          'SpecialPickerType.moment and requestType '
          'cannot be set at the same time.',
        ),
        assert(
          (specialItemBuilder == null &&
                  identical(specialItemPosition, SpecialItemPosition.none)) ||
              (specialItemBuilder != null &&
                  !identical(specialItemPosition, SpecialItemPosition.none)),
          'Custom item did not set properly.',
        );

  /// Selected assets.
  final List<AssetEntity>? selectedAssets;

  /// Maximum count for asset selection.
  final int maxAssets;

  /// Assets should be loaded per page.
  ///
  /// Use `null` to display all assets into a single grid.
  final int pageSize;

  /// Thumbnail size in the grid.
  ///
  /// This only works on images and videos since other types does not have to
  /// request for the thumbnail data. The preview can speed up by reducing it.
  ///
  /// This cannot be `null` or a large value since you shouldn't use the
  /// original data for the grid.
  final ThumbnailSize gridThumbnailSize;

  /// Thumbnail size for path selector.
  final ThumbnailSize pathThumbnailSize;

  /// Preview thumbnail size in the viewer.
  ///
  /// This only works on images and videos since other types does not have to
  /// request for the thumbnail data. The preview can speed up by reducing it.
  ///
  /// Default is `null`, which will request the origin data.
  final ThumbnailSize? previewThumbnailSize;

  /// Request assets type.
  final RequestType requestType;

  /// The current special picker type for the picker.
  ///
  /// Several types which are special:
  /// * [SpecialPickerType.moment] When user selected video,
  ///   no more images can be selected.
  /// * [SpecialPickerType.noPreview] Disable preview of asset;
  ///   Clicking on an asset selects it.
  ///
  /// * [SpecialPickerType.moment]
  /// * [SpecialPickerType.noPreview]
  final SpecialPickerType specialPickerType;

  /// Whether the picker should save the scroll offset between pushes and pops.
  final bool keepScrollOffset;

  /// @{macro media_picker.delegates.SortPathDelegate}
  final SortPathDelegate<AssetPathEntity>? sortPathDelegate;

  /// { media_picker.constants.AssetPickerConfig.sortPathsByModifiedDate}
  /// Whether to allow sort delegates to sort paths with
  /// [FilterOptionGroup.containsPathModified].
  /// [FilterOptionGroup.containsPathModified]
  final bool sortPathsByModifiedDate;

  /// Filter options for the picker.
  ///
  /// Will be merged into the base configuration.
  final PMFilter? filterOptions;

  /// Assets count for the picker.
  final int gridCount;

  /// Main color for the picker.
  final Color? themeColor;

  /// Theme for the picker.
  ///
  /// Usually the media_picker uses the dark version (dark background color)
  /// for the picker. However, some others want a light or a custom version.
  final ThemeData? pickerTheme;

  final AssetPickerTextDelegate? textDelegate;

  /// Allow users set a special item in the picker with several positions.
  final SpecialItemPosition specialItemPosition;

  /// The widget builder for the the special item.
  final SpecialItemBuilder<AssetPathEntity>? specialItemBuilder;

  /// Indicates the loading status for the builder.
  final LoadingIndicatorBuilder? loadingIndicatorBuilder;

  /// {@macro media_picker.AssetSelectPredicate}
  final AssetSelectPredicate<AssetEntity>? selectPredicate;

  /// Whether the assets grid should revert.
  ///
  /// [Null] means judging by Apple OS.
  final bool? shouldRevertGrid;

  /// {@macro media_picker.LimitedPermissionOverlayPredicate}
  final LimitedPermissionOverlayPredicate? limitedPermissionOverlayPredicate;

  /// {@macro media_picker.PathNameBuilder}
  final PathNameBuilder<AssetPathEntity>? pathNameBuilder;
}
