import '../../core/config.dart';
import '../../providers/firebase_provider.dart';

class OnlineDotIndicator extends ConsumerWidget {
  const OnlineDotIndicator({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(
      userChangeFirebase(uid)
          .select((value) => value.valueOrNull?.isOnline ?? false),
    );

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
