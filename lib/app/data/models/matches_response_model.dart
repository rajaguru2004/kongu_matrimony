import 'user_model.dart';

class MatchesResponseModel {
  final bool success;
  final List<UserModel> data;
  final PaginationModel? pagination;

  MatchesResponseModel({
    required this.success,
    required this.data,
    this.pagination,
  });

  factory MatchesResponseModel.fromJson(Map<String, dynamic> json) {
    return MatchesResponseModel(
      success: json['success'] ?? false,
      data:
          (json['data'] as List?)
              ?.map((item) => UserModel.fromJson(item))
              .toList() ??
          [],
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : null,
    );
  }
}

class PaginationModel {
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;

  PaginationModel({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 8,
      totalPages: json['totalPages'] ?? 1,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPrevPage: json['hasPrevPage'] ?? false,
    );
  }
}
