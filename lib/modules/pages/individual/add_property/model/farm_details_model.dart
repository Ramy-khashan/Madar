import 'property_details_base.dart';
import 'property_enums.dart';

class FarmDetailsModel extends PropertyDetailsBase {
  const FarmDetailsModel({
    this.builtArea,
    this.soilType,
    this.waterSources = const [],
    this.wellsCount,
    this.wellDepth,
    this.palmTreesCount,
    this.facilities = const [],
    this.distanceToCity,
    this.condition,
  });

  final num? builtArea;

  final String? soilType;

  final List<String> waterSources;
  final int? wellsCount;

  final num? wellDepth;
  final int? palmTreesCount;

  final List<String> facilities;

  final num? distanceToCity;
  final String? condition;

  @override
  String get propertyType => PropertyApiEnums.typeFarm;

  factory FarmDetailsModel.fromJson(Map<String, dynamic> json) {
    return FarmDetailsModel(
      builtArea: json['builtArea'] as num?,
      soilType: json['soilType']?.toString(),
      waterSources:
          (json['waterSources'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      wellsCount: (json['wellsCount'] as num?)?.toInt(),
      wellDepth: json['wellDepth'] as num?,
      palmTreesCount: (json['palmTreesCount'] as num?)?.toInt(),
      facilities:
          (json['facilities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      distanceToCity: json['distanceToCity'] as num?,
      condition: json['condition']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => compactJson({
    'builtArea': builtArea,
    'soilType': soilType,
    'waterSources': waterSources,
    'wellsCount': wellsCount,
    'wellDepth': wellDepth,
    'palmTreesCount': palmTreesCount,
    'facilities': facilities,
    'distanceToCity': distanceToCity,
    'condition': condition,
  });

  FarmDetailsModel copyWith({
    num? builtArea,
    String? soilType,
    List<String>? waterSources,
    int? wellsCount,
    num? wellDepth,
    int? palmTreesCount,
    List<String>? facilities,
    num? distanceToCity,
    String? condition,
  }) {
    return FarmDetailsModel(
      builtArea: builtArea ?? this.builtArea,
      soilType: soilType ?? this.soilType,
      waterSources: waterSources ?? this.waterSources,
      wellsCount: wellsCount ?? this.wellsCount,
      wellDepth: wellDepth ?? this.wellDepth,
      palmTreesCount: palmTreesCount ?? this.palmTreesCount,
      facilities: facilities ?? this.facilities,
      distanceToCity: distanceToCity ?? this.distanceToCity,
      condition: condition ?? this.condition,
    );
  }
}
