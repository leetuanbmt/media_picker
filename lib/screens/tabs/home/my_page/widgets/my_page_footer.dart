import '../../../../../core/config.dart';
import '../../../../../core/models/user/user_model.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';
import '../../../../../widgets/commons/indicators/loading_manager.dart';
import 'my_page_bottom_sheet.dart';

class MyPageFooter extends StatelessWidget {
  const MyPageFooter({super.key, required this.creator});

  final UserModel creator;

  void showCoinSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: context.screenHeight * 0.8,
      ),
      builder: (context) {
        return const CoinBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = context.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    return Column(
      children: [
        Divider(
          color: AppTheme.primaryColor,
        ),
        SizedBox(
          height: 17.14.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: context.tr(LocaleKeys.keep),
                style: style.copyWith(
                  color: AppTheme.fontGrayLead,
                ),
                children: [
                  TextSpan(
                    text: ' 2000',
                    style: context.titleMedium!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
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
            final followed = ref.watch(userCheckFollow);
            return followed.when(
              data: (result) {
                return result.following!.contains(creator.id)
                    ? ButtonCustom(
                        context.tr(LocaleKeys.sendPoints),
                        height: 44.h,
                        width: 327.w,
                        fontSize: 15.sp,
                        onPressed: () {
                          showCoinSheet(context);
                        },
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonCustom(
                              context.tr(LocaleKeys.sendPoints),
                              height: 44.h,
                              width: 208.w,
                              fontSize: 15.sp,
                              onPressed: () {},
                            ),
                            ButtonCustom(
                              '+ ${context.tr(LocaleKeys.follow)}',
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
              error: ((error, stackTrace) => const SizedBox()),
              loading: () => const TurnLoading(),
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
