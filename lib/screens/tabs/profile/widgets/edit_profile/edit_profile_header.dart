import '../../../../../core/config.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              height: 56.h,
              color: const Color(0xffAFDEDC),
            ),
            Container(
              height: 56.h,
              color: Colors.white,
            ),
          ],
        ),
        Center(
          child: CircleAvatar(
            radius: 44.r,
            backgroundColor: AppTheme.lightGray,
            child: Icon(
              Icons.camera_alt,
              color: AppTheme.icon,
              size: 30.sp,
            ),
          ),
        ),
      ],
    );
  }
}
