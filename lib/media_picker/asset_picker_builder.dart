part of media_picker;

Duration get switchingPathDuration => kThemeAnimationDuration * 1.5;
bool get isAppleOS => Platform.isIOS || Platform.isMacOS;
Curve get switchingPathCurve => Curves.easeInOut;

class AssetPickerBuilder extends StatefulWidget {
  const AssetPickerBuilder({
    Key? key,
    this.limit = 9,
    this.type = RequestType.common,
    this.back,
    this.menu,
    this.decoration,
    this.appBarColor = Colors.blue,
    this.maxDuration,
    required this.routeDuration,
    this.isSingleAssetMode = false,
    this.isReview = true,
    this.leadingBuilder,
    this.filterOptions,
  }) : super(key: key);
  final FilterOptionGroup? filterOptions;
  final int limit;
  final RequestType type;
  final Widget? back, menu;
  final Decoration? decoration;
  final Color? appBarColor;
  final Duration? maxDuration;
  final Duration routeDuration;
  final bool isSingleAssetMode, isReview;
  final WidgetBuilder? leadingBuilder;

  @override
  State<AssetPickerBuilder> createState() => _AssetPickerBuilderState();
}

class _AssetPickerBuilderState extends State<AssetPickerBuilder> {
  final isLoading = ValueNotifier<bool>(true);
  final currentPathEntity = ValueNotifier<AssetPathEntity?>(null);
  final isSwitchingPath = ValueNotifier<bool>(false);
  WidgetBuilder? get leadingBuilder => widget.leadingBuilder;
  Duration? get maxDuration => widget.maxDuration;
  Duration get routeDuration => widget.routeDuration;
  FilterOptionGroup? get filterOptions => widget.filterOptions;
  bool get isSelectedNotEmpty => selectedData.value.isNotEmpty;
  bool get isSingleAssetMode => widget.isSingleAssetMode;
  bool get isReview => widget.isReview;
  RequestType get type => widget.type;
  int get limit => widget.limit;
  final assets = ValueNotifier(<AssetEntity>[]);
  final selectedData = ValueNotifier(<AssetEntity>[]);
  final pathEntityList = <AssetPathEntity?, Uint8List?>{};

  @override
  void initState() {
    Future<void>.delayed(routeDuration).then((_) async {
      await getAssetPathList();
      await getAssetList();
    });
    super.initState();
  }

  Future<void> getAssetPathList() async {
    final FilterOptionGroup options = FilterOptionGroup()
      ..setOption(
        AssetType.audio,
        const FilterOption(needTitle: true),
      )
      ..setOption(
        AssetType.image,
        const FilterOption(
          needTitle: true,
          sizeConstraint: SizeConstraint(ignoreSize: true),
        ),
      );
    if (filterOptions != null) {
      options.merge(filterOptions!);
    }

    final _list = await PhotoManager.getAssetPathList(
      type: type,
      filterOption: options,
    );
    for (var pathEntity in _list) {
      pathEntityList[pathEntity] = null;
      if (type != RequestType.audio) {
        getFirstThumbFromPathEntity(pathEntity).then((Uint8List? data) {
          pathEntityList[pathEntity] = data;
        });
      }
    }
    if (pathEntityList.isEmpty) {
      isLoading.value = false;
    }
  }

  Future<void> getAssetList() async {
    if (pathEntityList.isNotEmpty) {
      await getAssetsFromEntity(pathEntityList.keys.elementAt(0)!);
    } else {
      assets.value.clear();
    }
  }

  Future<void> getAssetsFromEntity(AssetPathEntity pathEntity) async {
    isSwitchingPath.value = false;
    currentPathEntity.value = pathEntity;
    final media = await currentPathEntity.value?.assetList ?? [];
    if (maxDuration != null) {
      final items = media
          .where((e) =>
              e.type != AssetType.video ||
              (e.type == AssetType.video &&
                  e.duration <= maxDuration!.inMilliseconds))
          .toList();
      assets.value = items;
    } else {
      assets.value = media;
    }
    isLoading.value = false;
  }

