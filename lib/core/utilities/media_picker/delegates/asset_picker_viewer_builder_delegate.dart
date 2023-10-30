part of '../media_picker.dart';

abstract class AssetPickerViewerBuilderDelegate<Asset, Path> {
  AssetPickerViewerBuilderDelegate({
    required this.previewAssets,
    required this.themeData,
    required this.currentIndex,
    this.selectorProvider,
    this.provider,
    this.selectedAssets,
    this.maxAssets,
    this.shouldReversePreview = false,
    this.selectPredicate,
  })  : assert(maxAssets == null || maxAssets > 0),
        assert(currentIndex >= 0);

  final AssetPickerViewerProvider<Asset>? provider;

  final List<Asset> previewAssets;

  final ThemeData themeData;

  final List<Asset>? selectedAssets;

  final AssetPickerProvider<Asset, Path>? selectorProvider;

  final bool shouldReversePreview;

  final AssetSelectPredicate<Asset>? selectPredicate;

  final StreamController<int> pageStreamController =
      StreamController<int>.broadcast();

  final ScrollController previewingListController = ScrollController();

  final ValueNotifier<bool> isDisplayingDetail = ValueNotifier<bool>(true);

  late AssetPickerViewerState<Asset, Path> viewerState;

  late AnimationController doubleTapAnimationController;

  late Animation<double> doubleTapCurveAnimation;

  Animation<double>? doubleTapAnimation;

  late VoidCallback doubleTapListener;

  ExtendedPageController get pageController => _pageController;
  late final ExtendedPageController _pageController = ExtendedPageController(
    initialPage: currentIndex,
  );

  int currentIndex;

  final int? maxAssets;

  late final bool isSelectedPreviewing = selectedAssets == previewAssets;

  Asset get currentAsset => previewAssets.elementAt(currentIndex);

  double get bottomPreviewHeight => 90.0;

  double get bottomBarHeight => 50.0;

  double get bottomDetailHeight => bottomPreviewHeight + bottomBarHeight;

  bool isAppleOS(BuildContext context) => switch (context.theme.platform) {
        TargetPlatform.iOS || TargetPlatform.macOS => true,
        _ => false,
      };

  AssetPickerTextDelegate get textDelegate => Singleton.textDelegate;

  AssetPickerTextDelegate get semanticsTextDelegate =>
      Singleton.textDelegate.semanticsTextDelegate;

  @mustCallSuper
  void initStateAndTicker(
    covariant AssetPickerViewerState<Asset, Path> state,
    TickerProvider v,
  ) {
    initAnimations(state);
  }

  @mustCallSuper
  void didUpdateViewer(
    covariant AssetPickerViewerState<Asset, Path> state,
    covariant AssetPickerViewer<Asset, Path> oldWidget,
    covariant AssetPickerViewer<Asset, Path> newWidget,
  ) {
    initAnimations(state);
  }

  @mustCallSuper
  void dispose() {
    provider?.dispose();
    pageController.dispose();
    pageStreamController.close();
    previewingListController.dispose();
    selectedNotifier.dispose();
    isDisplayingDetail.dispose();
    doubleTapAnimationController
      ..stop()
      ..reset()
      ..dispose();
  }

