import 'property_details_base.dart';
import 'property_enums.dart';

/// `details` payload for `type: VILLA`.
class VillaDetailsModel extends PropertyDetailsBase {
  const VillaDetailsModel({
    this.floorsCount,
    this.bedrooms,
    this.bathrooms,
    this.councils,
    this.livingRooms,
    this.kitchens,
    this.hasMaidRoom,
    this.hasDriverRoom,
    this.furnishing,
    this.condition,
    this.developerName,
  });

  final int? floorsCount;
  final int? bedrooms;
  final int? bathrooms;
  final int? councils;
  final int? livingRooms;
  final int? kitchens;
  final bool? hasMaidRoom;
  final bool? hasDriverRoom;
  final String? furnishing;
  final String? condition;
  final String? developerName;

  @override
  String get propertyType => PropertyApiEnums.typeVilla;

  factory VillaDetailsModel.fromJson(Map<String, dynamic> json) {
    return VillaDetailsModel(
      floorsCount: (json['floorsCount'] as num?)?.toInt(),
      bedrooms: (json['bedrooms'] as num?)?.toInt(),
      bathrooms: (json['bathrooms'] as num?)?.toInt(),
      councils: (json['councils'] as num?)?.toInt(),
      livingRooms: (json['livingRooms'] as num?)?.toInt(),
      kitchens: (json['kitchens'] as num?)?.toInt(),
      hasMaidRoom: json['hasMaidRoom'] as bool?,
      hasDriverRoom: json['hasDriverRoom'] as bool?,
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
    'kitchens': kitchens,
    'hasMaidRoom': hasMaidRoom,
    'hasDriverRoom': hasDriverRoom,
    'furnishing': furnishing,
    'condition': condition,
    'developerName': developerName,
  });

  VillaDetailsModel copyWith({
    int? floorsCount,
    int? bedrooms,
    int? bathrooms,
    int? councils,
    int? livingRooms,
    int? kitchens,
    bool? hasMaidRoom,
    bool? hasDriverRoom,
    String? furnishing,
    String? condition,
    String? developerName,
  }) {
    return VillaDetailsModel(
      floorsCount: floorsCount ?? this.floorsCount,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      councils: councils ?? this.councils,
      livingRooms: livingRooms ?? this.livingRooms,
      kitchens: kitchens ?? this.kitchens,
      hasMaidRoom: hasMaidRoom ?? this.hasMaidRoom,
      hasDriverRoom: hasDriverRoom ?? this.hasDriverRoom,
      furnishing: furnishing ?? this.furnishing,
      condition: condition ?? this.condition,
      developerName: developerName ?? this.developerName,
    );
  }
}
