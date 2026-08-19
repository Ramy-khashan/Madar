import 'property_details_base.dart';
import 'property_enums.dart';

/// `details` payload for `type: APARTMENT`.
class ApartmentDetailsModel extends PropertyDetailsBase {
  const ApartmentDetailsModel({
    this.bedrooms,
    this.bathrooms,
    this.councils,
    this.livingRooms,
    this.floor,
    this.totalFloors,
    this.apartmentsPerFloor,
    this.apartmentNumber,
    this.furnishing,
    this.condition,
  });

  final int? bedrooms;
  final int? bathrooms;
  final int? councils;
  final int? livingRooms;
  final int? floor;
  final int? totalFloors;
  final int? apartmentsPerFloor;
  final String? apartmentNumber;
  final String? furnishing;
  final String? condition;

  @override
  String get propertyType => PropertyApiEnums.typeApartment;

  factory ApartmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return ApartmentDetailsModel(
      bedrooms: (json['bedrooms'] as num?)?.toInt(),
      bathrooms: (json['bathrooms'] as num?)?.toInt(),
      councils: (json['councils'] as num?)?.toInt(),
      livingRooms: (json['livingRooms'] as num?)?.toInt(),
      floor: (json['floor'] as num?)?.toInt(),
      totalFloors: (json['totalFloors'] as num?)?.toInt(),
      apartmentsPerFloor: (json['apartmentsPerFloor'] as num?)?.toInt(),
      apartmentNumber: json['apartmentNumber']?.toString(),
      furnishing: json['furnishing']?.toString(),
      condition: json['condition']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => compactJson({
    'bedrooms': bedrooms,
    'bathrooms': bathrooms,
    'councils': councils,
    'livingRooms': livingRooms,
    'floor': floor,
    'totalFloors': totalFloors,
    'apartmentsPerFloor': apartmentsPerFloor,
    'apartmentNumber': apartmentNumber,
    'furnishing': furnishing,
    'condition': condition,
  });

  ApartmentDetailsModel copyWith({
    int? bedrooms,
    int? bathrooms,
    int? councils,
    int? livingRooms,
    int? floor,
    int? totalFloors,
    int? apartmentsPerFloor,
    String? apartmentNumber,
    String? furnishing,
    String? condition,
  }) {
    return ApartmentDetailsModel(
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      councils: councils ?? this.councils,
      livingRooms: livingRooms ?? this.livingRooms,
      floor: floor ?? this.floor,
      totalFloors: totalFloors ?? this.totalFloors,
      apartmentsPerFloor: apartmentsPerFloor ?? this.apartmentsPerFloor,
      apartmentNumber: apartmentNumber ?? this.apartmentNumber,
      furnishing: furnishing ?? this.furnishing,
      condition: condition ?? this.condition,
    );
  }
}
