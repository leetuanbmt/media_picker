import '../../core/config.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('Search'),
      ),
      body: Center(
        child: Text(
          'Search Screen',
          style: TextStyle(
            color: AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}
