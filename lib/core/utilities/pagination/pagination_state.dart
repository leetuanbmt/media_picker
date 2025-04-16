part of 'pagination.dart';

@freezed
abstract class PaginationState<T> with _$PaginationState<T> {
  const factory PaginationState.success(List<T> items) = PaginationSuccess;
  const factory PaginationState.error(Object? e) = PaginationError;
  const factory PaginationState.loading() = PaginationLoading;
  const factory PaginationState.loadMore(List<T> items) = PaginationLoadMore;
  const factory PaginationState.loadMoreError(List<T> items, Object? e) =
      PaginationLoadMoreError;
}
