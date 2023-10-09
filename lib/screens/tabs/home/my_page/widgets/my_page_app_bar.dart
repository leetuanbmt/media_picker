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
    required this.isOnline,
  });

  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31.63.h,
      width: 106.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30.r),
        ),
        color: isOnline ? AppTheme.pink : AppTheme.icon,
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
            isOnline
                ? context.tr(LocaleKeys.online)
                : context.tr(LocaleKeys.offline),
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
  const MyPageAction(
    this.isOnline, {
    super.key,
  });

  final bool isOnline;

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
        isOnline
            ? showCupertinoModalPopup(
                context: context,
                builder: (ctx) {
                  return CupertinoActionSheet(
                    title: Text(
                      context.tr(LocaleKeys.reportUser),
                      style: style,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          AppDialog.showAppBottomSheet(
                            context,
                            title: context.tr(LocaleKeys.userReports),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 110.h,
                                  width: 343.w,
                                  child: TextField(
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      hintText: context.tr(
                                          LocaleKeys.reportViolationsByUser),
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
                                  context.tr(LocaleKeys.report),
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
                          context.tr(LocaleKeys.block),
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
              )
            : null;
      },
      icon: const Icon(
        Icons.more_horiz,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
