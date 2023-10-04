import '../../../core/config.dart';

class DialButton extends StatelessWidget {
  const DialButton({
    super.key,
    required this.icon,
    required this.color,
    this.onTap,
    this.iconColor = Colors.white,
  });

  final IconData icon;
  final Color color, iconColor;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(icon, color: iconColor, size: 30.r),
      ),
    );
  }
}
