part of '../media_picker.dart';

class AssetPickerViewerProvider<A> extends ChangeNotifier {
  AssetPickerViewerProvider(
    List<A>? assets, {
    this.maxAssets = defaultMaxAssetsCount,
  }) : assert(maxAssets > 0, 'maxAssets must be greater than 0.') {
    _currentlySelectedAssets = (assets ?? <A>[]).toList();
  }

  final int maxAssets;

  late List<A> _currentlySelectedAssets;

  List<A> get currentlySelectedAssets => _currentlySelectedAssets;

  set currentlySelectedAssets(List<A> value) {
    if (value == _currentlySelectedAssets) {
      return;
    }
    _currentlySelectedAssets = value;
    notifyListeners();
  }

  bool get isSelectedNotEmpty => currentlySelectedAssets.isNotEmpty;

  void selectAsset(A item) {
    if (currentlySelectedAssets.length == maxAssets ||
        currentlySelectedAssets.contains(item)) {
      return;
    }
    final List<A> newList = _currentlySelectedAssets.toList()..add(item);
    currentlySelectedAssets = newList;
  }

  void unSelectAsset(A item) {
    if (currentlySelectedAssets.isEmpty ||
        !currentlySelectedAssets.contains(item)) {
      return;
    }
    final List<A> newList = _currentlySelectedAssets.toList()..remove(item);
    currentlySelectedAssets = newList;
  }
}
