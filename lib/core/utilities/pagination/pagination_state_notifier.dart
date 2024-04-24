part of 'pagination.dart';

abstract class PaginationNotifier<T> extends StateNotifier<PaginationState<T>> {
  PaginationNotifier() : super(const PaginationState.loading()) {
    _init();
  }

  FutureOr<Result<PaginationResponse<T>>> request(int page);

  final List<T> _items = [];

  int totalPage = 0;

  int _currentPage = 1;

  bool get noMoreItem => _currentPage >= totalPage;

  void _init() {
    if (_items.isEmpty) {
      _fetchFirst();
    }
  }

  void updateData(List<T> result) {
    if (_currentPage == 1) {
      state = PaginationState.success(
        _items
          ..clear()
          ..addAll(result),
      );
    } else {
      state = PaginationState.success(_items..addAll(result));
    }
  }

  Future<void> _fetchFirst() async {
    _currentPage = 1;

    state = const PaginationState.loading();

    final result = await request(_currentPage);
    result.when(
      success: (data) {
        totalPage = data.totalPages;
        Logger.log('totalPage: $totalPage');
        updateData(data.data);
      },
      failure: (e) {
        state = PaginationState.error(e);
      },
    );
  }

  Future<void> onLoadMore() async {
    _currentPage++;
    // set state to load more
    state = PaginationState.loadMore(_items);

    await Future.delayed(const Duration(seconds: 1));

    final result = await request(_currentPage);
    result.when(success: (data) {
      updateData(data.data);
    }, failure: (e) {
      state = PaginationState.loadMoreError(_items, e);
    });
  }

  Future<void> onRefresh() async {
    // reset page to 1
    _currentPage = 1;
    final result = await request(_currentPage);
    result.when(
      success: (data) {
        totalPage = data.totalPages;
        Logger.log('totalPage: $totalPage');
        updateData(data.data);
      },
      failure: (e) {
        state = PaginationState.error(e);
      },
    );
  }

  bool canLoadMore() {
    if (noMoreItem) return false;
    if (state == PaginationState<T>.loadMore(_items)) {
      return false;
    }
    return true;
  }
}
