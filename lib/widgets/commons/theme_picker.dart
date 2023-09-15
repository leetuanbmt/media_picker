import '../../core/config.dart';
import '../../providers/global_provider.dart';
import '../dialogs.dart';
import 'button_custom.dart';

class ThemePicker extends HookWidget {
  const ThemePicker({super.key});
  static show(BuildContext context) {
    return AppDialog.showAppBottomSheet(
      context,
      title: 'テーマカラーの設定',
      child: const ThemePicker(),
      name: 'ThemePicker',
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = useState<Color>(AppTheme.defaultColor);
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
                  selectedColor: colorTheme.value == e,
                  onTap: () {
                    colorTheme.value = e;
                  },
                ),
              )
              .toList(),
        ),
        HeightBox(10.h),
        Consumer(
          builder: (context, ref, child) {
            return ButtonCustom(
              '設定する',
              height: 48.h,
              width: context.screenWidth,
              backgroundColor: colorTheme.value,
              onPressed: () {
                ref.read(appGlobalProvider.notifier).setColor(colorTheme.value);
                Navigator.of(context).pop();
              },
            );
          },
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
