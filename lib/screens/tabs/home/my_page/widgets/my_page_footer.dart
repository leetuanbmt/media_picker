import '../../../../../core/config.dart';
import '../../../../../core/models/user/user_model.dart';
import '../../../../../core/providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';
import 'my_page_bottom_sheet.dart';
import 'my_page_dialog.dart';

class MyPageFooter extends StatelessWidget {
  const MyPageFooter({super.key, required this.creator});

  final UserModel creator;

  void showCoinSheet(BuildContext context, WidgetRef ref) {
    MyPageBottomSheet().showBottomSheet(context, const SelectCoinBottomSheet(),
        () {
      final isSendPoint = ref.read(myPageProvider).isShowTimeRemaining;

      if (isSendPoint) {
        Future.delayed(const Duration(seconds: 10), () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const AutoDialog();
            },
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    return Column(
      children: [
        Divider(color: context.primaryColor),
        SizedBox(
          height: 17.14.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: context.lang.keep,
                style: style.copyWith(
                  color: AppTheme.fontGrayLead,
                ),
                children: [
                  TextSpan(
                    text: ' 2000',
                    style: context.titleMedium!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: context.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: 'pt',
                    style: style.copyWith(
                      color: AppTheme.fontGrayLead,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 7.h,
        ),
        Consumer(
          builder: (context, ref, child) {
            final isFollowing = ref.watch(
              myPageProvider
                  .select((value) => value.checkFollowUser(creator.id)),
            );

            return isFollowing
                ? ButtonCustom(
                    context.lang.sendPoints,
                    height: 44.h,
                    width: 327.w,
                    fontSize: 15.sp,
                    onPressed: () {
                      showCoinSheet(context, ref);
                    },
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonCustom(
                          context.lang.sendPoints,
                          height: 44.h,
                          width: 208.w,
                          fontSize: 15.sp,
                          onPressed: () {},
                        ),
                        ButtonCustom(
                          '+ ${context.lang.follow}',
                          onPressed: () {
                            ref.read(myPageProvider).followUser(creator.id);
                          },
                          type: ButtonType.outline,
                          height: 44.h,
                          width: 148.w,
                          fontSize: 15.sp,
                          borderWidth: 2.r,
                        ),
                      ],
                    ),
                  );
          },
        ),
        SizedBox(
          height: 20.21.h,
        ),
      ],
    );
  }
}

class DeviceControlling extends StatelessWidget {
  const DeviceControlling({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(0),
          child: Divider(
            color: AppTheme.purple,
            thickness: 1,
            height: 0,
            indent: 0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 6.w),
          child: Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  MyPageBottomSheet().showBottomSheet(
                    context,
                    const ConfirmFinishBottomSheet(),
                    null,
                  );
                },
                icon: Icon(
                  Icons.cancel_rounded,
                  size: 24.r,
                ),
                color: AppTheme.boxFont,
              );
            },
          ),
        ),
        Center(
          child: Text(
            '〇〇${context.lang.isControllingYourDevice}',
            style: context.bodySmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.fontBoldLight,
            ),
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 131.5.w),
          child: RichText(
            text: TextSpan(
              text: context.lang.remaining,
              style: context.labelLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.fontBoldLight,
              ),
              children: [
                TextSpan(
                  text: '5000',
                  style: context.headlineLarge!.copyWith(
                    color: AppTheme.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'pt',
                  style: context.labelLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.fontBoldLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
