// ignore_for_file: use_build_context_synchronously

part of '../media_picker.dart';

class AssetPickerViewer<Asset, Path> extends StatefulWidget {
  const AssetPickerViewer({
    super.key,
    required this.builder,
  });

  final AssetPickerViewerBuilderDelegate<Asset, Path> builder;

  @override
  AssetPickerViewerState<Asset, Path> createState() =>
      AssetPickerViewerState<Asset, Path>();

  static Future<List<AssetEntity>?> pushToViewer(
    BuildContext context, {
    int currentIndex = 0,
    required List<AssetEntity> previewAssets,
    required ThemeData themeData,
    DefaultAssetPickerProvider? selectorProvider,
    ThumbnailSize? previewThumbnailSize,
    List<AssetEntity>? selectedAssets,
    SpecialPickerType? specialPickerType,
    int? maxAssets,
    bool shouldReversePreview = false,
    AssetSelectPredicate<AssetEntity>? selectPredicate,
  }) async {
    await AssetPicker.permissionCheck();
    final Widget viewer = AssetPickerViewer<AssetEntity, AssetPathEntity>(
      builder: DefaultAssetPickerViewerBuilderDelegate(
        currentIndex: currentIndex,
        previewAssets: previewAssets,
        provider: selectedAssets != null
            ? AssetPickerViewerProvider<AssetEntity>(
                selectedAssets,
                maxAssets: maxAssets ??
                    selectorProvider?.maxAssets ??
                    defaultMaxAssetsCount,
              )
            : null,
        themeData: themeData,
        previewThumbnailSize: previewThumbnailSize,
        specialPickerType: specialPickerType,
        selectedAssets: selectedAssets,
        selectorProvider: selectorProvider,
        maxAssets: maxAssets,
        shouldReversePreview: shouldReversePreview,
        selectPredicate: selectPredicate,
      ),
    );
    final PageRouteBuilder<List<AssetEntity>> pageRoute =
        PageRouteBuilder<List<AssetEntity>>(
      pageBuilder: (_, __, ___) => viewer,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
    final List<AssetEntity>? result =
        await Navigator.of(context).push<List<AssetEntity>>(pageRoute);
    return result;
  }

  static Future<List<A>?> pushToViewerWithDelegate<A, P>(
    BuildContext context, {
    required AssetPickerViewerBuilderDelegate<A, P> delegate,
  }) async {
    await AssetPicker.permissionCheck();
    final Widget viewer = AssetPickerViewer<A, P>(builder: delegate);
    final PageRouteBuilder<List<A>> pageRoute = PageRouteBuilder<List<A>>(
      pageBuilder: (_, __, ___) => viewer,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
    final List<A>? result = await Navigator.of(context).push<List<A>>(
      pageRoute,
    );
    return result;
  }
}

class AssetPickerViewerState<Asset, Path>
    extends State<AssetPickerViewer<Asset, Path>>
    with TickerProviderStateMixin {
  AssetPickerViewerBuilderDelegate<Asset, Path> get builder => widget.builder;

  @override
  void initState() {
    super.initState();
    builder.initStateAndTicker(this, this);
  }

  @override
  void didUpdateWidget(covariant AssetPickerViewer<Asset, Path> oldWidget) {
    super.didUpdateWidget(oldWidget);
    builder.didUpdateViewer(this, oldWidget, widget);
  }

  @override
  void dispose() {
    builder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return builder.build(context);
  }
}
