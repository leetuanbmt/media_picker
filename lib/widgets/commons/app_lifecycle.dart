import 'dart:async';

import 'package:provider/provider.dart';

import '../../core/config.dart';

class AppLifecycleObserver extends StatefulWidget {
  const AppLifecycleObserver({required this.child, super.key});

  final Widget child;

  @override
  State<AppLifecycleObserver> createState() => AppLifecycleObserverState();
}

@visibleForTesting
class AppLifecycleObserverState extends State<AppLifecycleObserver>
    with WidgetsBindingObserver {
  Timer? _debounce;
  final ValueNotifier<AppLifecycleState> lifecycleListenable =
      ValueNotifier(AppLifecycleState.inactive);

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<ValueNotifier<AppLifecycleState>>.value(
      value: lifecycleListenable,
      child: widget.child,
    );
  }

  _changeAppLifecycle(AppLifecycleState state) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(kThemeChangeDuration, () {
      Logger.log('didChangeAppLifecycleState: $state');
      lifecycleListenable.value = state;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _changeAppLifecycle(state);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    lifecycleListenable.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Logger.log('Subscribed to app lifecycle updates');
  }
}

class AppLifecycleWidget extends StatefulWidget {
  const AppLifecycleWidget({
    super.key,
    this.onResumed,
    this.onInactive,
    required this.child,
  });
  final VoidCallback? onResumed, onInactive;

  final Widget child;

  @override
  State<AppLifecycleWidget> createState() => _AppLifecycleWidgetState();
}

class _AppLifecycleWidgetState extends State<AppLifecycleWidget> {
  ValueNotifier<AppLifecycleState>? _lifecycleNotifier;

  @override
  void initState() {
    super.initState();
    _lifecycleNotifier = context.read<ValueNotifier<AppLifecycleState>>();
    _lifecycleNotifier?.addListener(_handleAppLifecycle);
  }

  _handleAppLifecycle() {
    switch (_lifecycleNotifier!.value) {
      case AppLifecycleState.resumed:
        widget.onResumed?.call();
        break;
      case AppLifecycleState.inactive:
        widget.onInactive?.call();
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
