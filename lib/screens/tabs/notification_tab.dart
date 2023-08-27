import '../../core/config.dart';
import '../../routes/app_routes.gr.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('Notification'),
      ),
      body: Center(
        // child: Text(
        //   'Notification Screen',
        //   style: TextStyle(
        //     color: AppTheme.primaryColor,
        //   ),
        // ),
        child: TextButton(
          child: const Text('abc'),
          onPressed: () {
            AutoRouter.of(context).push(const LoginRoute());
          },
        ),
      ),
    );
  }
}
