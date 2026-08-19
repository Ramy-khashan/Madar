import 'property_details_base.dart';
import 'property_enums.dart';

/// `details` payload for `type: RESTHOUSE`.
class RestHouseDetailsModel extends PropertyDetailsBase {
  const RestHouseDetailsModel({
    this.bedrooms,
    this.bathrooms,
    this.councils,
    this.livingRooms,
    this.hasGarden,
    this.hasPool,
    this.condition,
  });

  final int? bedrooms;
  final int? bathrooms;
  final int? councils;
  final int? livingRooms;
  final bool? hasGarden;
  final bool? hasPool;
  final String? condition;

  @override
  String get propertyType => PropertyApiEnums.typeRestHouse;

  factory RestHouseDetailsModel.fromJson(Map<String, dynamic> json) {
    return RestHouseDetailsModel(
      bedrooms: (json['bedrooms'] as num?)?.toInt(),
      bathrooms: (json['bathrooms'] as num?)?.toInt(),
      councils: (json['councils'] as num?)?.toInt(),
      livingRooms: (json['livingRooms'] as num?)?.toInt(),
      hasGarden: json['hasGarden'] as bool?,
      hasPool: json['hasPool'] as bool?,
      condition: json['condition']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => compactJson({
    'bedrooms': bedrooms,
    'bathrooms': bathrooms,
    'councils': councils,
    'livingRooms': livingRooms,
    'hasGarden': hasGarden,
    'hasPool': hasPool,
    'condition': condition,
  });

  RestHouseDetailsModel copyWith({
    int? bedrooms,
    int? bathrooms,
    int? councils,
    int? livingRooms,
    bool? hasGarden,
    bool? hasPool,
    String? condition,
  }) {
    return RestHouseDetailsModel(
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      councils: councils ?? this.councils,
      livingRooms: livingRooms ?? this.livingRooms,
      hasGarden: hasGarden ?? this.hasGarden,
      hasPool: hasPool ?? this.hasPool,
      condition: condition ?? this.condition,
    );
  }
}
