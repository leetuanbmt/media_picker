import 'package:flutter/material.dart';

mixin ScrollMixin<T extends StatefulWidget> on State<T> {
  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    scroll.addListener(_listener);
    super.initState();
  }

  bool _canFetchBottom = true;

  bool _canFetchTop = true;

  void _listener() {
    if (scroll.position.atEdge) {
      _checkIfCanLoadMore();
    }

    if (scroll.position.pixels > scroll.position.minScrollExtent) {
      showHideTopButton(true);
    } else {
      showHideTopButton(false);
    }
  }

  Future<void> _checkIfCanLoadMore() async {
    if (scroll.position.pixels == 0) {
      if (!_canFetchTop) return;
      _canFetchTop = false;
      _canFetchTop = true;
    } else {
      if (!_canFetchBottom) return;
      _canFetchBottom = false;
      await onEndScroll();
      _canFetchBottom = true;
    }
  }

  Future<void> onEndScroll();

  void showHideTopButton(bool isShow);

  @override
  void dispose() {
    scroll.removeListener(_listener);
    super.dispose();
  }
}
