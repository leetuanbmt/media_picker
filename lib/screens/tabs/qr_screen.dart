import '../../core/config.dart';

@RoutePage()
class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('QRコード'),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Text(
          'Qr Screen',
          style: TextStyle(
            color: AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}
