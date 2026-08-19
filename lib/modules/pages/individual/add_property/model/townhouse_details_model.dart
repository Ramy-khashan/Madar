import 'property_details_base.dart';
import 'property_enums.dart';

/// `details` payload for `type: TOWNHOUSE`.
class TownhouseDetailsModel extends PropertyDetailsBase {
  const TownhouseDetailsModel({
    this.floorsCount,
    this.bedrooms,
    this.bathrooms,
    this.councils,
    this.livingRooms,
    this.compoundName,
    this.hasClubhouse,
    this.serviceFee,
    this.parkingSpots,
    this.communityFacilities = const [],
    this.furnishing,
    this.condition,
    this.developerName,
  });

  final int? floorsCount;
  final int? bedrooms;
  final int? bathrooms;
  final int? councils;
  final int? livingRooms;
  final String? compoundName;
  final bool? hasClubhouse;
  final num? serviceFee;
  final int? parkingSpots;
  final List<String> communityFacilities;
  final String? furnishing;
  final String? condition;
  final String? developerName;

  @override
  String get propertyType => PropertyApiEnums.typeTownhouse;

  factory TownhouseDetailsModel.fromJson(Map<String, dynamic> json) {
    return TownhouseDetailsModel(
      floorsCount: (json['floorsCount'] as num?)?.toInt(),
      bedrooms: (json['bedrooms'] as num?)?.toInt(),
      bathrooms: (json['bathrooms'] as num?)?.toInt(),
      councils: (json['councils'] as num?)?.toInt(),
      livingRooms: (json['livingRooms'] as num?)?.toInt(),
      compoundName: json['compoundName']?.toString(),
      hasClubhouse: json['hasClubhouse'] as bool?,
      serviceFee: json['serviceFee'] as num?,
      parkingSpots: (json['parkingSpots'] as num?)?.toInt(),
      communityFacilities:
          (json['communityFacilities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      furnishing: json['furnishing']?.toString(),
      condition: json['condition']?.toString(),
      developerName: json['developerName']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => compactJson({
    'floorsCount': floorsCount,
    'bedrooms': bedrooms,
    'bathrooms': bathrooms,
    'councils': councils,
    'livingRooms': livingRooms,
    'compoundName': compoundName,
    'hasClubhouse': hasClubhouse,
    'serviceFee': serviceFee,
    'parkingSpots': parkingSpots,
    'communityFacilities': communityFacilities,
    'furnishing': furnishing,
    'condition': condition,
    'developerName': developerName,
  });

  TownhouseDetailsModel copyWith({
    int? floorsCount,
    int? bedrooms,
    int? bathrooms,
    int? councils,
    int? livingRooms,
    String? compoundName,
    bool? hasClubhouse,
    num? serviceFee,
    int? parkingSpots,
    List<String>? communityFacilities,
    String? furnishing,
    String? condition,
    String? developerName,
  }) {
    return TownhouseDetailsModel(
      floorsCount: floorsCount ?? this.floorsCount,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      councils: councils ?? this.councils,
      livingRooms: livingRooms ?? this.livingRooms,
      compoundName: compoundName ?? this.compoundName,
      hasClubhouse: hasClubhouse ?? this.hasClubhouse,
      serviceFee: serviceFee ?? this.serviceFee,
      parkingSpots: parkingSpots ?? this.parkingSpots,
      communityFacilities: communityFacilities ?? this.communityFacilities,
      furnishing: furnishing ?? this.furnishing,
      condition: condition ?? this.condition,
      developerName: developerName ?? this.developerName,
    );
  }
}
