import 'package:flutter_svg/svg.dart';

import '../../../../../core/config.dart';
import '../../../../../core/models/models.dart';
import '../../../../../hooks/configurations/use_package_info.dart';
import '../../../../../providers/auth/auth_notify.dart';
import '../../../../../routes/app_routes.gr.dart';
import 'card_profile.dart';

class ProfileDetail extends HookWidget {
  const ProfileDetail({super.key, this.userType});
  final UserType? userType;
  @override
  Widget build(BuildContext context) {
    final packageInfo = usePackageInfo();
    return Column(
      children: [
        if (userType == UserType.fan) ...[
          _ProfileItem(
            title: context.lang.checkPoints,
            assetIcon: Assets.iconsPointOutline.path,
            onTap: () {
              context.navigator(const PointConfirmRoute());
            },
          ),
          _ProfileItem(
            title: context.lang.usageGuide,
            assetIcon: Assets.iconsUsageGuideOutline.path,
            onTap: () {},
          ),
          _ProfileItem(
            title: context.lang.notificationSettings,
            assetIcon: Assets.iconsNotifyOutline.path,
            onTap: () {},
          ),
          _ProfileItem(
            title: context.lang.becomeCreator,
            assetIcon: Assets.iconsRefreshOutline.path,
            onTap: () {},
          ),
        ] else ...[
          _ProfileItem(
            title: context.lang.checkPoints,
            assetIcon: Assets.iconsIcPoint.path,
            onTap: () {
              context.navigator(const PointConfirmRoute());
            },
          ),
          _ProfileItem(
            title: context.lang.paymentSettings,
            assetIcon: Assets.iconsIcCreditCard1.path,
            onTap: () {},
          ),
          _ProfileItem(
            title: context.lang.accountSettings,
            assetIcon: Assets.iconsIcBalance.path,
            onTap: () {},
          ),
          _ProfileItem(
            title: context.lang.faq,
            assetIcon: Assets.iconsIcQna.path,
            onTap: () {
              context.navigator(const MyStoriesRoute());
            },
          ),
          _ProfileItem(
            title: context.lang.usageGuide,
            assetIcon: Assets.iconsIcCreditCard.path,
            onTap: () {
              context.navigator(const UsageGuideRoute());
            },
          ),
          _ProfileItem(
            title: context.lang.announcementDistribution,
            assetIcon: Assets.iconsIcComment.path,
            onTap: () {
              context.navigator(ChatRoute(chatId: '11111111'));
            },
          ),
          _ProfileItem(
            title: context.lang.notificationSettings,
            assetIcon: Assets.iconsIconNotifications.path,
            onTap: () {
              context.navigator(const NotificationRoute());
            },
          ),
        ],
        Consumer(
          builder: (context, ref, child) {
            return _ProfileItem(
              title: context.lang.logout,
              isNext: false,
              textColor: Colors.red,
              onTap: ref.read(authProvider.notifier).logout,
              trailingBuilder: (context) {
                return Text(
                  packageInfo.version,
                  style: TextStyle(
                    color: AppTheme.icon,
                    fontSize: 12.sp,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  sortItem(List<int> arr) {
    int len = arr.length;
    for (int i = 0; i < len - 1; i++) {
      if (arr[i] > arr[i + 1]) {
        int temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
      }
    }
  }

  void bubbleShort(List<int> list, int n) {
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (list[j] > list[j + 1]) {
          int temp = list[j];
          list[j] = list[j + 1];
          list[j + 1] = temp;
        }
      }
    }
  }

  void headSort(List<int> list, int n) {
    for (int i = n ~/ 2 - 1; i >= 0; i--) {
      heapify(list, n, i);
    }
    for (int i = n - 1; i >= 0; i--) {
      int temp = list[0];
      list[0] = list[i];
      list[i] = temp;
      heapify(list, i, 0);
    }
  }

  void heapify(List<int> list, int n, int i) {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;
    if (l < n && list[l] > list[largest]) {
      largest = l;
    }
    if (r < n && list[r] > list[largest]) {
      largest = r;
    }
    if (largest != i) {
      int swap = list[i];
      list[i] = list[largest];
      list[largest] = swap;
      heapify(list, n, largest);
    }
  }

  void selectionShort(List<int> list, int n) {
    for (int i = 0; i < n - 1; i++) {
      int minIndex = i;
      for (int j = i + 1; j < n; j++) {
        if (list[j] < list[minIndex]) {
          minIndex = j;
        }
      }
      int temp = list[minIndex];
      list[minIndex] = list[i];
      list[i] = temp;
    }
  }

  void insertShort(List<int> list, int n) {
    for (int i = 1; i < n; i++) {
      int key = list[i];
      int j = i - 1;
      while (j >= 0 && list[j] > key) {
        list[j + 1] = list[j];
        j = j - 1;
      }
      list[j + 1] = key;
    }
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({
    required this.title,
    this.assetIcon,
    this.onTap,
    this.isNext = true,
    this.textColor = const Color(0xff140F26),
    this.trailingBuilder,
  });
  final String title;
  final String? assetIcon;
  final VoidCallback? onTap;
  final bool isNext;
  final Color textColor;
  final WidgetBuilder? trailingBuilder;
  @override
  Widget build(BuildContext context) {
    Widget? leading, trailing;
    if (assetIcon != null) {
      leading = SvgPicture.asset(
        assetIcon!,
        width: 24.w,
      );
    }
    if (isNext) {
      trailing = const Icon(
        Icons.keyboard_arrow_right_outlined,
        color: AppTheme.icon,
      );
    }
    return CardProfile(
      child: ListTile(
        onTap: onTap,
        leading: leading,
        title: Text(
          title,
          style: TextStyle(color: textColor),
        ),
        trailing: trailingBuilder?.call(context) ?? trailing,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
