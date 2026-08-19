import 'property_details_base.dart';
import 'property_enums.dart';

/// `details` payload for `type: FLOOR`.
class FloorDetailsModel extends PropertyDetailsBase {
  const FloorDetailsModel({
    this.floorType,
    this.bedrooms,
    this.bathrooms,
    this.councils,
    this.livingRooms,
    this.furnishing,
    this.condition,
  });

  /// One of [PropertyApiEnums.floorTypeGround], `floorTypeUpper`, etc.
  final String? floorType;
  final int? bedrooms;
  final int? bathrooms;
  final int? councils;
  final int? livingRooms;
  final String? furnishing;
  final String? condition;

  @override
  String get propertyType => PropertyApiEnums.typeFloor;

  factory FloorDetailsModel.fromJson(Map<String, dynamic> json) {
    return FloorDetailsModel(
      floorType: json['floorType']?.toString(),
      bedrooms: (json['bedrooms'] as num?)?.toInt(),
      bathrooms: (json['bathrooms'] as num?)?.toInt(),
      councils: (json['councils'] as num?)?.toInt(),
      livingRooms: (json['livingRooms'] as num?)?.toInt(),
      furnishing: json['furnishing']?.toString(),
      condition: json['condition']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => compactJson({
    'floorType': floorType,
    'bedrooms': bedrooms,
    'bathrooms': bathrooms,
    'councils': councils,
    'livingRooms': livingRooms,
    'furnishing': furnishing,
    'condition': condition,
  });

  FloorDetailsModel copyWith({
    String? floorType,
    int? bedrooms,
    int? bathrooms,
    int? councils,
    int? livingRooms,
    String? furnishing,
    String? condition,
  }) {
    return FloorDetailsModel(
      floorType: floorType ?? this.floorType,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      councils: councils ?? this.councils,
      livingRooms: livingRooms ?? this.livingRooms,
      furnishing: furnishing ?? this.furnishing,
      condition: condition ?? this.condition,
    );
  }
}
