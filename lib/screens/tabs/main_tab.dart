import '../../core/config.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('Main'),
      ),
      body: Center(
        child: Text(
          'Main Screen',
          style: TextStyle(
            color: AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}
