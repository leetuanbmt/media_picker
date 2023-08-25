import '../../core/config.dart';
import '../widgets/commons/app_bar_custom.dart';
import '../widgets/search_app_bar.dart';

@RoutePage()
class SearchCreatorScreen extends StatelessWidget {
  const SearchCreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCustom(
        searchAppBar: SearchAppBar(),
      ),
      body: Center(
        child: Text(
          'Search Screen',
        ),
      ),
    );
  }
}
