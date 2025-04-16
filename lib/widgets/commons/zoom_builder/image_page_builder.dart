part of 'media_builder_preview.dart';

class ImagePageBuilder extends StatelessWidget {
  const ImagePageBuilder({
    super.key,
    this.asset,
    this.previewThumbSize,
    this.updateAnimation,
    this.url,
    this.tag,
  }) : assert(asset == null || url == null, 'please exit asset or ur');
  final Function(ExtendedImageGestureState)? updateAnimation;
  final AssetEntity? asset;
  final String? url, tag;
  final List<int>? previewThumbSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: RepaintBoundary(
        child: ExtendedImage(
          image: (asset != null
                  ? AssetEntityImageProvider(
                      asset!,
                      isOriginal: previewThumbSize == null,
                    )
                  : ExtendedNetworkImageProvider(url!, cache: true))
              as ImageProvider,
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: (ExtendedImageState state) {
            return GestureConfig(
              initialScale: 1.0,
              minScale: 1.0,
              maxScale: 3.0,
              animationMinScale: 0.6,
              animationMaxScale: 4.0,
              cacheGesture: false,
              inPageView: true,
            );
          },
          onDoubleTap: updateAnimation,
          loadStateChanged: (ExtendedImageState state) {
            Widget loader;
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                loader = const _LoadingIndicator();
                break;
              case LoadState.completed:
                loader = FadeImageBuilder(child: state.completedWidget);
                break;
              case LoadState.failed:
                loader = failedItemBuilder(context);
                break;
            }
            return loader;
          },
        ),
      ),
    );
  }

  Widget failedItemBuilder(BuildContext context) {
    return const Center(
      child: Text(
        'Not load image',
        textAlign: TextAlign.center,
      ),
    );
  }
}
