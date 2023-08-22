import '../../core/config.dart';
import '../../core/utilities/preferences.dart';
import '../../core/utilities/theme_color.dart';

class ThemeColorPicker extends HookConsumerWidget {
  const ThemeColorPicker(this.context, {super.key});
  final BuildContext context;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = ref.watch(selectedThemeColor);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Icon(
              Icons.close_sharp,
              size: 30.0,
              color: AppTheme.primaryColor,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Text(
              'テーマカラーの設定',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          Wrap(
            children: [
              ...List.generate(
                AppColor.supportColors.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      ref.read(selectedThemeColor.notifier).selectThemeColor(
                            AppColor.supportColors[index].toHex(),
                          );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      width: 64.0,
                      height: 64.24,
                      decoration: BoxDecoration(
                        color: AppColor.supportColors[index],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: colorTheme == AppColor.supportColors[index].toHex()
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
          50.heightBox,
          Center(
            child: ElevatedButton(
              onPressed: () {
                Preferences.setString(
                  'themeColor',
                  colorTheme,
                );
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.appTheme.primaryColor,
                minimumSize: context.screenSize.width > 600
                    ? const Size(200.0, 50.0)
                    : Size(context.screenWidth, 50.0),
              ),
              child: const Text(
                '設定する',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
