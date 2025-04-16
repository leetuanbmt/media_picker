import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useEffectDeactivate({
  required Dispose Function() effect,
  Function? deactivate,
  List<Object?>? keys,
}) {
  use(_EffectHook(
    effect,
    deactivate,
    keys,
  ));
}

class _EffectHook extends Hook<void> {
  const _EffectHook(this.effect, this.deactivate, [List<Object?>? keys])
      : super(keys: keys);

  final Dispose? Function() effect;
  final Function? deactivate;

  @override
  _EffectHookState createState() => _EffectHookState();
}

class _EffectHookState extends HookState<void, _EffectHook> {
  Dispose? disposer;

  @override
  void initHook() {
    super.initHook();
    scheduleEffect();
  }

  @override
  void didUpdateHook(_EffectHook oldHook) {
    super.didUpdateHook(oldHook);

    if (hook.keys == null) {
      disposer?.call();
      scheduleEffect();
    }
  }

  @override
  void build(BuildContext context) {}

  @override
  void dispose() => disposer?.call();

  void scheduleEffect() {
    disposer = hook.effect();
  }

  @override
  void deactivate() {
    if (hook.deactivate != null) {
      hook.deactivate!();
    }
    super.deactivate();
  }

  @override
  String get debugLabel => 'useEffect';

  @override
  bool get debugSkipValue => true;
}
