import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../constants/constants.dart';
import '../delegates/sort_path_delegate.dart';
import '../internals/singleton.dart';
import '../models/path_wrapper.dart';

abstract class AssetPickerProvider<Asset, Path> extends ChangeNotifier {
  AssetPickerProvider({
    this.maxAssets = defaultMaxAssetsCount,
    this.pageSize = defaultAssetsPerPage,
    this.pathThumbnailSize = defaultPathThumbnailSize,
    List<Asset>? selectedAssets,
  }) : assert(maxAssets > 0, 'maxAssets must be greater than 0.'),
       assert(pageSize > 0, 'pageSize must be greater than 0.'),
       previousSelectedAssets =
           selectedAssets?.toList(growable: false) ?? List<Asset>.empty(),
       _selectedAssets =
           selectedAssets?.toList() ?? List<Asset>.empty(growable: true);

  final int maxAssets;

  final int pageSize;

  final ThumbnailSize pathThumbnailSize;

  final List<Asset> previousSelectedAssets;

  @override
  void dispose() {
    _isAssetsEmpty = false;
    _paths.clear();
    _currentPath = null;
    _currentAssets.clear();
    _mounted = false;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_mounted) {
      super.notifyListeners();
    }
  }

  bool get mounted => _mounted;
  bool _mounted = true;

  Future<void> getPaths();

  Future<Uint8List?> getThumbnailFromPath(PathWrapper<Path> path);

  Future<void> switchPath([PathWrapper<Path>? path]);

  Future<void> getAssetsFromPath(int page, Path path);

  Future<void> loadMoreAssets();

  bool get isAssetsEmpty => _isAssetsEmpty;
  bool _isAssetsEmpty = false;

  set isAssetsEmpty(bool value) {
    if (value == _isAssetsEmpty) {
      return;
    }
    _isAssetsEmpty = value;
    notifyListeners();
  }

  bool get hasAssetsToDisplay => _hasAssetsToDisplay;
  bool _hasAssetsToDisplay = false;

  set hasAssetsToDisplay(bool value) {
    if (value == _hasAssetsToDisplay) {
      return;
    }
    _hasAssetsToDisplay = value;
    notifyListeners();
  }

  bool? _hasMoreToLoad;

  bool get hasMoreToLoad {
    if (_hasMoreToLoad case final bool value) {
      return value;
    }
    if (_totalAssetsCount case final int count) {
      return _currentAssets.length < count;
    }
    return true;
  }

  int get currentAssetsListPage =>
      (math.max(1, _currentAssets.length) / pageSize).ceil();

  int? get totalAssetsCount => _totalAssetsCount;
  int? _totalAssetsCount;

  set totalAssetsCount(int? value) {
    if (value == _totalAssetsCount) {
      return;
    }
    _totalAssetsCount = value;
    notifyListeners();
  }

  List<PathWrapper<Path>> get paths => _paths;
  List<PathWrapper<Path>> _paths = <PathWrapper<Path>>[];

  set paths(List<PathWrapper<Path>> value) {
    if (value != _paths) {
      _paths = value;
      notifyListeners();
    }
  }

  void setPathThumbnail(Path path, Uint8List? data) {
    final int index = _paths.indexWhere(
      (PathWrapper<Path> w) => w.path == path,
    );
    if (index != -1) {
      final PathWrapper<Path> newWrapper = _paths[index].copyWith(
        thumbnailData: data,
      );
      _paths[index] = newWrapper;
      notifyListeners();
    }
  }

  PathWrapper<Path>? get currentPath => _currentPath;
  PathWrapper<Path>? _currentPath;

  set currentPath(PathWrapper<Path>? value) {
    if (value == _currentPath) {
      return;
    }
    _currentPath = value;
    notifyListeners();
  }

  List<Asset> get currentAssets => _currentAssets;
  List<Asset> _currentAssets = <Asset>[];

  set currentAssets(List<Asset> value) {
    if (value == _currentAssets) {
      return;
    }
    _currentAssets = value.toList();
    notifyListeners();
  }

  List<Asset> get selectedAssets => _selectedAssets;
  late List<Asset> _selectedAssets;

  set selectedAssets(List<Asset> value) {
    if (value == _selectedAssets) {
      return;
    }
    _selectedAssets = value.toList();
    notifyListeners();
  }

  String get selectedDescriptions => _selectedAssets
      .fold(<String>[], (List<String> list, Asset a) => list..add(a.toString()))
      .join();

  bool get isSelectedNotEmpty => selectedAssets.isNotEmpty;

  bool get selectedMaximumAssets => selectedAssets.length == maxAssets;

  void selectAsset(Asset item) {
    if (selectedAssets.length == maxAssets || selectedAssets.contains(item)) {
      return;
    }
    final List<Asset> set = selectedAssets.toList();
    set.add(item);
    selectedAssets = set;
  }

  void unSelectAsset(Asset item) {
    final List<Asset> set = selectedAssets.toList();
    set.remove(item);
    selectedAssets = set;
  }
}

