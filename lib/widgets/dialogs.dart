library dialogs;

import '../core/config.dart';

class AppDialog {
  AppDialog._();

  static void showAppBottomSheet(
    BuildContext context, {
    required String title,
    required Widget child,
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
      constraints: BoxConstraints(
        maxHeight: context.screenHeight * 0.8,
      ),
      builder: (context) => DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(15.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final themeColor = ref.watch(selectedThemeColor);
                  return InkWell(
                    child: Icon(
                      Icons.close_sharp,
                      size: 30.sp,
                      color: themeColor,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25.h),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
