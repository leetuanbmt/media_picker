import 'dart:async';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:toast/toast.dart';

import '../../core/config.dart';
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
  StreamSubscription? subscription;
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    subscription = controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    controller?.dispose();
    ToastView.dismiss();
    super.dispose();
  }

  void onPermissionSet(QRViewController ctrl, bool isPermission) {
    if (!isPermission) {
      Toast.show('No Permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      backgroundColor: AppTheme.fontBoldLight,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('QRコード'),
        leading: const BackButton(),
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
                onPermissionSet: onPermissionSet,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
