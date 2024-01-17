import 'package:flutter/cupertino.dart';

import '../../../../../core/config.dart';
import '../../../../../providers/my_page_provider.dart';
import 'my_page_bottom_sheet.dart';

class MyPageLeading extends StatelessWidget {
  const MyPageLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 36.r,
      child: IconButton(
        onPressed: () {
          context.back();
        },
        icon: Assets.iconsIconBackArrow.svg(
          width: 36.w,
          height: 36.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class UserStatus extends StatelessWidget {
  const UserStatus({
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
            isOnline ? context.lang.online : context.lang.offline,
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

class MyPageAction extends StatelessWidget {
  const MyPageAction({
    required this.isOnline,
    super.key,
  });

  final bool isOnline;
  void showOptionsAction(BuildContext context, WidgetRef ref) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        final style = context.titleMedium!.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xffEB5757),
        );

        return CupertinoActionSheet(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                MyPageBottomSheet().showBottomSheet(
                  context,
                  const ReportUserBottomSheet(),
                  null,
                );
              },
              child: Text(
                context.lang.report,
                style: style,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(myPageProvider).blockUser();
              },
              child: Text(
                context.lang.block,
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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Consumer(
        builder: (context, ref, child) {
          final isBlocked =
              ref.watch(myPageProvider.select((value) => value.isBlocked));
          return IconButton(
            onPressed: () {
              if (isBlocked || !isOnline) return;
              showOptionsAction(context, ref);
            },
            icon: Icon(
              Icons.more_horiz_rounded,
              color: Colors.white,
              size: 30.sp,
            ),
          );
        },
      ),
    );
  }
}
