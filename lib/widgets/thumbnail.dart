part of media_picker;

class Thumbnail extends StatelessWidget {
  const Thumbnail({
    Key? key,
    required this.assetEntity,
    required this.onTap,
    this.onView,
    this.selected = false,
    this.isSingleAssetMode = false,
    this.selectText = '',
    this.gridCount = 4,
  }) : super(key: key);
  final AssetEntity assetEntity;
  final Function(AssetEntity) onTap;
  final Function(AssetEntity)? onView;
  final bool selected;
  final bool isSingleAssetMode;
  final String selectText;
  final int gridCount;

  void onReview() {
    onView?.call(assetEntity);
  }

  @override
  Widget build(BuildContext context) {
    Widget builder;
    switch (assetEntity.type) {
      case AssetType.audio:
        builder = _AudioItemBuilder(
          asset: assetEntity,
          selected: selected,
          onReview: onReview,
        );
        break;
      case AssetType.image:
      case AssetType.video:
        builder = _ImageAndVideoBuilder(
          asset: assetEntity,
          gridCount: gridCount,
          onReview: onReview,
          selected: selected,
        );
        break;
      case AssetType.other:
        builder = const SizedBox.shrink();
        break;
    }
    return Stack(
      children: <Widget>[
        builder,
        _SelectIndicator(
          selected: selected,
          onTap: () {
            onTap(assetEntity);
          },
          isSingleAssetMode: isSingleAssetMode,
          gridCount: gridCount,
          selectText: selectText,
        ),
      ],
    );
  }
}

class _AudioItemBuilder extends StatelessWidget {
  const _AudioItemBuilder({
    Key? key,
    required this.asset,
    required this.selected,
    required this.onReview,
  }) : super(key: key);
  final AssetEntity asset;
  final bool selected;
  final VoidCallback onReview;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: <Color>[
                  Theme.of(context).dividerColor,
                  Colors.transparent
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 30.0),
              child: Text(
                asset.title ?? '',
                style: const TextStyle(fontSize: 16.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const Center(child: Icon(Icons.audiotrack)),
        _SelectedBackdrop(
          selected: selected,
          onReview: onReview,
        ),
        Align(
          alignment: AlignmentDirectional.bottomStart,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.bottomCenter,
                end: AlignmentDirectional.topCenter,
                colors: <Color>[
                  Theme.of(context).dividerColor,
                  Colors.transparent
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                MediaPicker.formatDuration(Duration(seconds: asset.duration)),
                style: const TextStyle(fontSize: 16.0),
                strutStyle:
                    const StrutStyle(forceStrutHeight: true, height: 1.6),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ImageAndVideoBuilder extends StatelessWidget {
  const _ImageAndVideoBuilder({
    Key? key,
    required this.asset,
    required this.gridCount,
    required this.onReview,
    required this.selected,
  }) : super(key: key);
  final AssetEntity asset;
  final int gridCount;
  final VoidCallback onReview;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width / gridCount;
    final double scale = math.min(1, size / 150);
    final imageProvider = AssetEntityImageProvider(
      asset,
      isOriginal: false,
      thumbSize: Size(size / scale, size / scale),
    );
    SpecialImageType? type;
    if (imageProvider.imageFileType == ImageFileType.gif) {
      type = SpecialImageType.gif;
    } else if (imageProvider.imageFileType == ImageFileType.heic) {
      type = SpecialImageType.heic;
    }
    return Stack(
      children: [
        Positioned.fill(
          child: ExtendedImage(
              image: imageProvider,
              fit: BoxFit.cover,
              loadStateChanged: (ExtendedImageState state) {
                Widget loader = const SizedBox.shrink();
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    loader = const ColoredBox(color: Color(0x10ffffff));
                    break;
                  case LoadState.completed:
                    loader = RepaintBoundary(child: state.completedWidget);
                    break;
                  case LoadState.failed:
                    loader = const Center(
                      child: Text(
                        "File error",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    );
                    break;
                }
                return loader;
              }),
        ),
        _SelectedBackdrop(selected: selected, onReview: onReview),
        if (type == SpecialImageType.gif) const _GifIndicator(),
        if (asset.type == AssetType.video) _VideoIndicator(asset: asset),
      ],
    );
  }
}

class _SelectedBackdrop extends StatelessWidget {
  const _SelectedBackdrop({
    Key? key,
    required this.selected,
    required this.onReview,
  }) : super(key: key);
  final bool selected;
  final VoidCallback onReview;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        child: AnimatedContainer(
          duration: switchingPathDuration,
          color: selected
              ? Colors.black.withOpacity(0.45)
              : Colors.black.withOpacity(0.1),
        ),
        onTap: onReview,
      ),
    );
  }
}

class _SelectIndicator extends StatelessWidget {
  const _SelectIndicator({
    Key? key,
    required this.selected,
    required this.onTap,
    required this.isSingleAssetMode,
    required this.gridCount,
    required this.selectText,
  }) : super(key: key);
  final bool selected;
  final VoidCallback onTap;
  final bool isSingleAssetMode;
  final int gridCount;
  final String selectText;

