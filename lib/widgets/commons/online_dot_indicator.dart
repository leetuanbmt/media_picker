import '../../core/config.dart';

class OnlineDotIndicator extends ConsumerWidget {
  const OnlineDotIndicator({super.key, required this.isOnline});
  final bool isOnline;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: 10,
        width: 10,
        margin: const EdgeInsets.only(right: 5, top: 5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isOnline ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
