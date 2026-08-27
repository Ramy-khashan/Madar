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
    final data = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'] as Map)
        : json;
    final raw = data['properties'] ?? data['items'] ?? data['data'];
    final properties = raw is List
        ? raw
              .whereType<Map>()
              .map(
                (e) => PropertyDetailsModel.fromJson(
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList()
        : <PropertyDetailsModel>[];

    final paginationJson = data['pagination'] ?? json['pagination'];
    return PropertiesMapResponseModel(
      properties: properties,
      pagination: paginationJson is Map
          ? PropertiesMapPagination.fromJson(
              Map<String, dynamic>.from(paginationJson),
            )
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
      page: _asInt(json['page']),
      pageSize: _asInt(json['limit'] ?? json['pageSize']),
      total: _asInt(json['total']),
      totalPages: _asInt(json['totalPages'] ?? json['pages']),
      hasNext: json['hasNext'] == true,
      hasPrevious: json['hasPrevious'] == true,
    );
  }

  static int? _asInt(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }
}
