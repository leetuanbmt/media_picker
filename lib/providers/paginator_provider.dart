import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/config.dart';
import '../core/models/models.dart';

class PaginationNotifier<T> extends StateNotifier<PaginationState<T>> {
  PaginationNotifier({
    required this.request,
  }) : super(const PaginationState.loading()) {
    init();
  }
  final Future<BaseResponse<T>> Function(int nextPage) request;

  final List<T> _items = [];

  int totalPage = 0;

  int _currentPage = 1;

  bool get noMoreItem => _currentPage >= totalPage;

  void init() {
    if (_items.isEmpty) {
      fetchFirst();
    }
  }

  void updateData(List<T> result) {
    if (_currentPage == 1) {
      state = PaginationState.data(
        _items
          ..clear()
          ..addAll(result),
      );
    } else {
      _items.addAll(result);
      state = PaginationState.data(_items..addAll(result));
    }
  }

  Future<void> fetchFirst() async {
    try {
      _currentPage = 1;
      state = const PaginationState.loading();
      final result = await request(_currentPage);
      totalPage = result.total;
      updateData(result.items);
    } catch (e) {
      state = PaginationState.error(e);
    }
  }

  Future<void> onLoadMore() async {
    if (noMoreItem) {
      return;
    }
    // if state is load more, do nothing
    if (state == PaginationState<T>.loadMore(_items)) {
      return;
    }

    _currentPage++;
    // set state to load more
    state = PaginationState.loadMore(_items);

    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await request(_currentPage);
      updateData(result.items);
    } catch (e) {
      state = PaginationState.loadMoreError(_items, e);
    }
  }

  Future<void> onRefresh() async {
    try {
      _currentPage = 1;
      final result = await request(_currentPage);
      totalPage = result.total;
      updateData(result.items);
    } catch (e) {
      state = PaginationState.error(e);
    }
  }
}
