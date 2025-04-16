library;

import 'dart:async';
import 'dart:collection';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:synchronized/synchronized.dart' as sync;

part 'disposable.dart';

typedef CancelListenFunc = Function();

extension ObjectExt on Object {
  String get objectId => '$runtimeType#$hashCode';
}

mixin EventsEmittable<T> {
  final events = EventsEmitter<T>();
  EventsListener<T> createListener({bool synchronized = false}) =>
      EventsListener<T>(events, synchronized: synchronized);
}

// Type-safe, multi-listenable, dispose safe event handling

class EventsEmitter<T> extends EventsListenable<T> {
  // support for multiple event listeners
  final streamCtrl = StreamController<T>.broadcast(sync: false);

  bool _queueMode = false;
  final _queue = Queue<T>();

  EventsEmitter({
    bool listenSynchronized = false,
  }) : super(synchronized: listenSynchronized) {
    // clean up
    onDispose(() => streamCtrl.close());
  }

  @override
  EventsEmitter<T> get emitter => this;

  void emit(T event) {
    // check if already disposed
    if (isDisposed) {
      dev.log('failed to emit event $event on a disposed emitter');
      return;
    }
    // queue mode
    if (_queueMode) {
      _queue.add(event);
      return;
    }
    // emit the event
    streamCtrl.add(event);
  }

  void updateQueueMode(bool newValue, {bool shouldEmitQueued = true}) {
    // check if already disposed
    if (isDisposed) {
      dev.log('failed to update queueMode on a disposed emitter');
      return;
    }
    if (_queueMode == newValue) return;
    _queueMode = newValue;
    if (!_queueMode && shouldEmitQueued) emitQueued();
  }

  void emitQueued() {
    while (_queue.isNotEmpty) {
      final event = _queue.removeFirst();
      // emit the event
      streamCtrl.add(event);
    }
  }
}

// for listening only
class EventsListener<T> extends EventsListenable<T> {
  @override
  final EventsEmitter<T> emitter;

  EventsListener(
    this.emitter, {
    super.synchronized = false,
  });
}

// ensures all listeners will close on dispose
abstract class EventsListenable<T> extends Disposable {
  // the emitter to listen to
  EventsEmitter<T> get emitter;

  final bool synchronized;
  // keep track of listeners to cancel later
  final _listeners = <StreamSubscription<T>>[];
  final _syncLock = sync.Lock();

  List<StreamSubscription<T>> get listeners => _listeners;

  EventsListenable({
    required this.synchronized,
  }) {
    onDispose(() async {
      await cancelAll();
    });
  }

  Future<void> cancelAll() async {
    if (_listeners.isNotEmpty) {
      // Stop listening to all events
      dev.log('$objectId cancelling ${_listeners.length} listeners(s)');
      for (final listener in _listeners) {
        await listener.cancel();
      }
    }
  }

  // listens to all events, guaranteed to be cancelled on dispose
  CancelListenFunc listen(FutureOr<void> Function(T) onEvent) {
    //
    FutureOr<void> Function(T) func = onEvent;
    if (synchronized) {
      // ensure `onEvent` will trigger one by one (waits for previous `onEvent` to complete)
      func = (event) async {
        await _syncLock.synchronized(() async {
          await onEvent(event);
        });
      };
    }

    final listener = emitter.streamCtrl.stream.listen(func);
    _listeners.add(listener);

    // make a cancel func to cancel listening and remove from list in 1 call
    cancelFunc() async {
      await listener.cancel();
      _listeners.remove(listener);
      dev.log('$objectId event was cancelled by func');
    }

    return cancelFunc;
  }

  // convenience method to listen & filter a specific event type
  CancelListenFunc on<E>(
    FutureOr<void> Function(E event) then, {
    bool Function(E)? filter,
  }) =>
      listen((event) async {
        // event must be E
        if (event is! E) return;
        // filter must be true (if filter is used)
        if (filter != null && !filter(event)) return;
        // cast to E
        await then(event);
      });

  // waits for a specific event type
  Future<E> waitFor<E>({
    required Duration duration,
    bool Function(E)? filter,
    FutureOr<E> Function()? onTimeout,
  }) async {
    final completer = Completer<E>();

    final cancelFunc = on<E>(
      (event) {
        if (!completer.isCompleted) {
          completer.complete(event);
        }
      },
      filter: filter,
    );

    try {
      // wait to complete with timeout
      return await completer.future.timeout(
        duration,
        onTimeout:
            onTimeout ?? () => throw TimeoutException('waitFor<$E> timed out'),
      );
      // do not catch exceptions and pass it up
    } finally {
      // always clean-up listener
      await cancelFunc.call();
    }
  }
}
