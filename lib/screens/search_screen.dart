import '../../core/config.dart';
import '../widgets/search_app_bar.dart';

@RoutePage()
class SearchCreatorScreen extends StatelessWidget {
  const SearchCreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppTheme.primaryColor,
        title: const SearchAppBar(),
        titleSpacing: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: const Center(
        child: Text(
          'Search Screen',
        ),
      ),
    );
  }
}