  Future<Uint8List?> getFirstThumbFromPathEntity(pathEntity) async {
    final AssetEntity asset = (await pathEntity.getAssetListRange(
      start: 0,
      end: 1,
    ))
        .elementAt(0);
    final assetData = await asset.thumbDataWithSize(80, 80);
    return assetData;
  }

  void togglePathEntity() {
    isSwitchingPath.value = !isSwitchingPath.value;
  }

  void onSelectItem(AssetEntity asset) {
    if (isSingleAssetMode) {
      selectedData.value = List.from([asset]);
    } else {
      if (selectedData.value.contains(asset)) {
        selectedData.value =
            selectedData.value.where((e) => e != asset).toList();
      } else {
        if (selectedData.value.length < widget.limit) {
          selectedData.value = [...selectedData.value, asset];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (_, bool val, Widget? child) {
              return val
                  ? const Center(child: CircularProgressIndicator())
                  : RepaintBoundary(child: _listAsset());
            },
          ),
          _pathEntityListBackdrop(),
          PathEntityList(
            isAppleOS: isAppleOS,
            switchingPathCurve: switchingPathCurve,
            switchingPathDuration: switchingPathDuration,
            currentPathEntity: currentPathEntity,
            isSwitchingPath: isSwitchingPath,
            pathEntityList: pathEntityList,
            type: type,
            onTap: (val) {
              getAssetsFromEntity(val);
            },
          )
        ],
      ),
    );
  }

  Widget _listAsset() {
    return ValueListenableBuilder(
      valueListenable: assets,
      builder: (_, List<AssetEntity> items, Widget? child) {
        return GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.gridCount,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemBuilder: (_, int index) {
            return _assetGridItemBuilder(index, items[index]);
          },
        );
      },
    );
  }

  Widget _assetGridItemBuilder(int index, AssetEntity asset) {
    if (index == 0 && leadingBuilder != null) {
      return leadingBuilder!(context);
    }
    if (leadingBuilder != null) {
      index = index - 1;
    }
    return ValueListenableBuilder(
      valueListenable: selectedData,
      builder: (_, List<AssetEntity> items, Widget? child) {
        return Hero(
          tag: asset.id,
          child: Thumbnail(
            gridCount: context.gridCount,
            isSingleAssetMode: isSingleAssetMode,
            selectText: (items.indexOf(asset) + 1).toString(),
            assetEntity: asset,
            selected: items.contains(asset),
            onTap: onSelectItem,
            onView: isReview
                ? (AssetEntity assetEntity) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MediaBuilderPreviewBuillder(
                          assets: assets.value,
                          index: index,
                        ),
                      ),
                    );
                  }
                : onSelectItem,
          ),
        );
      },
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: widget.appBarColor ?? Colors.black,
      leading: const CloseButton(color: Colors.white),
      title: PathEntitySelector(
        currentPathEntity: currentPathEntity,
        isSwitchingPath: isSwitchingPath,
        togglePathEntity: togglePathEntity,
      ),
      actions: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _confirmButton(),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _pathEntityListBackdrop() {
    return ValueListenableBuilder(
      valueListenable: isSwitchingPath,
      builder: (_, bool val, Widget? child) {
        return IgnorePointer(
          ignoring: !val,
          child: GestureDetector(
            onTap: togglePathEntity,
            child: AnimatedOpacity(
              duration: switchingPathDuration,
              opacity: val ? 1.0 : 0.0,
              child: Container(color: Colors.black.withOpacity(0.75)),
            ),
          ),
        );
      },
    );
  }

  Widget _confirmButton() {
    return ValueListenableBuilder(
      valueListenable: selectedData,
      builder: (_, List<AssetEntity> items, __) {
        return MaterialButton(
          elevation: 0.0,
          height: 32,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          color: isSelectedNotEmpty ? context.primary : Colors.grey[800],
          child: Text(
            isSelectedNotEmpty && !isSingleAssetMode
                ? 'Select'
                    '(${items.length}/$limit)'
                : 'Select',
            style: TextStyle(
              color: isSelectedNotEmpty ? Colors.white : Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          onPressed: () {
            if (isSelectedNotEmpty) {
              Navigator.of(context).pop(items);
            }
          },
        );
      },
    );
  }
}
