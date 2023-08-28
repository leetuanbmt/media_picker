import 'package:flutter_svg/svg.dart';

import '../../../../core/config.dart';
import '../../../../gen/assets.gen.dart';
import 'card_profile_item.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardProfileItem(
          child: ListTile(
            leading: SvgPicture.asset(
              Assets.iconsIcPoint.path,
              width: 24.w,
            ),
            title: const Text(
              'ポイント確認',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: AppTheme.icon,
            ),
          ),
        ),
        CardProfileItem(
          child: ListTile(
            leading: SvgPicture.asset(
              Assets.iconsIcCreditCard1.path,
              width: 24.w,
            ),
            title: const Text(
              'お支払い設定',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: AppTheme.icon,
            ),
          ),
        ),
        CardProfileItem(
          child: ListTile(
            leading: SvgPicture.asset(
              Assets.iconsIcBalance.path,
              width: 24.w,
            ),
            title: const Text(
              '口座情報設定',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: AppTheme.icon,
            ),
          ),
        ),
        CardProfileItem(
          child: ListTile(
            leading: SvgPicture.asset(
              Assets.iconsIcQna.path,
              width: 24.w,
            ),
            title: const Text(
              'よくある質問',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: AppTheme.icon,
            ),
          ),
        ),
        CardProfileItem(
          child: ListTile(
            leading: SvgPicture.asset(
              Assets.iconsIcCreditCard.path,
              width: 24.w,
            ),
            title: const Text(
              '利用ガイド',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: AppTheme.icon,
            ),
          ),
        ),
        CardProfileItem(
          child: ListTile(
            leading: SvgPicture.asset(
              Assets.iconsIcComment.path,
              width: 24.w,
            ),
            title: const Text(
              '配信予定の告知',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: AppTheme.icon,
            ),
          ),
        ),
        CardProfileItem(
          child: ListTile(
            leading: SvgPicture.asset(
              Assets.iconsIconNotifications.path,
              width: 24.w,
            ),
            title: const Text(
              '通知設定',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: AppTheme.icon,
            ),
          ),
        ),
        CardProfileItem(
          child: ListTile(
            title: Text(
              'ログアウト',
              style: context.labelSmall?.copyWith(
                fontSize: 14.sp,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
