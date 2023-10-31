part of '../chat_screen.dart';

class ChatImage extends StatelessWidget {
  const ChatImage(this.message, {super.key});
  final Message message;

  List<String> get images => jsonDecode(message.message).cast<String>();

  @override
  Widget build(BuildContext context) {
    return switch (images.length) {
      0 => Dimensions.empty,
      1 => _buildSingleImage(context, images[0]),
      2 => _buildTwoImages(context),
      3 => _buildThreeImages(context),
      4 => _buildFourImages(context),
      _ => _buildFiveOrMoreImages(context),
    };
  }

  Widget _buildSingleImage(BuildContext context, String image) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 200,
        maxWidth: 200,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CacheImage(
          image: image,
          dimension: context.screenSize,
          onTap: (_) {
            ZoomMedia.show(
              context,
              files: [ZoomImageItem(path: image)],
            );
          },
        ),
      ),
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
          Expanded(child: _aspectRatioImage(images[0], 4 / 3, 0, context)),
          _spacer(),
          Expanded(child: _aspectRatioImage(images[1], 4 / 3, 1, context)),
        ],
      ),
    );
  }

  Widget _buildThreeImages(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: context.screenWidth),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: _aspectRatioImage(images[0], 4 / 3, 0, context),
          ),
          _spacer(),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                _aspectRatioImage(images[1], 4 / 3, 1, context),
                _spacer(),
                _aspectRatioImage(images[2], 4 / 3, 2, context),
              ],
            ),
          ),
        ],
      ),
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
                child: _aspectRatioImage(images[0], 4 / 3, 0, context),
              ),
              _spacer(),
              Expanded(
                child: _aspectRatioImage(images[1], 4 / 3, 1, context),
              ),
            ],
          ),
          _spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _aspectRatioImage(images[2], 4 / 3, 2, context),
              ),
              _spacer(),
              Expanded(
                child: _aspectRatioImage(images[3], 4 / 3, 3, context),
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
                child: _aspectRatioImage(images[0], 4 / 3, 0, context),
              ),
              _spacer(),
              Expanded(
                child: _aspectRatioImage(images[1], 4 / 3, 1, context),
              ),
            ],
          ),
          _spacer(),
          Row(
            children: <Widget>[
              Expanded(
                child: _aspectRatioImage(images[2], 4 / 3, 2, context),
              ),
              _spacer(),
              Expanded(
                child: _aspectRatioImage(images[3], 4 / 3, 3, context),
              ),
              _spacer(),
              Expanded(
                child: _plusMorePictures(
                  valueCount: images.length - 5,
                  child: _aspectRatioImage(images[4], 4 / 3, 4, context),
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
              aspectRatio: 1,
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: Text(
                    "+$valueCount",
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),
            onTap: () {},
          ),
        ],
      );
    }
  }

  Widget _aspectRatioImage(
    String image,
    double ratio,
    int index,
    BuildContext context,
  ) {
    return AspectRatio(
      aspectRatio: ratio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CacheImage(
          image: image,
          dimension: context.screenSize,
          onTap: (tag) {
            ZoomMedia.show(
              context,
              index: index,
              files:
                  images.map((e) => ZoomImageItem(path: e, tag: tag)).toList(),
            );
          },
        ),
      ),
    );
  }
}
