part of media_picker;

class PathEntitySelector extends StatelessWidget {
  const PathEntitySelector({
    Key? key,
    this.togglePathEntity,
    required this.currentPathEntity,
    required this.isSwitchingPath,
  }) : super(key: key);
  double get appBarItemHeight => 32.0;
  final VoidCallback? togglePathEntity;
  final ValueListenable<AssetPathEntity?> currentPathEntity;
  final ValueListenable<bool> isSwitchingPath;
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: GestureDetector(
        onTap: togglePathEntity,
        child: Container(
          height: appBarItemHeight,
          constraints: BoxConstraints(maxWidth: context.width * 0.5),
          padding: const EdgeInsets.only(left: 12.0, right: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: Colors.grey[800],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: ValueListenableBuilder(
                  valueListenable: currentPathEntity,
                  builder: (_, dynamic value, Widget? child) {
                    return Text(
                      value?.name ?? '',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: isSwitchingPath,
                    builder: (_, bool val, Widget? child) {
                      return Transform.rotate(
                        angle: val ? math.pi : 0.0,
                        alignment: Alignment.center,
                        child: child,
                      );
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
