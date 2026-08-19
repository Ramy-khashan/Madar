import 'property_details_base.dart';
import 'property_enums.dart';

/// `details` payload for `type: TOWER`.
class TowerDetailsModel extends PropertyDetailsBase {
  const TowerDetailsModel({
    this.name,
    this.floorsCount,
    this.classification,
    this.totalUnits,
    this.elevatorsCount,
    this.parkingFloors,
    this.totalParking,
    this.amenities = const [],
    this.views = const [],
    this.yearBuilt,
    this.condition,
    this.developerName,
  });

  final String? name;
  final int? floorsCount;

  /// One of [PropertyApiEnums.classificationResidential] and friends.
  final String? classification;
  final int? totalUnits;
  final int? elevatorsCount;
  final int? parkingFloors;
  final int? totalParking;

  /// Values from [PropertyApiEnums.towerAmenityGym] and friends.
  final List<String> amenities;

  /// Values from [PropertyApiEnums.viewPanoramic] and friends.
  final List<String> views;
  final int? yearBuilt;
  final String? condition;
  final String? developerName;

  @override
  String get propertyType => PropertyApiEnums.typeTower;

  factory TowerDetailsModel.fromJson(Map<String, dynamic> json) {
    return TowerDetailsModel(
      name: json['name']?.toString(),
      floorsCount: (json['floorsCount'] as num?)?.toInt(),
      classification: json['classification']?.toString(),
      totalUnits: (json['totalUnits'] as num?)?.toInt(),
      elevatorsCount: (json['elevatorsCount'] as num?)?.toInt(),
      parkingFloors: (json['parkingFloors'] as num?)?.toInt(),
      totalParking: (json['totalParking'] as num?)?.toInt(),
      amenities:
          (json['amenities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      views:
          (json['views'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      yearBuilt: (json['yearBuilt'] as num?)?.toInt(),
      condition: json['condition']?.toString(),
      developerName: json['developerName']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => compactJson({
    'name': name,
    'floorsCount': floorsCount,
    'classification': classification,
    'totalUnits': totalUnits,
    'elevatorsCount': elevatorsCount,
    'parkingFloors': parkingFloors,
    'totalParking': totalParking,
    'amenities': amenities,
    'views': views,
    'yearBuilt': yearBuilt,
    'condition': condition,
    'developerName': developerName,
  });

  TowerDetailsModel copyWith({
    String? name,
    int? floorsCount,
    String? classification,
    int? totalUnits,
    int? elevatorsCount,
    int? parkingFloors,
    int? totalParking,
    List<String>? amenities,
    List<String>? views,
    int? yearBuilt,
    String? condition,
    String? developerName,
  }) {
    return TowerDetailsModel(
      name: name ?? this.name,
      floorsCount: floorsCount ?? this.floorsCount,
      classification: classification ?? this.classification,
      totalUnits: totalUnits ?? this.totalUnits,
      elevatorsCount: elevatorsCount ?? this.elevatorsCount,
      parkingFloors: parkingFloors ?? this.parkingFloors,
      totalParking: totalParking ?? this.totalParking,
      amenities: amenities ?? this.amenities,
      views: views ?? this.views,
      yearBuilt: yearBuilt ?? this.yearBuilt,
      condition: condition ?? this.condition,
      developerName: developerName ?? this.developerName,
    );
  }
}
