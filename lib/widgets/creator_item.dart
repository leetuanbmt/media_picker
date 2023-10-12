import '../core/config.dart';
import 'commons/button_custom.dart';
import 'commons/cache_image.dart';

class CreatorItem extends StatelessWidget {
  const CreatorItem({
    super.key,
    this.onPressed,
    required this.name,
    required this.avatar,
  });
  final String name, avatar;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: CacheImage(
        image: avatar,
        radius: 100.r,
        dimension: 50.w,
      ),
      title: Text(
        name,
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
