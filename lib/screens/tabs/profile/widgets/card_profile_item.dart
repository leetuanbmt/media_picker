import '../../../../core/config.dart';

class CardProfileItem extends StatelessWidget {
  const CardProfileItem({
    super.key,
    required this.child,
    this.radius = 10,
  });

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
      child: child,
    );
  }
}
