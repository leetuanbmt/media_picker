part of '../chat_screen.dart';

class ChatImage extends StatelessWidget {
  const ChatImage(this.message, {super.key});
  final Message message;

  List<String> get images => message.images;

  List<AssetEntity> get assets => message.assets;

  int get total => assets.isEmpty ? images.length : assets.length;

// than more 4 images
  final aspectRatio = 4 / 3;

  // 2 images
  final aspectRatioTwo = 4 / 6;

  @override
  Widget build(BuildContext context) {
    return switch (total) {
      0 => Dimensions.empty,
      1 => _buildSingleImage(context),
      2 => _buildTwoImages(context),
      3 => _buildThreeImages(context),
      4 => _buildFourImages(context),
      _ => _buildFiveOrMoreImages(context),
    };
  }

  Widget _buildSingleImage(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.screenWidth * .8,
        maxHeight: context.screenWidth * .8,
      ),
      child: _aspectRatioImage(context: context, index: 0),
    );
  }

  SizedBox _spacer() => SizedBox.fromSize(size: const Size(2, 2));

  Widget _buildTwoImages(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.screenWidth,
        maxHeight: context.screenWidth,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: _aspectRatioImage(
              context: context,
              index: 0,
              ratio: aspectRatioTwo,
            ),
          ),
          _spacer(),
          Expanded(
            child: _aspectRatioImage(
              context: context,
              index: 1,
              ratio: aspectRatioTwo,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreeImages(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final width = constraints.maxWidth;

        final height = width * 1.2;

        final aspectRatio = width / height;

        const mainAxisSpacing = 2;

        final aspectRatio2 = width / (height - mainAxisSpacing);

        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.screenWidth),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: _aspectRatioImage(
                  context: context,
                  index: 0,
                  ratio: aspectRatio,
                ),
              ),
              _spacer(),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    _aspectRatioImage(
                      context: context,
                      index: 1,
                      ratio: aspectRatio2,
                    ),
                    _spacer(),
                    _aspectRatioImage(
                      context: context,
                      index: 2,
                      ratio: aspectRatio2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFourImages(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: context.screenWidth),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _aspectRatioImage(
                  context: context,
                  index: 0,
                  ratio: aspectRatio,
                ),
              ),
              _spacer(),
              Expanded(
                child: _aspectRatioImage(
                  context: context,
                  index: 1,
                  ratio: aspectRatio,
                ),
              ),
            ],
          ),
          _spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _aspectRatioImage(
                  context: context,
                  index: 2,
                  ratio: aspectRatio,
                ),
              ),
              _spacer(),
              Expanded(
                child: _aspectRatioImage(
                  context: context,
                  index: 3,
                  ratio: aspectRatio,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiveOrMoreImages(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: context.screenWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _aspectRatioImage(
                  context: context,
                  index: 0,
                  ratio: aspectRatio,
                ),
              ),
              _spacer(),
              Expanded(
                child: _aspectRatioImage(
                  context: context,
                  index: 1,
                  ratio: aspectRatio,
                ),
              ),
            ],
          ),
          _spacer(),
          Row(
            children: <Widget>[
              Expanded(
                child: _aspectRatioImage(
                  context: context,
                  index: 2,
                  ratio: aspectRatio,
                ),
              ),
              _spacer(),
              Expanded(
                child: _aspectRatioImage(
                  context: context,
                  index: 3,
                  ratio: aspectRatio,
                ),
              ),
              _spacer(),
              Expanded(
                child: _plusMorePictures(
                  valueCount: total - 5,
                  child: _aspectRatioImage(
                    context: context,
                    index: 4,
                    ratio: aspectRatio,
                  ),
                  context: context,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _plusMorePictures({
    required int valueCount,
    required Widget child,
    required BuildContext context,
  }) {
    if (valueCount <= 0) {
      return child;
    } else {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,
          InkWell(
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: Text(
                    '+$valueCount',
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),
            onTap: () {
              PreviewMedia.show(
                context,
                index: 4,
                assets: assets.isEmpty ? null : assets,
                files: assets.isNotEmpty
                    ? null
                    : images.map((e) => ZoomImageItem(path: e)).toList(),
              );
            },
          ),
        ],
      );
    }
  }

  Widget _aspectRatioImage({
    required BuildContext context,
    required int index,
    double? ratio,
  }) {
    final child = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: assets.isNotEmpty
          ? GestureDetector(
              child: Image(
                fit: BoxFit.cover,
                image: AssetEntityImageProvider(
                  assets.elementAt(index),
                  isOriginal: false,
                ),
              ),
              onTap: () {
                PreviewMedia.show(context, index: index, assets: assets);
              },
            )
          : CacheImage(
              image: images.elementAt(index),
              dimension: context.screenSize,
              onTap: (tag) {
                final list = images
                    .map((e) => ZoomImageItem(path: e, tag: tag))
                    .toList();
                PreviewMedia.show(context, index: index, files: list);
              },
            ),
    );
    if (ratio != null) {
      return AspectRatio(aspectRatio: ratio, child: child);
    } else {
      return child;
    }
  }
}
