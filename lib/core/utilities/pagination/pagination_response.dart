part of 'pagination.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class PaginationResponse<T> {
  final List<T> data;

  @JsonKey(defaultValue: 0, name: 'total_pages')
  final int totalPages;

  bool get isCompleted => data.isEmpty;

  PaginationResponse({required this.data, required this.totalPages});

  factory PaginationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) dataFromJson,
  ) =>
      _$PaginationResponseFromJson(json, dataFromJson);
}
