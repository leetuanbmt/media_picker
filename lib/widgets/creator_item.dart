import '../core/config.dart';
import '../core/models/creator/creator_model.dart';
import 'commons/button_custom.dart';
import 'commons/cache_image.dart';

class CreatorItem extends StatelessWidget {
  const CreatorItem({super.key, required this.creator, this.onPressed});
  final CreatorModel creator;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: CacheImage(
        image: creator.avatar,
        radius: 100.r,
        dimension: 50.w,
      ),
      title: Text(
        creator.name,
        style: context.titleMedium?.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: ButtonCustom(
        context.tr(LocaleKeys.follow),
        height: 33.h,
        onPressed: onPressed,
      ),
    );
  }
}
