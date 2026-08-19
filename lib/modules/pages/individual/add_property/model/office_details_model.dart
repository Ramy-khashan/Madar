import 'property_details_base.dart';
import 'property_enums.dart';

/// `details` payload for `type: OFFICE`.
class OfficeDetailsModel extends PropertyDetailsBase {
  const OfficeDetailsModel({
    this.floor,
    this.roomsCount,
    this.bathrooms,
    this.facilities = const [],
    this.furnishedOffice,
    this.furnishing,
    this.condition,
  });

  final int? floor;
  final int? roomsCount;
  final int? bathrooms;

  /// Values from [PropertyApiEnums.facilityAc] and friends.
  final List<String> facilities;
  final bool? furnishedOffice;
  final String? furnishing;
  final String? condition;

  @override
  String get propertyType => PropertyApiEnums.typeOffice;

  factory OfficeDetailsModel.fromJson(Map<String, dynamic> json) {
    return OfficeDetailsModel(
      floor: (json['floor'] as num?)?.toInt(),
      roomsCount: (json['roomsCount'] as num?)?.toInt(),
      bathrooms: (json['bathrooms'] as num?)?.toInt(),
      facilities:
          (json['facilities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      furnishedOffice: json['furnishedOffice'] as bool?,
      furnishing: json['furnishing']?.toString(),
      condition: json['condition']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => compactJson({
    'floor': floor,
    'roomsCount': roomsCount,
    'bathrooms': bathrooms,
    'facilities': facilities,
    'furnishedOffice': furnishedOffice,
    'furnishing': furnishing,
    'condition': condition,
  });

  OfficeDetailsModel copyWith({
    int? floor,
    int? roomsCount,
    int? bathrooms,
    List<String>? facilities,
    bool? furnishedOffice,
    String? furnishing,
    String? condition,
  }) {
    return OfficeDetailsModel(
      floor: floor ?? this.floor,
      roomsCount: roomsCount ?? this.roomsCount,
      bathrooms: bathrooms ?? this.bathrooms,
      facilities: facilities ?? this.facilities,
      furnishedOffice: furnishedOffice ?? this.furnishedOffice,
      furnishing: furnishing ?? this.furnishing,
      condition: condition ?? this.condition,
    );
  }
}
