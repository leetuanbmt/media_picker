import 'package:flutter/cupertino.dart';

import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/my_page_provider.dart';
import '../../../../../widgets/commons/button_custom.dart';
import '../../../../../widgets/dialogs.dart';

class MyPageLeading extends StatelessWidget {
  const MyPageLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 32.h,
      child: InkWell(
        onTap: () {
          context.back();
        },
        child: Assets.iconsIconBackArrow.svg(
          width: 8.w,
          height: 15.11.h,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}

class UserOnline extends StatelessWidget {
  const UserOnline({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31.63.h,
      width: 106.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30.r),
        ),
        color: AppTheme.pink,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.iconsIconOnline.svg(
            height: 16.81.h,
            width: 15.w,
          ),
          SizedBox(
            width: 6.w,
          ),
          Text(
            'オンライン',
            style: context.labelMedium!.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class MyPageAction extends ConsumerWidget {
  const MyPageAction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = context.titleMedium!.copyWith(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xffEB5757),
    );

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3.r)),
      borderSide: BorderSide(
        width: 1.r,
        color: AppTheme.box,
      ),
    );
    return IconButton(
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (ctx) {
            return CupertinoActionSheet(
              title: Text(
                'ユーザーを報告する',
                style: style,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    AppDialog.showAppBottomSheet(
                      context,
                      title: 'ユーザーの報告',
                      child: Column(
                        children: [
                          SizedBox(
                            height: 110.h,
                            width: 343.w,
                            child: TextField(
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'ユーザーの違反行為などを報告',
                                hintStyle: context.titleSmall!.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w300,
                                  color: AppTheme.boxFont,
                                ),
                                enabledBorder: border,
                                focusedBorder: border,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          ButtonCustom(
                            '報告する',
                            height: 48.h,
                            width: 327.w,
                            onPressed: () {
                              Navigator.pop(context);
                              ref.read(myPageProvider).blockUser();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'ブロックする',
                    style: style.copyWith(
                      color: const Color(0xff007AFF),
                    ),
                  ),
                ),
              ],
              cancelButton: TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Cancel',
                  style: style.copyWith(
                    color: const Color(0xff007AFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.more_horiz,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
