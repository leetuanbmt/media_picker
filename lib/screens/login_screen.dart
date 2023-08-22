import '../core/config.dart';
import '../core/models/theme_color_bloc.dart';
import '../riverpod.dart';

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
      body: Column(
        children: [
          ...List.generate(ThemeColor.themeColorList.length, (index) {
            return ListTile(
              title: Text(ThemeColor.themeColorList[index].colorName),
              onTap: () {
                print(colorTheme);
                ref
                    .read(selectedThemeColor.notifier)
                    .selectThemeColor(ThemeColor.themeColorList[index].id);
              },
            );
          }),
        ],
      ),
    );
  }
}