  void initAnimations(covariant AssetPickerViewerState<Asset, Path> state) {
    viewerState = state;
    doubleTapAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: state,
    );
    doubleTapCurveAnimation = CurvedAnimation(
      parent: doubleTapAnimationController,
      curve: Curves.easeInOut,
    );
  }

  OrdinalSortKey ordinalSortKey(double value) {
    return OrdinalSortKey(value, name: 'AssetPickerViewerBuilderDelegate');
  }

  void updateAnimation(ExtendedImageGestureState state) {
    final double begin = state.gestureDetails!.totalScale!;
    final double end = state.gestureDetails!.totalScale! == 1.0 ? 3.0 : 1.0;
    final Offset pointerDownPosition = state.pointerDownPosition!;

    doubleTapAnimation?.removeListener(doubleTapListener);
    doubleTapAnimationController
      ..stop()
      ..reset();
    doubleTapListener = () {
      state.handleDoubleTap(
        scale: doubleTapAnimation!.value,
        doubleTapPosition: pointerDownPosition,
      );
    };
    doubleTapAnimation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(doubleTapCurveAnimation)
      ..addListener(doubleTapListener);
    doubleTapAnimationController.forward();
  }

  int get selectedCount => selectedAssets?.length ?? 0;

  bool get selectedMaximumAssets =>
      selectedAssets != null && selectedAssets!.length == maxAssets;

  late final ValueNotifier<int> selectedNotifier =
      ValueNotifier<int>(selectedCount);

  void unSelectAsset(Asset entity) {
    provider?.unSelectAsset(entity);
    selectorProvider?.unSelectAsset(entity);
    if (!isSelectedPreviewing) {
      selectedAssets?.remove(entity);
    }
    selectedNotifier.value = selectedCount;
  }

  void selectAsset(Asset entity) {
    if (maxAssets != null && selectedCount >= maxAssets!) {
      return;
    }
    provider?.selectAsset(entity);
    selectorProvider?.selectAsset(entity);
    if (!isSelectedPreviewing) {
      selectedAssets?.add(entity);
    }
    selectedNotifier.value = selectedCount;
  }

  Future<bool> onChangingSelected(
    BuildContext context,
    Asset asset,
    bool isSelected,
  ) async {
    final bool? selectPredicateResult = await selectPredicate?.call(
      context,
      asset,
      isSelected,
    );
    if (selectPredicateResult == false) {
      return false;
    }
    if (isSelected) {
      unSelectAsset(asset);
    } else {
      selectAsset(asset);
    }
    return true;
  }

  void switchDisplayingDetail({bool? value}) {
    isDisplayingDetail.value = value ?? !isDisplayingDetail.value;
  }

  @Deprecated('The method is not used by the package anymore')
  Future<bool> syncSelectedAssetsWhenPop() async {
    if (provider?.currentlySelectedAssets != null) {
      selectorProvider?.selectedAssets = provider!.currentlySelectedAssets;
    }
    return true;
  }

  Widget assetPageBuilder(BuildContext context, int index);

  Widget previewWidgetLoadStateChanged(
    BuildContext context,
    ExtendedImageState state, {
    bool hasLoaded = false,
  }) {
    return switch (state.extendedImageLoadState) {
      LoadState.completed => hasLoaded
          ? state.completedWidget
          : FadeImageBuilder(child: state.completedWidget),
      LoadState.failed => failedItemBuilder(context),
      LoadState.loading => const SizedBox.shrink(),
    };
  }

  Widget failedItemBuilder(BuildContext context) {
    return Center(
      child: ScaleText(
        textDelegate.loadFailed,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18.0),
        semanticsLabel: semanticsTextDelegate.loadFailed,
      ),
    );
  }

  Widget confirmButton(BuildContext context);

  Widget selectButton(BuildContext context);

  Widget bottomDetailItemBuilder(BuildContext context, int index);

  Widget bottomDetailBuilder(BuildContext context);

  Widget build(BuildContext context);
}

