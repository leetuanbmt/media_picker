library dialogs;

import '../core/config.dart';

class AppDialog {
  AppDialog._();

  static void showAppBottomSheet(
    BuildContext context,
    Widget child, {
    bool barrierDismissible = true,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      isScrollControlled: true,
      isDismissible: barrierDismissible,
      builder: (context) => child,
    );
  }
}
