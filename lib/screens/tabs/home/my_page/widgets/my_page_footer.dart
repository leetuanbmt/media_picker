import '../../../../../core/config.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';

class MyPageFooter extends StatelessWidget {
  const MyPageFooter({super.key});

  @override
  Widget build(BuildContext context) {
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
                text: '保持 ',
                style: context.labelMedium!.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.fontGrayLead,
                ),
                children: [
                  TextSpan(
                    text: '2000',
                    style: context.titleMedium!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: 'pt',
                    style: context.labelMedium!.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
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
            return ref.watch(myPageProvider).isFollowed
                ? ButtonCustom(
                    'ポイントをおくる',
                    height: 44.h,
                    width: 327.w,
                    onPressed: () {},
                  )
                : Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      ButtonCustom(
                        'ポイントをおくる',
                        height: 44.h,
                        width: 208.w,
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      ButtonCustom(
                        '+ フォロー',
                        onPressed: () {
                          ref.watch(myPageProvider).followUser();
                        },
                        type: ButtonType.outline,
                        height: 44.h,
                        width: 148.w,
                      ),
                    ],
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
