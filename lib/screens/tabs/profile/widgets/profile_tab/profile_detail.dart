import 'package:flutter_svg/svg.dart';

import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../providers/auth_provider.dart';
import '../../point_confirm.dart';
import '../../usage_guide.dart';
import 'card_profile.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileItem(
          title: 'ポイント確認',
          assetIcon: Assets.iconsIcPoint.path,
          onTap: () {
            context.nextPage(const PointConfirmScreen());
          },
        ),
        _ProfileItem(
          title: 'お支払い設定',
          assetIcon: Assets.iconsIcCreditCard1.path,
          onTap: () {},
        ),
        _ProfileItem(
          title: '口座情報設定',
          assetIcon: Assets.iconsIcBalance.path,
          onTap: () {},
        ),
        _ProfileItem(
          title: 'よくある質問',
          assetIcon: Assets.iconsIcQna.path,
          onTap: () {},
        ),
        _ProfileItem(
          title: '利用ガイド',
          assetIcon: Assets.iconsIcCreditCard.path,
          onTap: () {
            context.nextPage(const UsageGuideScreen());
          },
        ),
        _ProfileItem(
          title: '配信予定の告知',
          assetIcon: Assets.iconsIcComment.path,
          onTap: () {},
        ),
        _ProfileItem(
          title: '通知設定',
          assetIcon: Assets.iconsIconNotifications.path,
          onTap: () {},
        ),
        Consumer(
          builder: (context, ref, child) {
            return _ProfileItem(
              title: 'ログアウト',
              isNext: false,
              textColor: Colors.red,
              onTap: ref.read(authProvider).signOut,
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
    this.textColor,
  });
  final String title;
  final String? assetIcon;
  final VoidCallback? onTap;
  final bool isNext;
  final Color? textColor;
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
