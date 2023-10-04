import 'dart:ui';

import '../../core/config.dart';
import '../../providers/global_provider.dart';
import '../../widgets/commons/indicators/loading_manager.dart';

class IncomingWrapperScreen extends HookConsumerWidget {
  const IncomingWrapperScreen(this.child, {super.key});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        Consumer(
          builder: (context, ref, child) {
            return ref.watch(loadingProvider)
                ? ColoredBox(
                    color: Colors.black.withOpacity(0.5),
                    child: const TurnLoading(),
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }
}

class BlurWidget extends HookWidget {
  const BlurWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final state = useAppLifecycleState();
    final visibility = useState(0);
    useEffect(
      () {
        if (state == AppLifecycleState.resumed) {
          visibility.value = 0;
        } else {
          visibility.value = 1;
        }
        return null;
      },
      [state],
    );
    return AnimatedBuilder(
      animation: visibility,
      builder: (_, __) {
        return Visibility(
          visible: visibility.value != 0,
          child: _Blur(blur: 20, opacity: 0.5 * visibility.value),
        );
      },
    );
  }
}

class _Blur extends StatelessWidget {
  const _Blur({required this.blur, required this.opacity});
  final double blur, opacity;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(color: Colors.black.withOpacity(opacity)),
      ),
    );
  }
}
