import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
import 'edit_item.dart';

class EditProfileDetail extends StatelessWidget {
  const EditProfileDetail({
    super.key,
    required this.focusNode,
  });

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EditItem(
          title: 'ユーザー名',
          textContent: 'Kasumi Arimura',
        ),
        EditItem(
          title: '年齢',
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '公開',
                style: context.labelMedium?.copyWith(
                  fontSize: 14.sp,
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '22',
                style: context.labelMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        EditItem(
          title: 'ユーザー名',
          content: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 26.h,
              width: 26.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
          ),
        ),
        const EditItem(
          title: 'カテゴリ',
          textContent: 'お笑い,美容',
        ),
        EditItem(
          title: '年齢',
          content: Row(
            children: [
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Assets.iconsIcTwitter.svg(),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        'ti_k42',
                        style: context.labelMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Assets.iconsIcFacebook.svg(),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        'facebook.com',
                        style: context.labelMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        EditItem(
          showTrailing: false,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('自己紹介文'),
              SizedBox(height: 11.h),
              TextFormField(
                focusNode: focusNode,
                maxLines: 2,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: AppTheme.textiked,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: AppTheme.textiked,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ],
    );
  }
}
