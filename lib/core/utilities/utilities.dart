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
}