class DefaultAssetPickerViewerBuilderDelegate
    extends AssetPickerViewerBuilderDelegate<AssetEntity, AssetPathEntity> {
  DefaultAssetPickerViewerBuilderDelegate({
    required super.currentIndex,
    required super.previewAssets,
    required super.themeData,
    super.selectorProvider,
    super.provider,
    super.selectedAssets,
    this.previewThumbnailSize,
    this.specialPickerType,
    super.maxAssets,
    super.shouldReversePreview,
    super.selectPredicate,
  });

  final ThumbnailSize? previewThumbnailSize;

  final SpecialPickerType? specialPickerType;

  bool get isMoment => specialPickerType == SpecialPickerType.moment;

  bool get hasVideo =>
      previewAssets.any((AssetEntity e) => e.type == AssetType.video) ||
      (selectedAssets?.any((AssetEntity e) => e.type == AssetType.video) ??
          false);

  @override
  Widget assetPageBuilder(BuildContext context, int index) {
    final AssetEntity asset = previewAssets.elementAt(index);
    final Widget builder = switch (asset.type) {
      AssetType.audio => AudioPageBuilder(asset: asset),
      AssetType.image => ImagePageBuilder(
          asset: asset,
          delegate: this,
          previewThumbnailSize: previewThumbnailSize,
        ),
      AssetType.video => VideoPageBuilder(
          asset: asset,
          delegate: this,
          hasOnlyOneVideoAndMoment: isMoment && hasVideo,
        ),
      AssetType.other => Center(
          child: ScaleText(
            textDelegate.unSupportedAssetType,
            semanticsLabel: semanticsTextDelegate.unSupportedAssetType,
          ),
        ),
    };
    return MergeSemantics(
      child: Consumer<AssetPickerViewerProvider<AssetEntity>?>(
        builder: (
          BuildContext c,
          AssetPickerViewerProvider<AssetEntity>? p,
          Widget? w,
        ) {
          final bool isSelected =
              (p?.currentlySelectedAssets ?? selectedAssets)?.contains(asset) ??
                  false;
          String hint = '';
          if (asset.type == AssetType.audio || asset.type == AssetType.video) {
            hint += '${semanticsTextDelegate.sNameDurationLabel}: ';
            hint += textDelegate.durationIndicatorBuilder(asset.videoDuration);
          }
          if (asset.title?.isNotEmpty ?? false) {
            hint += ', ${asset.title}';
          }
          return Semantics(
            label: '${semanticsTextDelegate.semanticTypeLabel(asset.type)}'
                '${index + 1}, '
                '${asset.createDateTime.toString().replaceAll('.000', '')}',
            selected: isSelected,
            hint: hint,
            image:
                asset.type == AssetType.image || asset.type == AssetType.video,
            child: w,
          );
        },
        child: builder,
      ),
    );
  }

  Widget _audioPreviewItem(AssetEntity asset) {
    return ColoredBox(
      color: viewerState.context.theme.dividerColor,
      child: const Center(child: Icon(Icons.audiotrack)),
    );
  }

  Widget _imagePreviewItem(AssetEntity asset) {
    return Positioned.fill(
      child: RepaintBoundary(
        child: ExtendedImage(
          image: AssetEntityImageProvider(asset, isOriginal: false),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _videoPreviewItem(AssetEntity asset) {
    return Positioned.fill(
      child: Stack(
        children: <Widget>[
          _imagePreviewItem(asset),
          Center(
            child: Icon(
              Icons.video_library,
              color: themeData.iconTheme.color?.withOpacity(0.54),
            ),
          ),
        ],
      ),
    );
  }

  Widget momentVideoBackButton(BuildContext context) {
    return PositionedDirectional(
      start: 16,
      top: context.topPadding + 16,
      child: Semantics(
        sortKey: ordinalSortKey(0),
        child: IconButton(
          onPressed: Navigator.of(context).maybePop,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.tight(const Size.square(28)),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          iconSize: 18,
          icon: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: themeData.iconTheme.color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.keyboard_return_rounded,
              color: themeData.canvasColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget bottomDetailBuilder(BuildContext context) {
    return ValueListenableBuilder2<bool, int>(
      firstNotifier: isDisplayingDetail,
      secondNotifier: selectedNotifier,
      builder: (_, bool v, __, Widget? child) => AnimatedPositionedDirectional(
        duration: kThemeAnimationDuration,
        curve: Curves.easeInOut,
        bottom: v ? 0 : -(context.bottomPadding + bottomDetailHeight),
        start: 0,
        end: 0,
        height: context.bottomPadding + bottomDetailHeight,
        child: child!,
      ),
      child:
          ChangeNotifierProvider<AssetPickerViewerProvider<AssetEntity>?>.value(
        value: provider,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if (provider != null)
              ValueListenableBuilder<int>(
                valueListenable: selectedNotifier,
                builder: (_, int count, __) => SizedBox(
                  width: count > 0 ? double.maxFinite : 0,
                  height: bottomPreviewHeight,
                  child: ListView.builder(
                    controller: previewingListController,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    physics: const ClampingScrollPhysics(),
                    itemCount: count,
                    itemBuilder: bottomDetailItemBuilder,
                  ),
                ),
              ),
            Container(
              height: bottomBarHeight + context.bottomPadding,
              padding: const EdgeInsets.symmetric(horizontal: 20.0)
                  .copyWith(bottom: context.bottomPadding),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: themeData.canvasColor)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if (provider != null || isMoment) confirmButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget bottomDetailItemBuilder(BuildContext context, int index) {
    const double padding = 8.0;

    void onTap(AssetEntity asset) {
      final int page;
      if (previewAssets != selectedAssets) {
        page = previewAssets.indexOf(asset);
      } else {
        page = index;
      }
      if (pageController.page == page.toDouble()) {
        return;
      }
      pageController.jumpToPage(page);
      final double offset =
          (index - 0.5) * (bottomPreviewHeight - padding * 3) -
              MediaQuery.sizeOf(context).width / 4;
      previewingListController.animateTo(
        math.max(0, offset),
        curve: Curves.ease,
        duration: kThemeChangeDuration,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: padding,
        vertical: padding * 2,
      ),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: StreamBuilder<int>(
          initialData: currentIndex,
          stream: pageStreamController.stream,
          builder: (_, AsyncSnapshot<int> snapshot) {
            final AssetEntity asset = selectedAssets!.elementAt(index);
            final bool isViewing = previewAssets[snapshot.data!] == asset;
            final Widget item = switch (asset.type) {
              AssetType.image => _imagePreviewItem(asset),
              AssetType.video => _videoPreviewItem(asset),
              AssetType.audio => _audioPreviewItem(asset),
              AssetType.other => const SizedBox.shrink(),
            };
            return Semantics(
              label: '${semanticsTextDelegate.semanticTypeLabel(asset.type)}'
                  '${index + 1}',
              selected: isViewing,
              onTap: () => onTap(asset),
              onTapHint: semanticsTextDelegate.sActionPreviewHint,
              excludeSemantics: true,
              child: GestureDetector(
                onTap: () => onTap(asset),
                child: Selector<AssetPickerViewerProvider<AssetEntity>?,
                    List<AssetEntity>?>(
                  selector: (_, AssetPickerViewerProvider<AssetEntity>? p) =>
                      p?.currentlySelectedAssets,
                  child: item,
                  builder: (
                    _,
                    List<AssetEntity>? currentlySelectedAssets,
                    Widget? w,
                  ) {
                    final bool isSelected =
                        currentlySelectedAssets?.contains(asset) ?? false;
                    return Stack(
                      children: <Widget>[
                        w!,
                        AnimatedContainer(
                          duration: kThemeAnimationDuration,
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            border: isViewing
                                ? Border.all(
                                    color: themeData.primaryColor,
                                    width: 3,
                                  )
                                : null,
                            color: isSelected
                                ? null
                                : themeData.colorScheme.surface
                                    .withOpacity(0.54),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDisplayingDetail,
      builder: (_, bool value, Widget? child) => AnimatedPositionedDirectional(
        duration: kThemeAnimationDuration,
        curve: Curves.easeInOut,
        top: value ? 0.0 : -(context.topPadding + kToolbarHeight),
        start: 0.0,
        end: 0.0,
        height: context.topPadding + kToolbarHeight,
        child: child!,
      ),
      child: Container(
        padding: EdgeInsetsDirectional.only(top: context.topPadding),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Semantics(
                  sortKey: ordinalSortKey(0),
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.close),
                    onPressed: Navigator.of(context).maybePop,
                  ),
                ),
              ),
            ),
            if (!isAppleOS(context) && specialPickerType == null)
              Expanded(
                child: Center(
                  child: Semantics(
                    sortKey: ordinalSortKey(0.1),
                    child: StreamBuilder<int>(
                      initialData: currentIndex,
                      stream: pageStreamController.stream,
                      builder: (_, AsyncSnapshot<int> snapshot) => ScaleText(
                        '${snapshot.data! + 1}/${previewAssets.length}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (provider != null)
              Expanded(
                child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: const EdgeInsetsDirectional.only(end: 14),
                  child: Semantics(
                    sortKey: ordinalSortKey(0.2),
                    child: selectButton(context),
                  ),
                ),
              )
            else
              const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Widget confirmButton(BuildContext context) {
    return ChangeNotifierProvider<
        AssetPickerViewerProvider<AssetEntity>?>.value(
      value: provider,
      child: Consumer<AssetPickerViewerProvider<AssetEntity>?>(
        builder: (_, AssetPickerViewerProvider<AssetEntity>? provider, __) {
          assert(
            isMoment || provider != null,
            'Viewer provider must not be null '
            'when the special type is not moment.',
          );
          Future<void> onPressed() async {
            if (isMoment && hasVideo) {
              Navigator.of(context).pop(<AssetEntity>[currentAsset]);
              return;
            }
            if (provider!.isSelectedNotEmpty) {
              Navigator.of(context).pop(provider.currentlySelectedAssets);
              return;
            }
            if (await onChangingSelected(context, currentAsset, false)) {
              if (!context.mounted) return;
              Navigator.of(context).pop(
                selectedAssets ?? <AssetEntity>[currentAsset],
              );
            }
          }

          String buildText() {
            if (isMoment && hasVideo) {
              return textDelegate.confirm;
            }
            if (provider!.isSelectedNotEmpty) {
              return '${textDelegate.confirm}'
                  ' (${provider.currentlySelectedAssets.length}'
                  '/'
                  '${selectorProvider!.maxAssets})';
            }
            return textDelegate.confirm;
          }

          final bool isButtonEnabled = provider == null ||
              provider.currentlySelectedAssets.isNotEmpty ||
              previewAssets.isEmpty ||
              selectedNotifier.value == 0;
          return MaterialButton(
            minWidth: (isMoment && hasVideo) || provider!.isSelectedNotEmpty
                ? 48
                : 20,
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: themeData.primaryColor,
            disabledColor: themeData.dividerColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            onPressed: isButtonEnabled ? onPressed : null,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: ScaleText(
              buildText(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.fade,
              softWrap: false,
              semanticsLabel: () {
                if (isMoment && hasVideo) {
                  return semanticsTextDelegate.confirm;
                }
                if (provider!.isSelectedNotEmpty) {
                  return '${semanticsTextDelegate.confirm}'
                      ' (${provider.currentlySelectedAssets.length}'
                      '/'
                      '${selectorProvider!.maxAssets})';
                }
                return semanticsTextDelegate.confirm;
              }(),
            ),
          );
        },
      ),
    );
  }

  Widget _appleOSSelectButton(
    BuildContext context,
    bool isSelected,
    AssetEntity asset,
  ) {
    if (!isSelected && selectedMaximumAssets) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 10.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Feedback.forTap(context);
          onChangingSelected(context, asset, isSelected);
        },
        child: AnimatedContainer(
          duration: kThemeAnimationDuration,
          width: 28.0,
          decoration: BoxDecoration(
            border: !isSelected
                ? Border.all(color: themeData.iconTheme.color!)
                : null,
            color: isSelected ? themeData.colorScheme.secondary : null,
            shape: BoxShape.circle,
          ),
          child: const Center(child: Icon(Icons.check, size: 20.0)),
        ),
      ),
    );
  }

  Widget _androidSelectButton(
    BuildContext context,
    bool isSelected,
    AssetEntity asset,
  ) {
    return Checkbox(
      value: isSelected,
      activeColor: themeData.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999999),
      ),
      onChanged: (_) => onChangingSelected(context, asset, isSelected),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  @override
  Widget selectButton(BuildContext context) {
    return ChangeNotifierProvider<AssetPickerViewerProvider<AssetEntity>>.value(
      value: provider!,
      builder: (_, Widget? w) => StreamBuilder<int>(
        initialData: currentIndex,
        stream: pageStreamController.stream,
        builder: (BuildContext _, AsyncSnapshot<int> s) {
          final AssetEntity asset = previewAssets.elementAt(s.data!);
          return Selector<AssetPickerViewerProvider<AssetEntity>,
              List<AssetEntity>>(
            selector: (_, AssetPickerViewerProvider<AssetEntity> p) =>
                p.currentlySelectedAssets,
            builder: (BuildContext c, List<AssetEntity> assets, _) {
              final bool isSelected = assets.contains(asset);
              return Semantics(
                selected: isSelected,
                label: semanticsTextDelegate.select,
                onTap: () => onChangingSelected(context, asset, isSelected),
                onTapHint: semanticsTextDelegate.select,
                excludeSemantics: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (isAppleOS(context))
                      _appleOSSelectButton(c, isSelected, asset)
                    else
                      _androidSelectButton(c, isSelected, asset),
                    if (!isAppleOS(context))
                      ScaleText(
                        textDelegate.select,
                        style: const TextStyle(
                          fontSize: 17,
                          height: 1.2,
                          color: Colors.white,
                        ),
                        semanticsLabel: semanticsTextDelegate.select,
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _pageViewBuilder(BuildContext context) {
    return Semantics(
      sortKey: ordinalSortKey(1),
      child: ExtendedImageGesturePageView.builder(
        physics: previewAssets.length == 1
            ? const CustomClampingScrollPhysics()
            : const CustomBouncingScrollPhysics(),
        controller: pageController,
        itemCount: previewAssets.length,
        itemBuilder: assetPageBuilder,
        reverse: shouldReversePreview,
        onPageChanged: (int index) {
          currentIndex = index;
          pageStreamController.add(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: themeData.appBarTheme.systemOverlayStyle ??
            (themeData.effectiveBrightness.isDark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark),
        child: Material(
          color: themeData.colorScheme.onSecondary,
          child: Stack(
            children: <Widget>[
              Positioned.fill(child: _pageViewBuilder(context)),
              if (isMoment && hasVideo) ...<Widget>[
                momentVideoBackButton(context),
                PositionedDirectional(
                  end: 16,
                  bottom: context.bottomPadding + 16,
                  child: confirmButton(context),
                ),
              ] else ...<Widget>[
                appBar(context),
                if (selectedAssets != null ||
                    (isMoment && hasVideo && isAppleOS(context)))
                  bottomDetailBuilder(context),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
