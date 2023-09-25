import '../../../../../core/config.dart';
import '../../../../../core/models/models.dart';
import '../../../../../widgets/commons/cache_image.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({super.key, this.user});
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              height: 56.h,
              color: context.primaryColor.withOpacity(.2),
            ),
            Container(
              height: 56.h,
              color: Colors.white,
            ),
          ],
        ),
        Center(
          child: CacheImage(
            image: user?.avatar,
            radius: 100.r,
            dimension: 88.w,
          ),
        ),
      ],
    );
  }
}