  @override
  Widget build(BuildContext context) {
    final double indicatorSize = context.width / gridCount / 4;
    return Positioned(
      top: 0.0,
      right: 0.0,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: indicatorSize,
          height: indicatorSize,
          margin: EdgeInsets.all(
            context.width / gridCount / (isAppleOS ? 12.0 : 15.0),
          ),
          child: AnimatedContainer(
            duration: switchingPathDuration,
            width: indicatorSize / (isAppleOS ? 1.25 : 1.5),
            height: indicatorSize / (isAppleOS ? 1.25 : 1.5),
            decoration: BoxDecoration(
              border: !selected
                  ? Border.all(color: Colors.white, width: 2.0)
                  : null,
              color: selected ? context.primary : null,
              shape: BoxShape.circle,
            ),
            child: AnimatedSwitcher(
              duration: switchingPathDuration,
              reverseDuration: switchingPathDuration,
              child: selected
                  ? isSingleAssetMode
                      ? const Icon(Icons.check, size: 18.0, color: Colors.white)
                      : Text(
                          selectText,
                          style: TextStyle(
                            color: selected ? Colors.white : null,
                            fontSize: isAppleOS ? 16.0 : 14.0,
                            fontWeight:
                                isAppleOS ? FontWeight.w600 : FontWeight.bold,
                          ),
                        )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoIndicator extends StatelessWidget {
  const _VideoIndicator({Key? key, required this.asset}) : super(key: key);
  final AssetEntity asset;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: Container(
        width: double.maxFinite,
        height: 26.0,
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.bottomCenter,
            end: AlignmentDirectional.topCenter,
            colors: <Color>[
              Theme.of(context).dividerColor,
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              CupertinoIcons.video_camera,
              size: 24.0,
              color: Colors.white,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                MediaPicker.formatDuration(
                  Duration(seconds: asset.duration),
                ),
                style: const TextStyle(color: Colors.white),
                strutStyle: const StrutStyle(
                  forceStrutHeight: true,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GifIndicator extends StatelessWidget {
  const _GifIndicator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: Container(
        width: double.maxFinite,
        height: 26.0,
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.bottomCenter,
            end: AlignmentDirectional.topCenter,
            colors: <Color>[theme.dividerColor, Colors.transparent],
          ),
        ),
        child: Align(
          alignment: const FractionalOffset(0.1, 0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 2.0,
              vertical: 2.0,
            ),
            decoration: !isAppleOS
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    color: theme.iconTheme.color!.withOpacity(0.75),
                  )
                : null,
            child: Text(
              'GIF',
              style: TextStyle(
                color: isAppleOS
                    ? theme.textTheme.bodyText2!.color
                    : theme.primaryColor,
                fontSize: isAppleOS ? 14.0 : 12.0,
                fontWeight: isAppleOS ? FontWeight.w500 : FontWeight.normal,
              ),
              strutStyle: const StrutStyle(
                forceStrutHeight: true,
                height: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
