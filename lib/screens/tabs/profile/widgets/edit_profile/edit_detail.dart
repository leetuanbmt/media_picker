import '../../../../../core/config.dart';
import '../../../../../core/models/models.dart';

import '../../../../../core/routes/app_routes.gr.dart';
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
          title: context.lang.username,
          textContent: user?.name ?? '',
        ),
        EditItem(
          title: context.lang.age,
          content: context.lang.release.richText
              .textStyle(context.bodyMedium)
              .color(context.primaryColor)
              .end
              .withTextSpanChildren([
            " ${user?.old ?? ''}".textSpan.black.make(),
          ]).make(),
        ),
        EditItem(
          title: context.lang.themeColor,
          content: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 26.h,
              width: 26.w,
              decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
          ),
          onTap: () {
            ThemePicker.show(context);
          },
        ),
        EditItem(
          title: context.lang.category,
          textContent: 'お笑い,美容',
          showTrailing: false,
        ),
        EditItem(
          title: context.lang.language,
          // textContent: context.tr(AppLanguage.currentLanguageValue),
          onTap: () {
            context.navigator(const LanguageRoute());
          },
        ),
        EditItem(
          title: context.lang.externLink,
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
                context.lang.selfIntroduction,
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
