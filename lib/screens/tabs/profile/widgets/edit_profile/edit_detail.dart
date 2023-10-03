import '../../../../../core/config.dart';
import '../../../../../core/models/models.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/commons/theme_picker.dart';
import 'edit_item.dart';

class EditProfileDetail extends StatelessWidget {
  const EditProfileDetail({super.key, this.user});
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    const borderBio = OutlineInputBorder(
      borderSide: BorderSide(color: AppTheme.textiked),
    );
    return Column(
      children: [
        EditItem(
          title: 'ユーザー名',
          textContent: user?.name ?? '',
        ),
        EditItem(
          title: '年齢',
          content: "公開"
              .richText
              .textStyle(context.bodyMedium)
              .color(AppTheme.primaryColor)
              .end
              .withTextSpanChildren([
            " ${user?.old ?? ''}".textSpan.black.make(),
          ]).make(),
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
          onTap: () {
            ThemePicker.show(context);
          },
        ),
        const EditItem(
          title: 'カテゴリ',
          textContent: 'お笑い,美容',
        ),
        EditItem(
          title: '外部リンク',
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
          isLastItem: true,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '自己紹介文',
                style: context.bodyMedium?.copyWith(
                  color: AppTheme.fontGrayLead,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 11.h),
              TextFormField(
                minLines: 2,
                maxLines: 5,
                initialValue: user?.bio ?? '',
                decoration: const InputDecoration(
                  focusedBorder: borderBio,
                  enabledBorder: borderBio,
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
