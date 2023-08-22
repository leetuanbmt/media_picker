library dialogs;

import '../core/config.dart';

class AppDialog {
  AppDialog._();

  static void showAppBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (context) {
        return child;
      },
    );
  }
}
