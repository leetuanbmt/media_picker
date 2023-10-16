import 'package:flutter/cupertino.dart';

import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/my_page_provider.dart';
import 'my_page_bottom_sheet.dart';

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

class UserStatus extends StatelessWidget {
  const UserStatus({
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

    return IconButton(
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (ctx) {
            return CupertinoActionSheet(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      constraints: BoxConstraints(
                        maxHeight: context.screenHeight * 0.8,
                      ),
                      builder: (context) {
                        return const ReportUserBottomSheet();
                      },
                    );
                  },
                  child: Text(
                    context.tr(LocaleKeys.reportUser),
                    style: style,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ref.read(myPageProvider).blockUser();
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
