import '../../core/config.dart';
import '../dialogs.dart';

class ThemeColorPicker extends HookConsumerWidget {
  const ThemeColorPicker({super.key});
  static showBottomSheet(BuildContext context) {
    return AppDialog.showAppBottomSheet(
      context,
      title: 'テーマカラーの設定',
      child: const ThemeColorPicker(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = ref.watch(selectedThemeColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          crossAxisSpacing: 15.r,
          mainAxisSpacing: 15.r,
          children: AppTheme.supportColors
              .map(
                (e) => _ItemColorBuilder(
                  color: e,
                  selectedColor: colorTheme == e,
                  onTap: () {
                    ref.read(selectedThemeColor.notifier).selectThemeColor(e);
                  },
                ),
              )
              .toList(),
        ),
        HeightBox(10.h),
        ElevatedButton(
          onPressed: () {
            ref.read(appGlobalNotifier.notifier).setColor(colorTheme);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.appTheme.primaryColor,
            foregroundColor: Colors.white,
            fixedSize: Size(context.screenWidth, 48.h),
          ),
          child: const Text('設定する'),
        ),
      ],
    );
  }
}

class _ItemColorBuilder extends StatelessWidget {
  const _ItemColorBuilder({
    this.onTap,
    this.color,
    this.selectedColor = false,
  });

  final Color? color;
  final VoidCallback? onTap;
  final bool selectedColor;

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(15.0);
    return Material(
      borderRadius: border,
      color: color,
      child: InkWell(
        borderRadius: border,
        onTap: onTap,
        child: SizedBox.square(
          dimension: 60.r,
          child: selectedColor
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30.r,
                )
              : null,
        ),
      ),
    );
  }
}