class DefaultAssetPickerProvider
    extends AssetPickerProvider<AssetEntity, AssetPathEntity> {
  DefaultAssetPickerProvider({
    super.selectedAssets,
    super.maxAssets,
    super.pageSize,
    super.pathThumbnailSize,
    this.requestType = RequestType.image,
    this.sortPathDelegate = SortPathDelegate.common,
    this.sortPathsByModifiedDate = false,
    this.filterOptions,
    Duration initializeDelayDuration = const Duration(milliseconds: 250),
  }) {
    Singleton.sortPathDelegate = sortPathDelegate ?? SortPathDelegate.common;

    Future<void>.delayed(initializeDelayDuration, () async {
      await getPaths(onlyAll: true);
      await getPaths(onlyAll: false);
    });
  }

  @visibleForTesting
  DefaultAssetPickerProvider.forTest({
    super.selectedAssets,
    this.requestType = RequestType.image,
    this.sortPathDelegate = SortPathDelegate.common,
    this.sortPathsByModifiedDate = false,
    this.filterOptions,
    super.maxAssets,
    super.pageSize = 80,
    super.pathThumbnailSize,
  }) {
    Singleton.sortPathDelegate = sortPathDelegate ?? SortPathDelegate.common;
  }

  final RequestType requestType;

  final SortPathDelegate<AssetPathEntity>? sortPathDelegate;

  final bool sortPathsByModifiedDate;

  final PMFilter? filterOptions;

  @override
  set currentPath(PathWrapper<AssetPathEntity>? value) {
    if (value == _currentPath) {
      return;
    }
    _currentPath = value;
    if (value != null) {
      final int index = _paths.indexWhere(
        (PathWrapper<AssetPathEntity> p) => p.path.id == value.path.id,
      );
      if (index != -1) {
        _paths[index] = value;
        getThumbnailFromPath(value);
      }
    }
    notifyListeners();
  }

  @override
  Future<void> getPaths({
    bool onlyAll = false,
    bool keepPreviousCount = false,
  }) async {
    final PMFilter? options;
    final fog = filterOptions;
    if (fog is FilterOptionGroup) {
      options = FilterOptionGroup(
        imageOption: const FilterOption(
          sizeConstraint: SizeConstraint(ignoreSize: true),
        ),
        audioOption: const FilterOption(
          needTitle: true,
          sizeConstraint: SizeConstraint(ignoreSize: true),
        ),
        containsPathModified: sortPathsByModifiedDate,
        createTimeCond: DateTimeCond.def().copyWith(ignore: true),
        updateTimeCond: DateTimeCond.def().copyWith(ignore: true),
      )..merge(fog);
    } else if (fog == null && Platform.isAndroid) {
      options = AdvancedCustomFilter(
        orderBy: [OrderByItem.desc(CustomColumns.android.modifiedDate)],
      );
    } else {
      options = fog;
    }

    final list = await PhotoManager.getAssetPathList(
      type: requestType,
      filterOption: options,
      onlyAll: onlyAll,
    );

    _paths = list.map((p) {
      final int? assetCount;
      if (keepPreviousCount) {
        assetCount = _paths
            .where((e) => e.path.id == p.id)
            .firstOrNull
            ?.assetCount;
      } else {
        assetCount = null;
      }
      return PathWrapper<AssetPathEntity>(path: p, assetCount: assetCount);
    }).toList();

    Singleton.sortPathDelegate.sort(_paths);

    for (final path in _paths) {
      Future(() async {
        await getAssetCountFromPath(path);
        await getThumbnailFromPath(path);
      });
    }

    if (_paths.isNotEmpty) {
      _currentPath ??= _paths.first;
    }

    if (onlyAll) {
      await getAssetsFromCurrentPath();
    }
  }

  Completer<void>? _getAssetsFromPathCompleter;

  @override
  Future<void> getAssetsFromPath([int? page, AssetPathEntity? path]) {
    Future<void> run() async {
      final currentPage = page ?? currentAssetsListPage;
      final currentPath = path ?? this.currentPath!.path;
      final list = await currentPath.getAssetListPaged(
        page: currentPage,
        size: pageSize,
      );
      if (currentPage == 0) {
        _currentAssets.clear();
        _hasMoreToLoad = null;
      } else if (list.isEmpty) {
        _hasMoreToLoad = false;
      }
      _currentAssets.addAll(list);
      _hasAssetsToDisplay = _currentAssets.isNotEmpty;
      _isAssetsEmpty = _currentAssets.isEmpty;
      notifyListeners();
    }

    if (_getAssetsFromPathCompleter == null) {
      final completer = Completer<void>();
      _getAssetsFromPathCompleter = completer;
      run()
          .then((r) {
            completer.complete();
          })
          .catchError((Object e, StackTrace s) {
            completer.completeError(e, s);
          })
          .whenComplete(() {
            _getAssetsFromPathCompleter = null;
          });
    }
    return _getAssetsFromPathCompleter!.future;
  }

  @override
  Future<void> loadMoreAssets() => getAssetsFromPath();

  @override
  Future<void> switchPath([PathWrapper<AssetPathEntity>? path]) async {
    assert(() {
      if (path == null && _currentPath == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('Switching empty path.'),
          ErrorDescription(
            'Neither "path" nor "currentPathEntity" is non-null, '
            'which makes this method useless.',
          ),
          ErrorHint(
            'You need to pass a non-null path or call this method '
            'when the "currentPath" is not null.',
          ),
        ]);
      }
      return true;
    }());
    if (path == null && _currentPath == null) {
      return;
    }
    path ??= _currentPath!;
    _currentPath = path;
    await getAssetsFromCurrentPath();
  }

  @override
  Future<Uint8List?> getThumbnailFromPath(
    PathWrapper<AssetPathEntity> path,
  ) async {
    try {
      if (requestType == RequestType.audio) {
        return null;
      }
      final int assetCount = path.assetCount ?? await path.path.assetCountAsync;
      if (assetCount == 0) {
        return null;
      }
      final List<AssetEntity> assets = await path.path.getAssetListRange(
        start: 0,
        end: 1,
      );
      if (assets.isEmpty) {
        return null;
      }
      final AssetEntity asset = assets.single;

      if (asset.type != AssetType.image && asset.type != AssetType.video) {
        return null;
      }
      final Uint8List? data = await asset.thumbnailDataWithSize(
        pathThumbnailSize,
      );
      final int index = _paths.indexWhere(
        (PathWrapper<AssetPathEntity> p) => p.path == path.path,
      );
      if (index != -1) {
        _paths[index] = _paths[index].copyWith(
          assetCount: assetCount,
          thumbnailData: data,
        );
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      FlutterError.presentError(
        FlutterErrorDetails(
          exception: e,
          stack: s,
          library: packageName,
          silent: true,
        ),
      );
      return null;
    }
  }

  Future<void> getAssetCountFromPath(PathWrapper<AssetPathEntity> path) async {
    final int assetCount = await path.path.assetCountAsync;
    final int index = _paths.indexWhere(
      (PathWrapper<AssetPathEntity> p) => p == path,
    );
    if (index != -1) {
      _paths[index] = _paths[index].copyWith(assetCount: assetCount);
      if (index == 0) {
        _currentPath = _currentPath?.copyWith(assetCount: assetCount);
      }
      notifyListeners();
    }
  }

  Future<void> getAssetsFromCurrentPath() async {
    if (_paths.isEmpty && _currentPath != null) {
      throw StateError('The current path is not synced with the empty paths.');
    }
    if (_paths.isNotEmpty && _currentPath == null) {
      throw StateError('The empty path is not synced with the current paths.');
    }
    if (_paths.isEmpty || _currentPath == null) {
      isAssetsEmpty = true;
      return;
    }
    await getAssetsFromPath(0, currentPath!.path);
  }
}
