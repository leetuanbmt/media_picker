part of 'pagination.dart';

@JsonSerializable()
class PaginationRequest {
  const PaginationRequest({
    this.currentPage = 0,
  });
  final int currentPage;

  factory PaginationRequest.fromJson(Map<String, dynamic> json) =>
      _$PaginationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationRequestToJson(this);
}
