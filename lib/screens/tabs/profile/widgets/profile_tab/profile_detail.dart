import 'package:flutter_svg/svg.dart';

import '../../../../../core/config.dart';
import '../../../../../gen/assets.gen.dart';
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
        CardProfile(
          child: ListTile(
            title: Text(
              'ログアウト',
              style: context.labelSmall?.copyWith(
                fontSize: 14.sp,
                color: Colors.red,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({
    required this.title,
    required this.assetIcon,
    this.onTap,
  });
  final String title, assetIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CardProfile(
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(
          assetIcon,
          width: 24.w,
        ),
        title: Text(
          title,
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: AppTheme.icon,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
