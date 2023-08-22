import '../core/config.dart';
import '../core/utilities/preferences.dart';

@RoutePage()
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = ref.watch(selectedThemeColor);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appTheme.primaryColor,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'テーマカラーの設定',
              style: TextStyle(fontSize: 24.0),
            ),
            Wrap(
              children: [
                ...List.generate(
                  ThemeColor.themeColorList.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        ref
                            .read(selectedThemeColor.notifier)
                            .selectThemeColor(index + 1);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        width: 64.0,
                        height: 64.24,
                        decoration: BoxDecoration(
                          color: ThemeColor.themeColorList[index].colorValue,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: colorTheme == index + 1
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
                onPressed: () async {
                  await Preferences.setInt(
                    'themeColor',
                    colorTheme,
                  );
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
      ),
    );
  }
}
