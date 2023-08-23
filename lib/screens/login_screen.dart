import '../core/config.dart';
import '../widgets/commons/theme_picker.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            ThemeColorPicker.showBottomSheet(context);
          },
          child: Text(
            'Login Screen',
            style: TextStyle(
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
