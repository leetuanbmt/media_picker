import '../../../../core/config.dart';
import '../../../../gen/assets.gen.dart';

class LoadingRegisterSuccess {
  factory LoadingRegisterSuccess() => instance;

  LoadingRegisterSuccess._();

  static final LoadingRegisterSuccess instance = LoadingRegisterSuccess._();

  bool showLoading = false;

  void show(BuildContext context) {
    if (showLoading) {
      return;
    }
    showLoading = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: const Center(child: LoadingRegister()),
      ),
    );
  }

  void hide(BuildContext context) {
    if (!showLoading) {
      return;
    }
    Navigator.pop(context);
    showLoading = false;
  }
}

class LoadingRegister extends HookWidget {
  const LoadingRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165.h,
      width: 342.97.w,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.all(
          Radius.circular(12.r),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 40.01.h,
          ),
          Text(
            '登録が完了しました！',
            style: context.bodyLarge!.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.blackBold,
            ),
          ),
          SizedBox(
            height: 21.31.h,
          ),
          Assets.iconsIconSuccess.svg(
            height: 37.33.h,
            width: 37.33.w,
          ),
        ],
      ),
    );
  }
}
