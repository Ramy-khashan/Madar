import 'package:equatable/equatable.dart';

/// Sent as the JSON-encoded `location` field of the create-property FormData.
class PropertyLocationModel extends Equatable {
  const PropertyLocationModel({
    required this.city,
    required this.district,
    required this.latitude,
    required this.longitude,
    this.street,
    this.buildingNumber,
  });

  final String city;
  final String district;
  final double latitude;
  final double longitude;
  final String? street;
  final String? buildingNumber;

  factory PropertyLocationModel.fromJson(Map<String, dynamic> json) {
    return PropertyLocationModel(
      city: json['city']?.toString() ?? '',
      district: json['district']?.toString() ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      street: json['street']?.toString(),
      buildingNumber: json['buildingNumber']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'district': district,
      'latitude': latitude,
      'longitude': longitude,
      if (street != null && street!.isNotEmpty) 'street': street,
      if (buildingNumber != null && buildingNumber!.isNotEmpty)
        'buildingNumber': buildingNumber,
    };
  }

  PropertyLocationModel copyWith({
    String? city,
    String? district,
    double? latitude,
    double? longitude,
    String? street,
    String? buildingNumber,
  }) {
    return PropertyLocationModel(
      city: city ?? this.city,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      street: street ?? this.street,
      buildingNumber: buildingNumber ?? this.buildingNumber,
    );
  }

  @override
  List<Object?> get props => [
    city,
    district,
    latitude,
    longitude,
    street,
    buildingNumber,
  ];
}
