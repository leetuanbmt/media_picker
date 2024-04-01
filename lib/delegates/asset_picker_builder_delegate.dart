part of '../media_picker.dart';

abstract class AssetPickerBuilderDelegate<Asset, Path> {
  AssetPickerBuilderDelegate({
    required this.initialPermission,
    required this.context,
    this.gridCount = 4,
    this.specialItemPosition = SpecialItemPosition.none,
    this.specialItemBuilder,
    this.loadingIndicatorBuilder,
    this.selectPredicate,
    this.shouldRevertGrid,
    this.limitedPermissionOverlayPredicate,
    this.pathNameBuilder,
    AssetPickerTextDelegate? textDelegate,
    Locale? locale,
  }) : assert(gridCount > 0, 'gridCount must be greater than 0.') {
    Singleton.textDelegate =
        textDelegate ?? assetPickerTextDelegateFromLocale(locale);
  }
  final BuildContext context;
  final PermissionState initialPermission;

  final int gridCount;

  final SpecialItemPosition specialItemPosition;

  final SpecialItemBuilder<Path>? specialItemBuilder;

  final LoadingIndicatorBuilder? loadingIndicatorBuilder;

  final AssetSelectPredicate<Asset>? selectPredicate;

  final ScrollController gridScrollController = ScrollController();

  final ValueNotifier<bool> isSwitchingPath = ValueNotifier<bool>(false);

  final GlobalKey gridRevertKey = GlobalKey();

  final bool? shouldRevertGrid;

  final LimitedPermissionOverlayPredicate? limitedPermissionOverlayPredicate;

  final PathNameBuilder<AssetPathEntity>? pathNameBuilder;

  ThemeData get theme => Theme.of(context);

