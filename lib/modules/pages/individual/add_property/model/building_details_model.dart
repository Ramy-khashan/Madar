import 'property_details_base.dart';
import 'property_enums.dart';

/// `details` payload for `type: BUILDING`.
class BuildingDetailsModel extends PropertyDetailsBase {
  const BuildingDetailsModel({
    this.floorsCount,
    this.totalApartments,
    this.shopsCount,
    this.classification,
    this.parkingSpots,
    this.condition,
    this.developerName,
  });

  final int? floorsCount;
  final int? totalApartments;
  final int? shopsCount;

  /// One of [PropertyApiEnums.classificationResidential] and friends.
  final String? classification;
  final int? parkingSpots;
  final String? condition;
  final String? developerName;

  @override
  String get propertyType => PropertyApiEnums.typeBuilding;

  factory BuildingDetailsModel.fromJson(Map<String, dynamic> json) {
    return BuildingDetailsModel(
      floorsCount: (json['floorsCount'] as num?)?.toInt(),
      totalApartments: (json['totalApartments'] as num?)?.toInt(),
      shopsCount: (json['shopsCount'] as num?)?.toInt(),
      classification: json['classification']?.toString(),
      parkingSpots: (json['parkingSpots'] as num?)?.toInt(),
      condition: json['condition']?.toString(),
      developerName: json['developerName']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => compactJson({
    'floorsCount': floorsCount,
    'totalApartments': totalApartments,
    'shopsCount': shopsCount,
    'classification': classification,
    'parkingSpots': parkingSpots,
    'condition': condition,
    'developerName': developerName,
  });

  BuildingDetailsModel copyWith({
    int? floorsCount,
    int? totalApartments,
    int? shopsCount,
    String? classification,
    int? parkingSpots,
    String? condition,
    String? developerName,
  }) {
    return BuildingDetailsModel(
      floorsCount: floorsCount ?? this.floorsCount,
      totalApartments: totalApartments ?? this.totalApartments,
      shopsCount: shopsCount ?? this.shopsCount,
      classification: classification ?? this.classification,
      parkingSpots: parkingSpots ?? this.parkingSpots,
      condition: condition ?? this.condition,
      developerName: developerName ?? this.developerName,
    );
  }
}
