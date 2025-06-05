import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart' show AssetEntity;

import '../provider/asset_picker_provider.dart';
import 'asset_picker_builder_delegate.dart';

class AssetGridDragSelectionCoordinator {
  AssetGridDragSelectionCoordinator({required this.delegate});

  final DefaultAssetPickerBuilderDelegate delegate;

  static const double _kDefaultAutoScrollVelocityScalar = 50.0;

  EdgeDraggingAutoScroller? _autoScroller;

  int initialSelectingIndex = -1;

  int largestSelectingIndex = -1;
  int smallestSelectingIndex = -1;

  bool dragging = false;

  bool addSelected = true;

  DefaultAssetPickerProvider get provider => delegate.provider;

  void resetDraggingStatus() {
    _autoScroller?.stopAutoScroll();
    _autoScroller = null;
    dragging = false;
    addSelected = true;
    initialSelectingIndex = -1;
    largestSelectingIndex = -1;
    smallestSelectingIndex = -1;
  }

  void onSelectionStart({
    required BuildContext context,
    required Offset globalPosition,
    required int index,
    required AssetEntity asset,
  }) {
    final scrollableState = _checkScrollableStatePresent(context);
    if (scrollableState == null) {
      return;
    }

    if (delegate.gridScrollController.position.isScrollingNotifier.value) {
      return;
    }

    dragging = true;

    _autoScroller = EdgeDraggingAutoScroller(
      scrollableState,
      velocityScalar: _kDefaultAutoScrollVelocityScalar,
    );

    initialSelectingIndex = index;
    largestSelectingIndex = index;
    smallestSelectingIndex = index;

    addSelected = !delegate.provider.selectedAssets.contains(asset);
  }

  void onSelectionUpdate({
    required BuildContext context,
    required Offset globalPosition,
    required BoxConstraints constraints,
  }) {
    if (!dragging) {
      return;
    }

    final view = View.of(context);
    final dimensionSize = view.physicalSize / view.devicePixelRatio;

    final appBarSize =
        delegate.appBarPreferredSize ?? delegate.appBar(context).preferredSize;
    final viewPaddingTop = view.viewPadding.top / view.devicePixelRatio;
    final viewPaddingBottom = view.viewPadding.bottom / view.devicePixelRatio;
    final topSectionHeight = appBarSize.height + viewPaddingTop;
    final bottomSectionHeight =
        delegate.bottomSectionHeight + viewPaddingBottom;
    final gridViewport =
        dimensionSize.height - topSectionHeight - bottomSectionHeight;

    final gridCount = delegate.gridCount;
    final itemSize = dimensionSize.width / gridCount;
    final dividedSpacing = delegate.itemSpacing / gridCount;

    final gridRevert = delegate.effectiveShouldRevertGrid(context);
    final totalRows = (provider.currentAssets.length / gridCount).ceil();
    final onlyOneScreen =
        totalRows * (itemSize + delegate.itemSpacing) <= gridViewport;
    final reverted = gridRevert && !onlyOneScreen;

    final double anchor = delegate.assetGridAnchor(
      context: context,
      constraints: constraints,
      pathWrapper: provider.currentPath,
    );
    final scrolledOffset = delegate.gridScrollController.offset.abs();

    final correctedY =
        switch (reverted) {
          true =>
            dimensionSize.height - bottomSectionHeight - globalPosition.dy,
          false => globalPosition.dy - topSectionHeight,
        } +
        scrolledOffset;

    int getDragAxisIndex(double delta, double itemSize) {
      return delta ~/ (itemSize + dividedSpacing);
    }

    int rowIndex = getDragAxisIndex(correctedY, itemSize);
    final initialFirstPosition = dimensionSize.height * anchor;
    if (reverted && dimensionSize.height > initialFirstPosition) {
      final deductedRow = getDragAxisIndex(
        dimensionSize.height - initialFirstPosition,
        itemSize,
      );
      rowIndex -= deductedRow;
    }

    final placeholderCount = delegate.assetsGridItemPlaceholderCount(
      context: context,
      pathWrapper: provider.currentPath,
      onlyOneScreen: onlyOneScreen,
    );

    if (reverted && placeholderCount > 0 && rowIndex > 0 && anchor < 1.0) {
      rowIndex -= 1;
    }

    int columnIndex = getDragAxisIndex(globalPosition.dx, itemSize);
    if (reverted) {
      columnIndex = gridCount - columnIndex - placeholderCount - 1;
    }

    final currentDragIndex = rowIndex * gridCount + columnIndex;

    smallestSelectingIndex = math.min(currentDragIndex, smallestSelectingIndex);
    smallestSelectingIndex = math.max(0, smallestSelectingIndex);
    largestSelectingIndex = math.max(currentDragIndex, largestSelectingIndex);

    largestSelectingIndex = math.min(
      math.max(0, largestSelectingIndex),
      provider.currentAssets.length,
    );

    final Iterable<AssetEntity> filteredAssetList;
    if (currentDragIndex < initialSelectingIndex) {
      filteredAssetList = provider.currentAssets
          .getRange(
            math.max(0, currentDragIndex),
            math.min(initialSelectingIndex + 1, provider.currentAssets.length),
          )
          .toList()
          .reversed;
    } else {
      filteredAssetList = provider.currentAssets.getRange(
        math.max(0, initialSelectingIndex),
        math.min(currentDragIndex + 1, provider.currentAssets.length),
      );
    }
    final touchedAssets = List<AssetEntity>.from(
      provider.currentAssets.getRange(
        math.max(0, smallestSelectingIndex),
        math.min(largestSelectingIndex + 1, provider.currentAssets.length),
      ),
    );

    for (final asset in filteredAssetList) {
      delegate.selectAsset(context, asset, currentDragIndex, !addSelected);
      touchedAssets.remove(asset);
    }

    for (final asset in touchedAssets) {
      delegate.selectAsset(context, asset, currentDragIndex, addSelected);
    }

    if (filteredAssetList.isEmpty) {
      return;
    }

    if (provider.selectedAssets.isEmpty ||
        provider.selectedAssets.length == provider.maxAssets) {
      _autoScroller?.stopAutoScroll();
      return;
    }

    final Offset dragOffset = Offset(
      columnIndex * itemSize,
      globalPosition.dy +
          (globalPosition.dy > (dimensionSize.height / 2)
              ? bottomSectionHeight
              : -topSectionHeight),
    );
    final dragTarget = dragOffset & Size.square(itemSize);
    _autoScroller?.startAutoScrollIfNecessary(dragTarget);
  }

  void onDragEnd({required Offset globalPosition}) {
    resetDraggingStatus();
  }

  ScrollableState? _checkScrollableStatePresent(BuildContext context) {
    final scrollable = Scrollable.maybeOf(context);
    assert(
      scrollable != null,
      'The drag select feature must use along with scrollables.',
    );
    assert(
      scrollable?.position.axis == Axis.vertical,
      'The drag select feature must use along with vertical scrollables.',
    );
    if (scrollable == null || scrollable.position.axis != Axis.vertical) {
      resetDraggingStatus();
      return null;
    }

    return scrollable;
  }
}
