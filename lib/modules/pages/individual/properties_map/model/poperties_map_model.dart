import '../../property_details/model/property_details_model.dart';

/// Response model for GET `properties/map?latitude=..&longitude=..&page=..`
class PropertiesMapResponseModel {
  final List<PropertyDetailsModel> properties;
  final PropertiesMapPagination? pagination;

  const PropertiesMapResponseModel({
    required this.properties,
    this.pagination,
  });

  factory PropertiesMapResponseModel.fromJson(Map<String, dynamic> json) {
    return PropertiesMapResponseModel(
      properties: json['properties'] != null
          ? (json['properties'] as List)
                .map((e) => PropertyDetailsModel.fromJson(e))
                .toList()
          : [],
      pagination: json['pagination'] != null
          ? PropertiesMapPagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class PropertiesMapPagination {
  final int? page;
  final int? pageSize;
  final int? total;
  final int? totalPages;
  final bool? hasNext;
  final bool? hasPrevious;

  const PropertiesMapPagination({
    this.page,
    this.pageSize,
    this.total,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  });

  factory PropertiesMapPagination.fromJson(Map<String, dynamic> json) {
    return PropertiesMapPagination(
      page: json['page'],
      pageSize: json['page_size'],
      total: json['total'],
      totalPages: json['totalPages'],
      hasNext: json['hasNext'],
      hasPrevious: json['hasPrevious'],
    );
  }
}
