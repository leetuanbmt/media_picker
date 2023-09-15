import 'package:cloud_firestore/cloud_firestore.dart';

import '../config.dart';

export 'language.dart';
export 'logger.dart';
export 'preferences.dart';

class AppUtils {
  AppUtils._();

  static void toast(BuildContext context, String? msg) {
    WidgetsBinding.instance.endOfFrame.then((value) {
      VxToast.show(
        context,
        msg: msg ?? '',
        bgColor: AppTheme.primaryColor,
        textColor: Colors.white,
      );
    });
  }

  static Timestamp? toJsonTime(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }

  static DateTime? fromJsonTime(Timestamp? timestamp) {
    return timestamp?.toDate();
  }
}
