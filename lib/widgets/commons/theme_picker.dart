import '../../core/config.dart';
import '../../core/utilities/theme_color.dart';
import '../dialogs.dart';

class ThemeColorPicker extends HookConsumerWidget {
  const ThemeColorPicker({super.key});
  static showBottomSheet(BuildContext context) {
    return AppDialog.showAppBottomSheet(context, const ThemeColorPicker());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = ref.watch(selectedThemeColor);
    return Container(
      height: context.screenHeight * 0.6,
      margin: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Icon(
              Icons.close_sharp,
              size: 30.sp,
              color: AppTheme.primaryColor,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h),
            child: Text(
              'テーマカラーの設定',
              style: TextStyle(fontSize: 24.sp),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 15.r,
              mainAxisSpacing: 15.r,
              children: List.generate(
                AppColor.supportColors.length,
                (index) {
                  return _ItemColorBuilder(
                    onTap: () {
                      ref.read(selectedThemeColor.notifier).selectThemeColor(
                            AppColor.supportColors[index],
                          );
                    },
                    color: AppColor.supportColors[index],
                    selectedColor: colorTheme == AppColor.supportColors[index],
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(appGlobalNotifier.notifier).setColor(colorTheme);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.appTheme.primaryColor,
              fixedSize: Size.fromWidth(context.screenWidth),
            ),
            child: const Text(
              '設定する',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
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
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      color: color,
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: onTap,
        child: SizedBox.square(
          dimension: 64.r,
          child: selectedColor
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                )
              : null,
        ),
      ),
    );
  }
}
