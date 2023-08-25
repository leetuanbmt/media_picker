import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../core/config.dart';
import '../../core/utilities/logger.dart';
import '../../widgets/custom_painter.dart';

@RoutePage()
class QRScreen extends StatefulWidget {
  const QRScreen({super.key});

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
      Logger.log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
      if (!p) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('no Permission')),
        );
      }
    }

    return Scaffold(
      backgroundColor: AppTheme.fontBoldLight,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('QRコード'),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Divider(
            height: 25.h,
            thickness: 25.h,
            color: Colors.white,
          ),
          SizedBox(height: 60.h),
          Text(
            '読み取り中...',
            style: context.titleMedium?.copyWith(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: context.screenWidth - 26.h,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 26.w, vertical: 35.h),
            decoration: const CustomDecoration(frameSFactor: .13),
            child: SizedBox.square(
              dimension: 260.h,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                onPermissionSet: (ctrl, p) => onPermissionSet(context, ctrl, p),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
