import '../../core/config.dart';
import '../../widgets/commons/button_custom.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('Home'),
      ),
      body: Center(
        child: ButtonCustom(
          'Home Screen',
          onPressed: () {},
        ),
      ),
    );
  }
}