  SystemUiOverlayStyle get overlayStyle {
    if (theme.appBarTheme.systemOverlayStyle != null) {
      return theme.appBarTheme.systemOverlayStyle!;
    }
    return SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: theme.effectiveBrightness,
      statusBarBrightness: theme.effectiveBrightness.reverse,
    );
  }

  Color interactiveTextColor(BuildContext context) => Color.lerp(
        context.iconTheme.color?.withOpacity(.7) ?? Colors.white,
        Colors.blueAccent,
        0.4,
      )!;

  bool isAppleOS(BuildContext context) => switch (context.theme.platform) {
        TargetPlatform.iOS || TargetPlatform.macOS => true,
        _ => false,
      };

  bool get isSingleAssetMode;

  bool get shouldBuildSpecialItem =>
      specialItemPosition != SpecialItemPosition.none &&
      specialItemBuilder != null;

  double get itemSpacing => 2;

  double get appBarItemHeight => 32;

  double get appleOSBlurRadius => 10;

  double get bottomSectionHeight =>
      bottomActionBarHeight + permissionLimitedBarHeight;

  double get bottomActionBarHeight => kToolbarHeight / 1.1;

  double get permissionLimitedBarHeight => isPermissionLimited ? 75 : 0;

  late final ValueNotifier<PermissionState> permission =
      ValueNotifier<PermissionState>(
    initialPermission,
  );
  late final ValueNotifier<bool> permissionOverlayDisplay = ValueNotifier<bool>(
    limitedPermissionOverlayPredicate?.call(permission.value) ??
        (permission.value == PermissionState.limited),
  );

  bool get isPermissionLimited => permission.value == PermissionState.limited;

  bool effectiveShouldRevertGrid(BuildContext context) =>
      shouldRevertGrid ?? isAppleOS(context);

  AssetPickerTextDelegate get textDelegate => Singleton.textDelegate;

  AssetPickerTextDelegate get semanticsTextDelegate =>
      Singleton.textDelegate.semanticsTextDelegate;

  @mustCallSuper
  void initState(AssetPickerState<Asset, Path> state) {}

  @mustCallSuper
  void dispose() {
    Singleton.scrollPosition = null;
    gridScrollController.dispose();
    isSwitchingPath.dispose();
    permission.dispose();
    permissionOverlayDisplay.dispose();
  }

  @protected
  void selectAsset(BuildContext context, Asset asset, int index, bool selected);

  Future<void> onAssetsChanged(MethodCall call, StateSetter setState) async {}

  Future<void> viewAsset(
    BuildContext context,
    int index,
    AssetEntity currentAsset,
  );

  Widget build(BuildContext context);

  Widget pathEntitySelector(BuildContext context);

  Widget pathEntityWidget({
    required BuildContext context,
    required List<PathWrapper<Path>> list,
    required int index,
  });

  Widget pathEntityListBackdrop(BuildContext context);

  Widget pathEntityListWidget(BuildContext context);

  Widget confirmButton(BuildContext context);

  Widget audioIndicator(BuildContext context, Asset asset);

  Widget videoIndicator(BuildContext context, Asset asset);

  Widget selectedBackdrop(
    BuildContext context,
    int index,
    Asset asset,
  );

  Widget selectIndicator(BuildContext context, int index, Asset asset);

  Widget assetsGridBuilder(BuildContext context);

  int? findChildIndexBuilder({
    required String id,
    required List<Asset> assets,
    int placeholderCount = 0,
  }) =>
      null;

  int assetsGridItemCount({
    required BuildContext context,
    required List<Asset> assets,
    int placeholderCount = 0,
  });

  Widget assetGridItemBuilder(
    BuildContext context,
    int index,
    List<Asset> currentAssets,
  );

  Widget assetGridItemSemanticsBuilder(
    BuildContext context,
    int index,
    Asset asset,
    Widget child,
  );

  Widget audioItemBuilder(
    BuildContext context,
    int index,
    Asset asset,
  );

  Widget imageAndVideoItemBuilder(
    BuildContext context,
    int index,
    Asset asset,
  );

  Widget previewButton(BuildContext context);

  PreferredSizeWidget appBar(BuildContext context);

  Size? appBarPreferredSize;

  Widget appleOSLayout(BuildContext context);

  Widget androidLayout(BuildContext context);

  Widget loadingIndicator(BuildContext context);

  Widget gifIndicator(BuildContext context, Asset asset) {
    return PositionedDirectional(
      start: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.bottomCenter,
            end: AlignmentDirectional.topCenter,
            colors: <Color>[theme.dividerColor, Colors.transparent],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          decoration: !isAppleOS(context)
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: theme.iconTheme.color!.withOpacity(0.75),
                )
              : null,
          child: ScaleText(
            textDelegate.gifIndicator,
            style: TextStyle(
              color: isAppleOS(context)
                  ? theme.textTheme.bodyMedium?.color
                  : theme.primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            semanticsLabel: semanticsTextDelegate.gifIndicator,
            strutStyle: const StrutStyle(forceStrutHeight: true, height: 1),
          ),
        ),
      ),
    );
  }

  Widget itemBannedIndicator(BuildContext context, Asset asset) {
    return Consumer<AssetPickerProvider<Asset, Path>>(
      builder: (_, AssetPickerProvider<Asset, Path> p, __) {
        if (!p.selectedAssets.contains(asset) && p.selectedMaximumAssets) {
          return Container(
            color: theme.colorScheme.background.withOpacity(.85),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget emptyIndicator(BuildContext context) {
    return ScaleText(
      textDelegate.emptyList,
      maxScaleFactor: 1.5,
      semanticsLabel: semanticsTextDelegate.emptyList,
    );
  }

  Widget failedItemBuilder(BuildContext context) {
    return Center(
      child: ScaleText(
        textDelegate.loadFailed,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18),
        semanticsLabel: semanticsTextDelegate.loadFailed,
      ),
    );
  }

  TextDirection effectiveGridDirection(BuildContext context) {
    final TextDirection od = Directionality.of(context);
    if (effectiveShouldRevertGrid(context)) {
      if (od == TextDirection.ltr) {
        return TextDirection.rtl;
      }
      return TextDirection.ltr;
    }
    return od;
  }

  Widget accessLimitedBottomTip(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        Feedback.forTap(context);
        PhotoManager.openSetting();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: permissionLimitedBarHeight,
        color: theme.primaryColor.withOpacity(isAppleOS(context) ? 0.90 : 1),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 5),
            Icon(
              Icons.warning,
              color: Colors.orange[400]!.withOpacity(.8),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ScaleText(
                textDelegate.accessAllTip,
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
                semanticsLabel: semanticsTextDelegate.accessAllTip,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: context.iconTheme.color?.withOpacity(.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomActionBar(BuildContext context) {
    Widget child = Container(
      height: bottomActionBarHeight + context.bottomPadding,
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
        bottom: context.bottomPadding,
      ),
      color: theme.primaryColor.withOpacity(isAppleOS(context) ? 0.90 : 1),
      child: Row(
        children: <Widget>[
          previewButton(context),
          const Spacer(),
          confirmButton(context),
        ],
      ),
    );
    if (isPermissionLimited) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[accessLimitedBottomTip(context), child],
      );
    }
    child = ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: appleOSBlurRadius,
          sigmaY: appleOSBlurRadius,
        ),
        child: child,
      ),
    );
    return child;
  }

  Widget backButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: IconButton(
        onPressed: Navigator.of(context).maybePop,
        color: theme.appBarTheme.iconTheme?.color,
        icon: const Icon(Icons.close),
      ),
    );
  }

  Widget iOSPermissionOverlay(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final Widget closeButton = Container(
      margin: const EdgeInsetsDirectional.only(start: 16, top: 4),
      alignment: AlignmentDirectional.centerStart,
      child: IconButton(
        onPressed: Navigator.of(context).maybePop,
        icon: const Icon(Icons.close),
        padding: EdgeInsets.zero,
        constraints: BoxConstraints.tight(const Size.square(32)),
        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      ),
    );

    final Widget limitedTips = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ScaleText(
            textDelegate.unableToAccessAll,
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
            semanticsLabel: semanticsTextDelegate.unableToAccessAll,
          ),
          SizedBox(height: size.height / 30),
          ScaleText(
            textDelegate.accessAllTip,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
            semanticsLabel: semanticsTextDelegate.accessAllTip,
          ),
        ],
      ),
    );

    final Widget goToSettingsButton = MaterialButton(
      elevation: 0,
      minWidth: size.width / 2,
      height: appBarItemHeight * 1.25,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: PhotoManager.openSetting,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: ScaleText(
        textDelegate.goToSystemSettings,
        style: const TextStyle(fontSize: 17),
        semanticsLabel: semanticsTextDelegate.goToSystemSettings,
      ),
    );

    final Widget accessLimitedButton = GestureDetector(
      onTap: () => permissionOverlayDisplay.value = false,
      child: ScaleText(
        textDelegate.accessLimitedAssets,
        style: TextStyle(color: interactiveTextColor(context)),
        semanticsLabel: semanticsTextDelegate.accessLimitedAssets,
      ),
    );

    return ValueListenableBuilder2<PermissionState, bool>(
      firstNotifier: permission,
      secondNotifier: permissionOverlayDisplay,
      builder: (_, PermissionState ps, bool isDisplay, __) {
        if (ps.isAuth || !isDisplay) {
          return const SizedBox.shrink();
        }
        return Positioned.fill(
          child: Semantics(
            sortKey: const OrdinalSortKey(0),
            child: Container(
              padding: MediaQuery.paddingOf(context),
              color: context.theme.canvasColor,
              child: Column(
                children: <Widget>[
                  closeButton,
                  Expanded(child: limitedTips),
                  goToSettingsButton,
                  SizedBox(height: size.height / 18),
                  accessLimitedButton,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DefaultAssetPickerBuilderDelegate
    extends AssetPickerBuilderDelegate<AssetEntity, AssetPathEntity> {
  DefaultAssetPickerBuilderDelegate({
    required this.provider,
    required super.initialPermission,
    required super.context,
    super.gridCount,
    super.specialItemPosition,
    super.specialItemBuilder,
    super.loadingIndicatorBuilder,
    super.selectPredicate,
    super.shouldRevertGrid,
    super.limitedPermissionOverlayPredicate,
    super.pathNameBuilder,
    super.textDelegate,
    super.locale,
    this.gridThumbnailSize = defaultAssetGridPreviewSize,
    this.previewThumbnailSize,
    this.specialPickerType,
    this.keepScrollOffset = false,
  }) {
    if (keepScrollOffset) {
      gridScrollController.addListener(keepScrollOffsetListener);
    }
  }

  final DefaultAssetPickerProvider provider;

  final ThumbnailSize gridThumbnailSize;

  final ThumbnailSize? previewThumbnailSize;

  final SpecialPickerType? specialPickerType;

  final bool keepScrollOffset;

  Duration get switchingPathDuration => const Duration(milliseconds: 300);

  Curve get switchingPathCurve => Curves.easeInOutQuad;

  bool get isMoment => specialPickerType == SpecialPickerType.moment;

  bool get isPreviewEnabled => specialPickerType != SpecialPickerType.noPreview;

  @override
  bool get isSingleAssetMode => provider.maxAssets == 1;

  void keepScrollOffsetListener() {
    if (gridScrollController.hasClients) {
      Singleton.scrollPosition = gridScrollController.position;
    }
  }

  @override
  void dispose() {
    if (keepScrollOffset) {
      return;
    }
    provider.dispose();
    super.dispose();
  }

  @override
  Future<void> selectAsset(
    BuildContext context,
    AssetEntity asset,
    int index,
    bool selected,
  ) async {
    final bool? selectPredicateResult = await selectPredicate?.call(
      context,
      asset,
      selected,
    );
    if (selectPredicateResult == false) {
      return;
    }
    if (!context.mounted) return;
    final provider = context.read<DefaultAssetPickerProvider>();
    if (selected) {
      provider.unSelectAsset(asset);
      return;
    }
    if (isSingleAssetMode) {
      provider.selectedAssets.clear();
    }
    provider.selectAsset(asset);
    if (isSingleAssetMode && !isPreviewEnabled) {
      Navigator.of(context).maybePop(provider.selectedAssets);
    }
  }

  @override
  Future<void> onAssetsChanged(MethodCall call, StateSetter setState) async {
    if (!isPermissionLimited) {
      return;
    }
    isSwitchingPath.value = false;
    if (call.arguments is Map) {
      final Map<dynamic, dynamic> arguments =
          call.arguments as Map<dynamic, dynamic>;
      if (arguments['newCount'] == 0) {
        provider
          ..currentAssets = <AssetEntity>[]
          ..currentPath = null
          ..selectedAssets = <AssetEntity>[]
          ..hasAssetsToDisplay = false
          ..isAssetsEmpty = true
          ..totalAssetsCount = 0
          ..paths = [];
        return;
      }
    }
    await provider.getPaths();
    provider.currentPath = provider.paths.first;
    final PathWrapper<AssetPathEntity>? currentWrapper = provider.currentPath;
    if (currentWrapper != null) {
      final newPath = await currentWrapper.path.obtainForNewProperties();
      final int assetCount = await newPath.assetCountAsync;
      final newPathWrapper = PathWrapper<AssetPathEntity>(
        path: newPath,
        assetCount: assetCount,
      );
      provider
        ..currentPath = newPathWrapper
        ..hasAssetsToDisplay = assetCount != 0
        ..isAssetsEmpty = assetCount == 0
        ..totalAssetsCount = assetCount
        ..getThumbnailFromPath(newPathWrapper);
      if (newPath.isAll) {
        await provider.getAssetsFromCurrentPath();
        final List<AssetEntity> entitiesShouldBeRemoved = <AssetEntity>[];
        for (final AssetEntity entity in provider.selectedAssets) {
          if (!provider.currentAssets.contains(entity)) {
            entitiesShouldBeRemoved.add(entity);
          }
        }
        entitiesShouldBeRemoved.forEach(provider.selectedAssets.remove);
      }
    }
  }

  @override
  Future<void> viewAsset(
    BuildContext context,
    int index,
    AssetEntity currentAsset,
  ) async {
    final provider = context.read<DefaultAssetPickerProvider>();
    bool selectedAllAndNotSelected() =>
        !provider.selectedAssets.contains(currentAsset) &&
        provider.selectedMaximumAssets;
    bool selectedPhotosAndIsVideo() =>
        isMoment &&
        currentAsset.type == AssetType.video &&
        provider.selectedAssets.isNotEmpty;

    if (selectedAllAndNotSelected() || selectedPhotosAndIsVideo()) {
      return;
    }
    final List<AssetEntity> current;
    final List<AssetEntity>? selected;
    final int effectiveIndex;
    if (isMoment) {
      if (currentAsset.type == AssetType.video) {
        current = <AssetEntity>[currentAsset];
        selected = null;
        effectiveIndex = 0;
      } else {
        current = provider.currentAssets
            .where((AssetEntity e) => e.type == AssetType.image)
            .toList();
        selected = provider.selectedAssets;
        effectiveIndex = current.indexOf(currentAsset);
      }
    } else {
      current = provider.currentAssets;
      selected = provider.selectedAssets;
      effectiveIndex = index;
    }
    final List<AssetEntity>? result = await AssetPickerViewer.pushToViewer(
      context,
      currentIndex: effectiveIndex,
      previewAssets: current,
      themeData: theme,
      previewThumbnailSize: previewThumbnailSize,
      selectPredicate: selectPredicate,
      selectedAssets: selected,
      selectorProvider: provider,
      specialPickerType: specialPickerType,
      maxAssets: provider.maxAssets,
      shouldReversePreview: isAppleOS(context),
    );
    if (result != null) {
      if (!context.mounted) return;
      Navigator.of(context).maybePop(result);
    }
  }

  @override
  AssetPickerAppBar appBar(BuildContext context) {
    final AssetPickerAppBar appBar = AssetPickerAppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      title: Semantics(
        onTapHint: semanticsTextDelegate.sActionSwitchPathLabel,
        child: pathEntitySelector(context),
      ),
      leading: backButton(context),
      blurRadius: isAppleOS(context) ? appleOSBlurRadius : 0,
    );
    appBarPreferredSize ??= appBar.preferredSize;
    return appBar;
  }

  @override
  Widget androidLayout(BuildContext context) {
    return AssetPickerAppBarWrapper(
      appBar: appBar(context),
      body: Consumer<DefaultAssetPickerProvider>(
        builder: (BuildContext context, DefaultAssetPickerProvider p, _) {
          final bool shouldDisplayAssets =
              p.hasAssetsToDisplay || shouldBuildSpecialItem;
          return AnimatedSwitcher(
            duration: switchingPathDuration,
            child: shouldDisplayAssets
                ? Stack(
                    children: <Widget>[
                      RepaintBoundary(
                        child: Column(
                          children: <Widget>[
                            Expanded(child: assetsGridBuilder(context)),
                            if (isPreviewEnabled || !isSingleAssetMode)
                              bottomActionBar(context),
                          ],
                        ),
                      ),
                      pathEntityListBackdrop(context),
                      pathEntityListWidget(context),
                    ],
                  )
                : loadingIndicator(context),
          );
        },
      ),
    );
  }

  @override
  Widget appleOSLayout(BuildContext context) {
    Widget gridLayout(BuildContext context) {
      return ValueListenableBuilder<bool>(
        valueListenable: isSwitchingPath,
        builder: (_, bool isSwitchingPath, __) => Semantics(
          excludeSemantics: isSwitchingPath,
          child: RepaintBoundary(
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: assetsGridBuilder(context)),
                if (isPreviewEnabled || !isSingleAssetMode)
                  Positioned.fill(top: null, child: bottomActionBar(context)),
              ],
            ),
          ),
        ),
      );
    }

    Widget layout(BuildContext context) {
      return Stack(
        children: <Widget>[
          Positioned.fill(
            child: Consumer<DefaultAssetPickerProvider>(
              builder: (_, DefaultAssetPickerProvider p, __) {
                final Widget child;
                final bool shouldDisplayAssets =
                    p.hasAssetsToDisplay || shouldBuildSpecialItem;
                if (shouldDisplayAssets) {
                  child = Stack(
                    children: <Widget>[
                      gridLayout(context),
                      pathEntityListBackdrop(context),
                      pathEntityListWidget(context),
                    ],
                  );
                } else {
                  child = loadingIndicator(context);
                }
                return AnimatedSwitcher(
                  duration: switchingPathDuration,
                  child: child,
                );
              },
            ),
          ),
          appBar(context),
        ],
      );
    }

    return ValueListenableBuilder<bool>(
      valueListenable: permissionOverlayDisplay,
      builder: (_, bool value, Widget? child) {
        if (value) {
          return ExcludeSemantics(child: child);
        }
        return child!;
      },
      child: layout(context),
    );
  }

  @override
  Widget loadingIndicator(BuildContext context) {
    return Selector<DefaultAssetPickerProvider, bool>(
      selector: (_, DefaultAssetPickerProvider p) => p.isAssetsEmpty,
      builder: (BuildContext context, bool isAssetsEmpty, Widget? w) {
        if (loadingIndicatorBuilder != null) {
          return loadingIndicatorBuilder!(context, isAssetsEmpty);
        }
        return Center(child: isAssetsEmpty ? emptyIndicator(context) : w);
      },
      child: PlatformProgressIndicator(
        color: theme.iconTheme.color,
        size: MediaQuery.sizeOf(context).width / gridCount / 3,
      ),
    );
  }

  @override
  Widget assetsGridBuilder(BuildContext context) {
    appBarPreferredSize ??= appBar(context).preferredSize;
    final bool gridRevert = effectiveShouldRevertGrid(context);
    return Selector<DefaultAssetPickerProvider, PathWrapper<AssetPathEntity>?>(
      selector: (_, DefaultAssetPickerProvider p) => p.currentPath,
      builder: (
        BuildContext context,
        PathWrapper<AssetPathEntity>? wrapper,
        _,
      ) {
        int totalCount = wrapper?.assetCount ?? 0;
        final Widget? specialItem;

        if (specialItemPosition != SpecialItemPosition.none) {
          specialItem = specialItemBuilder?.call(
            context,
            wrapper?.path,
            totalCount,
          );
          if (specialItem != null) {
            totalCount += 1;
          }
        } else {
          specialItem = null;
        }
        if (totalCount == 0 && specialItem == null) {
          return loadingIndicator(context);
        }

        final int placeholderCount;
        if (gridRevert && totalCount % gridCount != 0) {
          placeholderCount = gridCount - totalCount % gridCount;
        } else {
          placeholderCount = 0;
        }

        final int row = (totalCount + placeholderCount) ~/ gridCount;

        final double dividedSpacing = itemSpacing / gridCount;
        final double topPadding =
            context.topPadding + appBarPreferredSize!.height;

        Widget sliverGrid(BuildContext context, List<AssetEntity> assets) {
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (_, int index) => Builder(
                builder: (BuildContext context) {
                  if (gridRevert) {
                    if (index < placeholderCount) {
                      return const SizedBox.shrink();
                    }
                    index -= placeholderCount;
                  }
                  return MergeSemantics(
                    child: Directionality(
                      textDirection: Directionality.of(context),
                      child: assetGridItemBuilder(
                        context,
                        index,
                        assets,
                        specialItem: specialItem,
                      ),
                    ),
                  );
                },
              ),
              childCount: assetsGridItemCount(
                context: context,
                assets: assets,
                placeholderCount: placeholderCount,
                specialItem: specialItem,
              ),
              findChildIndexCallback: (Key? key) {
                if (key is ValueKey<String>) {
                  return findChildIndexBuilder(
                    id: key.value,
                    assets: assets,
                    placeholderCount: placeholderCount,
                  );
                }
                return null;
              },
              addSemanticIndexes: false,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCount,
              mainAxisSpacing: itemSpacing,
              crossAxisSpacing: itemSpacing,
            ),
          );
        }

        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double itemSize = constraints.maxWidth / gridCount;

            final bool onlyOneScreen = row * itemSize <=
                constraints.maxHeight -
                    context.bottomPadding -
                    topPadding -
                    permissionLimitedBarHeight;
            final double height;
            if (onlyOneScreen) {
              height = constraints.maxHeight;
            } else {
              height = constraints.maxHeight - permissionLimitedBarHeight;
            }

            final double anchor = math.min(
              (row * (itemSize + dividedSpacing) + topPadding - itemSpacing) /
                  height,
              1,
            );

            return Directionality(
              textDirection: effectiveGridDirection(context),
              child: ColoredBox(
                color: theme.canvasColor,
                child: Selector<DefaultAssetPickerProvider, List<AssetEntity>>(
                  selector: (_, DefaultAssetPickerProvider p) =>
                      p.currentAssets,
                  builder: (BuildContext context, List<AssetEntity> assets, _) {
                    final SliverGap bottomGap = SliverGap.v(
                      context.bottomPadding + bottomSectionHeight,
                    );
                    appBarPreferredSize ??= appBar(context).preferredSize;
                    return CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: gridScrollController,
                      anchor: gridRevert ? anchor : 0,
                      center: gridRevert ? gridRevertKey : null,
                      slivers: <Widget>[
                        if (isAppleOS(context))
                          SliverGap.v(
                            context.topPadding + appBarPreferredSize!.height,
                          ),
                        sliverGrid(context, assets),
                        if (gridRevert && anchor == 1) bottomGap,
                        if (gridRevert)
                          SliverToBoxAdapter(
                            key: gridRevertKey,
                            child: const SizedBox.shrink(),
                          ),
                        if (isAppleOS(context) && !gridRevert) bottomGap,
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget assetGridItemBuilder(
    BuildContext context,
    int index,
    List<AssetEntity> currentAssets, {
    Widget? specialItem,
  }) {
    final DefaultAssetPickerProvider p =
        context.read<DefaultAssetPickerProvider>();
    final int length = currentAssets.length;
    final PathWrapper<AssetPathEntity>? currentWrapper = p.currentPath;
    final AssetPathEntity? currentPathEntity = currentWrapper?.path;

    if (specialItem != null) {
      if ((index == 0 && specialItemPosition == SpecialItemPosition.prepend) ||
          (index == length &&
              specialItemPosition == SpecialItemPosition.append)) {
        return specialItem;
      }
    }

    final int currentIndex;
    if (specialItem != null &&
        specialItemPosition == SpecialItemPosition.prepend) {
      currentIndex = index - 1;
    } else {
      currentIndex = index;
    }

    if (currentPathEntity == null) {
      return const SizedBox.shrink();
    }

    if (p.hasMoreToLoad) {
      if ((p.pageSize <= gridCount * 3 && index == length - 1) ||
          index == length - gridCount * 3) {
        p.loadMoreAssets();
      }
    }

    final AssetEntity asset = currentAssets.elementAt(currentIndex);
    final Widget builder = switch (asset.type) {
      AssetType.image ||
      AssetType.video =>
        imageAndVideoItemBuilder(context, currentIndex, asset),
      AssetType.audio => audioItemBuilder(context, currentIndex, asset),
      AssetType.other => const SizedBox.shrink(),
    };
    final Widget content = Stack(
      key: ValueKey<String>(asset.id),
      children: <Widget>[
        builder,
        selectedBackdrop(context, currentIndex, asset),
        if (!isMoment || asset.type != AssetType.video)
          selectIndicator(context, index, asset),
        itemBannedIndicator(context, asset),
      ],
    );
    return assetGridItemSemanticsBuilder(context, index, asset, content);
  }

  int semanticIndex(int index) {
    if (specialItemPosition != SpecialItemPosition.prepend) {
      return index + 1;
    }
    return index;
  }

  @override
  Widget assetGridItemSemanticsBuilder(
    BuildContext context,
    int index,
    AssetEntity asset,
    Widget child,
  ) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSwitchingPath,
      builder: (_, bool isSwitchingPath, Widget? child) {
        return Consumer<DefaultAssetPickerProvider>(
          builder: (_, DefaultAssetPickerProvider p, __) {
            final bool isBanned = (!p.selectedAssets.contains(asset) &&
                    p.selectedMaximumAssets) ||
                (isMoment &&
                    asset.type == AssetType.video &&
                    p.selectedAssets.isNotEmpty);
            final bool isSelected = p.selectedDescriptions.contains(
              asset.toString(),
            );
            final int selectedIndex = p.selectedAssets.indexOf(asset) + 1;
            String hint = '';
            if (asset.type == AssetType.audio ||
                asset.type == AssetType.video) {
              hint += '${semanticsTextDelegate.sNameDurationLabel}: ';
              hint += semanticsTextDelegate.durationIndicatorBuilder(
                asset.videoDuration,
              );
            }
            if (asset.title?.isNotEmpty ?? false) {
              hint += ', ${asset.title}';
            }
            return Semantics(
              button: false,
              enabled: !isBanned,
              excludeSemantics: true,
              focusable: !isSwitchingPath,
              label: '${semanticsTextDelegate.semanticTypeLabel(asset.type)}'
                  '${semanticIndex(index)}, '
                  '${asset.createDateTime.toString().replaceAll('.000', '')}',
              hidden: isSwitchingPath,
              hint: hint,
              image: asset.type == AssetType.image ||
                  asset.type == AssetType.video,
              onTap: () => selectAsset(context, asset, index, isSelected),
              onTapHint: semanticsTextDelegate.sActionSelectHint,
              onLongPress: isPreviewEnabled
                  ? () => viewAsset(context, index, asset)
                  : null,
              onLongPressHint: semanticsTextDelegate.sActionPreviewHint,
              selected: isSelected,
              sortKey: OrdinalSortKey(
                semanticIndex(index).toDouble(),
                name: 'GridItem',
              ),
              value: selectedIndex > 0 ? '$selectedIndex' : null,
              child: GestureDetector(
                onLongPress: isPreviewEnabled &&
                        MediaQuery.accessibleNavigationOf(context)
                    ? () => viewAsset(context, index, asset)
                    : null,
                child: IndexedSemantics(
                  index: semanticIndex(index),
                  child: child,
                ),
              ),
            );
          },
        );
      },
      child: child,
    );
  }

  @override
  int findChildIndexBuilder({
    required String id,
    required List<AssetEntity> assets,
    int placeholderCount = 0,
  }) {
    int index = assets.indexWhere((AssetEntity e) => e.id == id);
    if (specialItemPosition == SpecialItemPosition.prepend) {
      index += 1;
    }
    index += placeholderCount;
    return index;
  }

  @override
  int assetsGridItemCount({
    required BuildContext context,
    required List<AssetEntity> assets,
    int placeholderCount = 0,
    Widget? specialItem,
  }) {
    final PathWrapper<AssetPathEntity>? currentWrapper = context
        .select<DefaultAssetPickerProvider, PathWrapper<AssetPathEntity>?>(
      (DefaultAssetPickerProvider p) => p.currentPath,
    );
    final AssetPathEntity? currentPathEntity = currentWrapper?.path;
    final int length = assets.length + placeholderCount;

    if (currentPathEntity == null && specialItem != null) {
      return placeholderCount + 1;
    }

    if (currentPathEntity?.isAll != true && specialItem == null) {
      return length;
    }
    return switch (specialItemPosition) {
      SpecialItemPosition.none => length,
      SpecialItemPosition.prepend || SpecialItemPosition.append => length + 1,
    };
  }

  @override
  Widget audioIndicator(BuildContext context, AssetEntity asset) {
    return Container(
      width: double.maxFinite,
      alignment: AlignmentDirectional.bottomStart,
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.bottomCenter,
          end: AlignmentDirectional.topCenter,
          colors: <Color>[theme.dividerColor, Colors.transparent],
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 4),
        child: ScaleText(
          textDelegate.durationIndicatorBuilder(
            Duration(seconds: asset.duration),
          ),
          style: const TextStyle(fontSize: 16),
          semanticsLabel: '${semanticsTextDelegate.sNameDurationLabel}: '
              '${semanticsTextDelegate.durationIndicatorBuilder(
            Duration(seconds: asset.duration),
          )}',
        ),
      ),
    );
  }

  @override
  Widget audioItemBuilder(BuildContext context, int index, AssetEntity asset) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.maxFinite,
          alignment: AlignmentDirectional.topStart,
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: <Color>[theme.dividerColor, Colors.transparent],
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 4, end: 30),
            child: ScaleText(
              asset.title ?? '',
              style: const TextStyle(fontSize: 16),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const Align(
          alignment: AlignmentDirectional(0.9, 0.8),
          child: Icon(Icons.audiotrack),
        ),
        audioIndicator(context, asset),
      ],
    );
  }

  @override
  Widget confirmButton(BuildContext context) {
    return Consumer<DefaultAssetPickerProvider>(
      builder: (_, DefaultAssetPickerProvider p, __) {
        final bool isSelectedNotEmpty = p.isSelectedNotEmpty;
        final bool shouldAllowConfirm =
            isSelectedNotEmpty || p.previousSelectedAssets.isNotEmpty;
        return MaterialButton(
          minWidth: shouldAllowConfirm ? 48 : 20,
          height: appBarItemHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: context.primary,
          disabledColor: theme.dividerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          onPressed: shouldAllowConfirm
              ? () => Navigator.of(context).maybePop(p.selectedAssets)
              : null,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: ScaleText(
            isSelectedNotEmpty && !isSingleAssetMode
                ? '${textDelegate.confirm}'
                    ' (${p.selectedAssets.length}/${p.maxAssets})'
                : textDelegate.confirm,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
            semanticsLabel: isSelectedNotEmpty && !isSingleAssetMode
                ? '${semanticsTextDelegate.confirm}'
                    ' (${p.selectedAssets.length}/${p.maxAssets})'
                : semanticsTextDelegate.confirm,
          ),
        );
      },
    );
  }

  @override
  Widget imageAndVideoItemBuilder(
    BuildContext context,
    int index,
    AssetEntity asset,
  ) {
    final AssetEntityImageProvider imageProvider = AssetEntityImageProvider(
      asset,
      isOriginal: false,
      thumbnailSize: gridThumbnailSize,
    );
    SpecialImageType? type;
    if (imageProvider.imageFileType == ImageFileType.gif) {
      type = SpecialImageType.gif;
    } else if (imageProvider.imageFileType == ImageFileType.heic) {
      type = SpecialImageType.heic;
    }
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: RepaintBoundary(
            child: AssetEntityGridItemBuilder(
              image: imageProvider,
              failedItemBuilder: failedItemBuilder,
            ),
          ),
        ),
        if (type == SpecialImageType.gif) gifIndicator(context, asset),
        if (asset.type == AssetType.video) videoIndicator(context, asset),
      ],
    );
  }

  @override
  Widget pathEntityListBackdrop(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSwitchingPath,
      builder: (_, bool isSwitchingPath, __) => Positioned.fill(
        child: IgnorePointer(
          ignoring: !isSwitchingPath,
          child: ExcludeSemantics(
            child: GestureDetector(
              onTap: () => this.isSwitchingPath.value = false,
              child: AnimatedOpacity(
                duration: switchingPathDuration,
                opacity: isSwitchingPath ? .75 : 0,
                child: const ColoredBox(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget pathEntityListWidget(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    appBarPreferredSize ??= appBar(context).preferredSize;
    return Positioned.fill(
      top: isAppleOS(context)
          ? context.topPadding + appBarPreferredSize!.height
          : 0,
      bottom: null,
      child: ValueListenableBuilder<bool>(
        valueListenable: isSwitchingPath,
        builder: (_, bool isSwitchingPath, Widget? child) => Semantics(
          hidden: isSwitchingPath ? null : true,
          child: AnimatedAlign(
            duration: switchingPathDuration,
            curve: switchingPathCurve,
            alignment: Alignment.bottomCenter,
            heightFactor: isSwitchingPath ? 1 : 0,
            child: AnimatedOpacity(
              duration: switchingPathDuration,
              curve: switchingPathCurve,
              opacity: !isAppleOS(context) || isSwitchingPath ? 1 : 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.sizeOf(context).height *
                        (isAppleOS(context) ? .6 : .8),
                  ),
                  color: theme.colorScheme.background,
                  child: child,
                ),
              ),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ValueListenableBuilder<PermissionState>(
              valueListenable: permission,
              builder: (_, PermissionState ps, Widget? child) => Semantics(
                label: '${semanticsTextDelegate.viewingLimitedAssetsTip}, '
                    '${semanticsTextDelegate.changeAccessibleLimitedAssets}',
                button: true,
                onTap: PhotoManager.presentLimited,
                hidden: !isPermissionLimited,
                focusable: isPermissionLimited,
                excludeSemantics: true,
                child: isPermissionLimited ? child : const SizedBox.shrink(),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: textDelegate.viewingLimitedAssetsTip,
                      ),
                      TextSpan(
                        text: ' '
                            '${textDelegate.changeAccessibleLimitedAssets}',
                        style: TextStyle(color: interactiveTextColor(context)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = PhotoManager.presentLimited,
                      ),
                    ],
                  ),
                  style: textTheme.bodySmall?.copyWith(fontSize: 14),
                ),
              ),
            ),
            Flexible(
              child: Selector<DefaultAssetPickerProvider,
                  List<PathWrapper<AssetPathEntity>>>(
                selector: (_, DefaultAssetPickerProvider p) => p.paths,
                builder: (_, List<PathWrapper<AssetPathEntity>> paths, __) {
                  final List<PathWrapper<AssetPathEntity>> filtered = paths
                      .where(
                        (PathWrapper<AssetPathEntity> p) => p.assetCount != 0,
                      )
                      .toList();
                  return ListView.separated(
                    padding: const EdgeInsetsDirectional.only(top: 1),
                    shrinkWrap: true,
                    itemCount: filtered.length,
                    itemBuilder: (BuildContext c, int i) => pathEntityWidget(
                      context: c,
                      list: filtered,
                      index: i,
                    ),
                    separatorBuilder: (_, __) => Container(
                      margin: const EdgeInsetsDirectional.only(start: 60),
                      height: 1,
                      color: theme.canvasColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget pathEntitySelector(BuildContext context) {
    Widget text(
      BuildContext context,
      String text,
      String semanticsText,
    ) {
      return Flexible(
        child: ScaleText(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: context.background,
          ),
          maxLines: 1,
          overflow: TextOverflow.fade,
          maxScaleFactor: 1.2,
          semanticsLabel: semanticsText,
        ),
      );
    }

    return UnconstrainedBox(
      child: GestureDetector(
        onTap: () {
          if (isPermissionLimited && provider.isAssetsEmpty) {
            PhotoManager.presentLimited();
            return;
          }
          if (provider.currentPath == null) {
            return;
          }
          isSwitchingPath.value = !isSwitchingPath.value;
        },
        child: Container(
          height: appBarItemHeight,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.5,
          ),
          padding: const EdgeInsetsDirectional.only(start: 12, end: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: theme.dividerColor,
          ),
          child: Selector<DefaultAssetPickerProvider,
              PathWrapper<AssetPathEntity>?>(
            selector: (_, DefaultAssetPickerProvider p) => p.currentPath,
            builder: (_, PathWrapper<AssetPathEntity>? p, Widget? w) {
              final AssetPathEntity? path = p?.path;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (path == null && isPermissionLimited)
                    text(
                      context,
                      textDelegate.changeAccessibleLimitedAssets,
                      semanticsTextDelegate.changeAccessibleLimitedAssets,
                    ),
                  if (path != null)
                    text(
                      context,
                      isPermissionLimited && path.isAll
                          ? textDelegate.accessiblePathName
                          : pathNameBuilder?.call(path) ?? path.name,
                      isPermissionLimited && path.isAll
                          ? semanticsTextDelegate.accessiblePathName
                          : pathNameBuilder?.call(path) ?? path.name,
                    ),
                  w!,
                ],
              );
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 5),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.iconTheme.color!.withOpacity(0.2),
                ),
                child: ValueListenableBuilder<bool>(
                  valueListenable: isSwitchingPath,
                  builder: (_, bool isSwitchingPath, Widget? w) {
                    return Transform.rotate(
                      angle: isSwitchingPath ? math.pi : 0,
                      child: w,
                    );
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: context.background,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget pathEntityWidget({
    required BuildContext context,
    required List<PathWrapper<AssetPathEntity>> list,
    required int index,
  }) {
    final PathWrapper<AssetPathEntity> wrapper = list[index];
    final AssetPathEntity pathEntity = wrapper.path;
    final typed_data.Uint8List? data = wrapper.thumbnailData;

    Widget builder() {
      if (data != null) {
        return Image.memory(data, fit: BoxFit.cover);
      }
      if (pathEntity.type.containsAudio()) {
        return ColoredBox(
          color: theme.colorScheme.primary.withOpacity(0.12),
          child: const Center(child: Icon(Icons.audiotrack)),
        );
      }
      return ColoredBox(color: theme.colorScheme.primary.withOpacity(0.12));
    }

    final String pathName =
        pathNameBuilder?.call(pathEntity) ?? pathEntity.name;
    final String name = isPermissionLimited && pathEntity.isAll
        ? textDelegate.accessiblePathName
        : pathName;
    final String semanticsName = isPermissionLimited && pathEntity.isAll
        ? semanticsTextDelegate.accessiblePathName
        : pathName;
    final String? semanticsCount = wrapper.assetCount?.toString();
    final StringBuffer labelBuffer = StringBuffer(
      '$semanticsName, ${semanticsTextDelegate.sUnitAssetCountLabel}',
    );
    if (semanticsCount != null) {
      labelBuffer.write(': $semanticsCount');
    }
    return Selector<DefaultAssetPickerProvider, PathWrapper<AssetPathEntity>?>(
      selector: (_, DefaultAssetPickerProvider p) => p.currentPath,
      builder: (_, PathWrapper<AssetPathEntity>? currentWrapper, __) {
        final bool isSelected = currentWrapper?.path == pathEntity;
        return Semantics(
          label: labelBuffer.toString(),
          selected: isSelected,
          onTapHint: semanticsTextDelegate.sActionSwitchPathLabel,
          button: false,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              splashFactory: InkSplash.splashFactory,
              onTap: () {
                Feedback.forTap(context);
                context.read<DefaultAssetPickerProvider>().switchPath(wrapper);
                isSwitchingPath.value = false;
                gridScrollController.jumpTo(0);
              },
              child: SizedBox(
                height: isAppleOS(context) ? 64 : 52,
                child: Row(
                  children: <Widget>[
                    RepaintBoundary(
                      child: AspectRatio(aspectRatio: 1, child: builder()),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 15,
                          end: 20,
                        ),
                        child: ExcludeSemantics(
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    end: 10,
                                  ),
                                  child: ScaleText(
                                    name,
                                    style: const TextStyle(fontSize: 17),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              if (semanticsCount != null)
                                ScaleText(
                                  '($semanticsCount)',
                                  style: TextStyle(
                                    color: theme.textTheme.bodySmall?.color,
                                    fontSize: 17,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (isSelected)
                      AspectRatio(
                        aspectRatio: 1,
                        child: Icon(
                          Icons.check,
                          color: context.primary,
                          size: 26,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget previewButton(BuildContext context) {
    Future<void> onTap() async {
      final DefaultAssetPickerProvider p =
          context.read<DefaultAssetPickerProvider>();
      final List<AssetEntity> selectedAssets = p.selectedAssets;
      final List<AssetEntity> selected;
      if (isMoment) {
        selected = selectedAssets
            .where((AssetEntity e) => e.type == AssetType.image)
            .toList();
      } else {
        selected = selectedAssets;
      }
      final List<AssetEntity>? result = await AssetPickerViewer.pushToViewer(
        context,
        previewAssets: selected,
        previewThumbnailSize: previewThumbnailSize,
        selectPredicate: selectPredicate,
        selectedAssets: selected,
        selectorProvider: provider,
        themeData: theme,
        maxAssets: p.maxAssets,
      );
      if (result != null) {
        if (!context.mounted) return;
        Navigator.of(context).maybePop(result);
      }
    }

    return Consumer<DefaultAssetPickerProvider>(
      builder: (_, DefaultAssetPickerProvider p, Widget? child) {
        return ValueListenableBuilder<bool>(
          valueListenable: isSwitchingPath,
          builder: (_, bool isSwitchingPath, __) => Semantics(
            enabled: p.isSelectedNotEmpty,
            focusable: !isSwitchingPath,
            hidden: isSwitchingPath,
            onTapHint: semanticsTextDelegate.sActionPreviewHint,
            child: child,
          ),
        );
      },
      child: Consumer<DefaultAssetPickerProvider>(
        builder: (_, DefaultAssetPickerProvider p, __) => GestureDetector(
          onTap: p.isSelectedNotEmpty ? onTap : null,
          child: Selector<DefaultAssetPickerProvider, String>(
            selector: (_, DefaultAssetPickerProvider p) =>
                p.selectedDescriptions,
            builder: (BuildContext c, __, ___) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ScaleText(
                '${textDelegate.preview}'
                '${p.isSelectedNotEmpty ? ' (${p.selectedAssets.length})' : ''}',
                style: TextStyle(
                  color: p.isSelectedNotEmpty
                      ? null
                      : Theme.of(c).textTheme.bodySmall?.color,
                  fontSize: 17,
                ),
                maxScaleFactor: 1.2,
                semanticsLabel: '${semanticsTextDelegate.preview}'
                    '${p.isSelectedNotEmpty ? ' (${p.selectedAssets.length})' : ''}',
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget itemBannedIndicator(BuildContext context, AssetEntity asset) {
    return Consumer<DefaultAssetPickerProvider>(
      builder: (_, DefaultAssetPickerProvider p, __) {
        final bool isDisabled =
            (!p.selectedAssets.contains(asset) && p.selectedMaximumAssets) ||
                (isMoment &&
                    asset.type == AssetType.video &&
                    p.selectedAssets.isNotEmpty);
        if (isDisabled) {
          return Container(
            color: theme.colorScheme.background.withOpacity(.85),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget selectIndicator(BuildContext context, int index, AssetEntity asset) {
    final double indicatorSize =
        MediaQuery.sizeOf(context).width / gridCount / 3;
    final Duration duration = switchingPathDuration * 0.75;
    return Selector<DefaultAssetPickerProvider, String>(
      selector: (_, DefaultAssetPickerProvider p) => p.selectedDescriptions,
      builder: (BuildContext context, String descriptions, __) {
        final bool selected = descriptions.contains(asset.toString());
        final Widget innerSelector = AnimatedContainer(
          duration: duration,
          width: indicatorSize / (isAppleOS(context) ? 1.25 : 1.5),
          height: indicatorSize / (isAppleOS(context) ? 1.25 : 1.5),
          padding: EdgeInsets.all(indicatorSize / 10),
          decoration: BoxDecoration(
            border: !selected
                ? Border.all(
                    color: Colors.white,
                    width: indicatorSize / 25,
                  )
                : null,
            color: selected ? context.primary : null,
            shape: BoxShape.circle,
          ),
          child: FittedBox(
            child: AnimatedSwitcher(
              duration: duration,
              reverseDuration: duration,
              child: selected
                  ? const Icon(Icons.check, color: Colors.white)
                  : const SizedBox.shrink(),
            ),
          ),
        );
        final Widget selectorWidget = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => selectAsset(context, asset, index, selected),
          child: Container(
            margin: EdgeInsets.all(indicatorSize / 4),
            width: isPreviewEnabled ? indicatorSize : null,
            height: isPreviewEnabled ? indicatorSize : null,
            alignment: AlignmentDirectional.topEnd,
            child: (!isPreviewEnabled && isSingleAssetMode && !selected)
                ? const SizedBox.shrink()
                : innerSelector,
          ),
        );
        if (isPreviewEnabled) {
          return PositionedDirectional(
            top: 0,
            end: 0,
            child: selectorWidget,
          );
        }
        return selectorWidget;
      },
    );
  }

  @override
  Widget selectedBackdrop(BuildContext context, int index, AssetEntity asset) {
    final double indicatorSize =
        MediaQuery.sizeOf(context).width / gridCount / 3;
    return Positioned.fill(
      child: GestureDetector(
        onTap: isPreviewEnabled ? () => viewAsset(context, index, asset) : null,
        child: Consumer<DefaultAssetPickerProvider>(
          builder: (_, DefaultAssetPickerProvider p, __) {
            final int index = p.selectedAssets.indexOf(asset);
            final bool selected = index != -1;
            return AnimatedContainer(
              duration: switchingPathDuration,
              padding: EdgeInsets.all(indicatorSize * .35),
              color: selected
                  ? theme.colorScheme.primary.withOpacity(.45)
                  : theme.colorScheme.background.withOpacity(.1),
              child: selected && !isSingleAssetMode
                  ? Align(
                      alignment: AlignmentDirectional.topStart,
                      child: SizedBox(
                        height: indicatorSize / 2.5,
                        child: FittedBox(
                          alignment: AlignmentDirectional.topStart,
                          fit: BoxFit.cover,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: theme.textTheme.bodyLarge?.color
                                  ?.withOpacity(.75),
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget videoIndicator(BuildContext context, AssetEntity asset) {
    return PositionedDirectional(
      start: 0,
      end: 0,
      bottom: 0,
      child: Container(
        width: double.maxFinite,
        height: 26,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.bottomCenter,
            end: AlignmentDirectional.topCenter,
            colors: <Color>[theme.dividerColor, Colors.transparent],
          ),
        ),
        child: Row(
          children: <Widget>[
            const Icon(Icons.videocam, size: 22, color: Colors.white),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 4),
                child: ScaleText(
                  textDelegate.durationIndicatorBuilder(
                    Duration(seconds: asset.duration),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  strutStyle: const StrutStyle(
                    forceStrutHeight: true,
                    height: 1.4,
                  ),
                  maxLines: 1,
                  maxScaleFactor: 1.2,
                  semanticsLabel:
                      semanticsTextDelegate.durationIndicatorBuilder(
                    Duration(seconds: asset.duration),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget bottomActionBar(BuildContext context) {
    Widget child = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(1, -1),
          ),
        ],
      ),
      height: bottomActionBarHeight + context.bottomPadding,
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
        bottom: context.bottomPadding,
      ),
      child: Row(
        children: <Widget>[
          if (isPreviewEnabled) previewButton(context),
          if (isPreviewEnabled || !isSingleAssetMode) const Spacer(),
          if (isPreviewEnabled || !isSingleAssetMode) confirmButton(context),
        ],
      ),
    );
    if (isPermissionLimited) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[accessLimitedBottomTip(context), child],
      );
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    if (keepScrollOffset && Singleton.scrollPosition != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (gridScrollController.hasClients) {
          gridScrollController.jumpTo(Singleton.scrollPosition!.pixels);
        }
      });
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Theme(
        data: theme,
        child: ChangeNotifierProvider<DefaultAssetPickerProvider>.value(
          value: provider,
          builder: (BuildContext context, _) => Material(
            color: theme.canvasColor,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                if (isAppleOS(context))
                  appleOSLayout(context)
                else
                  androidLayout(context),
                if (Platform.isIOS) iOSPermissionOverlay(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
