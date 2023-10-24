import 'package:flutter_svg/svg.dart';

import '../../../../../core/config.dart';
import '../../../../../core/models/models.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/auth/auth_notify.dart';
import '../../../../../routes/app_routes.gr.dart';
import '../../my_stories.dart';
import 'card_profile.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({super.key, this.userType});
  final UserType? userType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (userType == UserType.fan) ...[
          _ProfileItem(
            title: context.tr(LocaleKeys.checkPoints),
            assetIcon: Assets.iconsPointOutline.path,
            onTap: () {
              context.navigator(const PointConfirmRoute());
            },
          ),
          _ProfileItem(
            title: context.tr(LocaleKeys.usageGuide),
            assetIcon: Assets.iconsUsageGuideOutline.path,
            onTap: () {},
          ),
          _ProfileItem(
            title: context.tr(LocaleKeys.notificationSettings),
            assetIcon: Assets.iconsNotifyOutline.path,
            onTap: () {},
          ),
          _ProfileItem(
            title: context.tr(LocaleKeys.becomeCreator),
            assetIcon: Assets.iconsRefreshOutline.path,
            onTap: () {},
          ),
        ] else ...[
          _ProfileItem(
            title: context.tr(LocaleKeys.checkPoints),
            assetIcon: Assets.iconsIcPoint.path,
            onTap: () {
              context.navigator(const PointConfirmRoute());
            },
          ),
          _ProfileItem(
            title: context.tr(LocaleKeys.paymentSettings),
            assetIcon: Assets.iconsIcCreditCard1.path,
            onTap: () {},
          ),
          _ProfileItem(
            title: context.tr(LocaleKeys.accountSettings),
            assetIcon: Assets.iconsIcBalance.path,
            onTap: () {},
          ),
          _ProfileItem(
            title: context.tr(LocaleKeys.faq),
            assetIcon: Assets.iconsIcQna.path,
            onTap: () {
              context.nextPage(const MyStoriesScreen());
            },
          ),
          _ProfileItem(
            title: context.tr(LocaleKeys.usageGuide),
            assetIcon: Assets.iconsIcCreditCard.path,
            onTap: () {
              context.navigator(const UsageGuideRoute());
            },
          ),
          _ProfileItem(
            title: context.tr(LocaleKeys.announcementDistribution),
            assetIcon: Assets.iconsIcComment.path,
            onTap: () {
              context.navigator(ChatRoute(chatId: '11111111'));
            },
          ),
          _ProfileItem(
            title: context.tr(LocaleKeys.notificationSettings),
            assetIcon: Assets.iconsIconNotifications.path,
            onTap: () {
              AutoTabsRouter.of(context).navigate(const NotificationRoute());
            },
          ),
        ],
        Consumer(
          builder: (context, ref, child) {
            return _ProfileItem(
              title: context.tr(LocaleKeys.logout),
              isNext: false,
              textColor: Colors.red,
              onTap: ref.read(authProvider.notifier).logout,
            );
          },
        ),
      ],
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({
    required this.title,
    this.assetIcon,
    this.onTap,
    this.isNext = true,
    this.textColor = const Color(0xff140F26),
  });
  final String title;
  final String? assetIcon;
  final VoidCallback? onTap;
  final bool isNext;
  final Color textColor;
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
        trailing: trailing,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
