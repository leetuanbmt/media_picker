import '../../core/config.dart';

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
        child: Text(
          'Home Screen',
          style: TextStyle(
            color: AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}
