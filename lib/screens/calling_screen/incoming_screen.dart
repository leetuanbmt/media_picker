import '../../core/config.dart';
import '../../providers/global_provider.dart';
import '../../widgets/commons/indicators/loading_manager.dart';

class IncomingWrapperScreen extends ConsumerWidget {
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

// class IncomingWidget extends ConsumerWidget {
//   const IncomingWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final incomingSDPOffer = ref.watch(
//       socketProvider.select((value) => value.incomingSDPOffer!),
//     );

//     return Scaffold(
//       body: SizedBox(
//         width: double.infinity,
//         height: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CacheImage(
//               image:
//                   'https://phunuvietnam.mediacdn.vn/179072216278405120/2022/11/4/edogawa-conan--166754179290680712885.jpg',
//               dimension: context.screenWidth * .4,
//               radius: 100,
//             ),
//             HeightBox(10.h),
//             "Incoming Call from ${incomingSDPOffer.callerId}"
//                 .text
//                 .color(context.primaryColor)
//                 .size(24.sp)
//                 .italic
//                 .make(),
//             HeightBox(context.screenHeight * .3),
//             const ButtonCall(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ButtonCall extends ConsumerWidget {
//   const ButtonCall({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final status = ref.watch(
//       socketProvider.select((value) => value.callStatus),
//     );
//     switch (status) {
//       case CallStatus.calling:
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildButton(
//               context,
//               icon: Icons.call_end,
//               color: Colors.red,
//               onPressed: () {
//                 ref.read(socketProvider.notifier).endCall();
//               },
//             ),
//             _buildButton(
//               context,
//               icon: Icons.call,
//               color: Colors.green,
//               onPressed: () {
//                 ref.read(socketProvider.notifier).acceptCall();
//               },
//             ),
//           ],
//         );
//       case CallStatus.incoming:
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildButton(
//               context,
//               icon: Icons.call_end,
//               color: Colors.red,
//               onPressed: () {
//                 ref.read(socketProvider.notifier).endCall();
//               },
//             ),
//             _buildButton(
//               context,
//               icon: Icons.call,
//               color: Colors.green,
//               onPressed: () {
//                 ref.read(socketProvider.notifier).acceptCall();
//               },
//             ),
//           ],
//         );

//       default:
//         return _buildButton(
//           context,
//           icon: Icons.call_end,
//           color: Colors.red,
//           onPressed: () {
//             ref.read(socketProvider.notifier).endCall();
//           },
//         );
//     }
//   }

//   _buildButton(
//     BuildContext context, {
//     IconData? icon,
//     VoidCallback? onPressed,
//     Color? color,
//   }) =>
//       DecoratedBox(
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: color,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: IconButton(
//           onPressed: onPressed,
//           icon: Icon(icon, color: Colors.white, size: 40.sp),
//         ),
//       );
// }
