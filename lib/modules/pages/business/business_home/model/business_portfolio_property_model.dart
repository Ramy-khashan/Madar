import '../../../individual/property_details/model/property_details_model.dart';

class MyPropertiesModel {
  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final String type;
  final int unitsCount;

  const MyPropertiesModel({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    this.type = '',
    this.unitsCount = 0,
  });

  bool get isBuilding => type.toUpperCase() == 'BUILDING';

  bool get isBuildingOrTower {
    final value = type.toUpperCase();
    return value == 'BUILDING' || value == 'TOWER';
  }

  factory MyPropertiesModel.fromJson(Map<String, dynamic> json) {
    final locationRaw = json['location'];
    final locationFromString = locationRaw is String ? locationRaw.trim() : '';
    final city = (json['city'] ?? '').toString().trim();
    final district = (json['district'] ?? '').toString().trim();
    final composed = [
      district,
      city,
    ].where((e) => e.isNotEmpty).join(' , ');
    final unitsRaw =
        json['unitsCount'] ??
        json['totalApartments'] ??
        json['totalUnits'] ??
        json['childCount'];
    return MyPropertiesModel(
      id: (json['propertyId'] ?? json['property_id'] ?? json['id'] ?? '')
          .toString(),
      title: (json['title'] ?? json['name'] ?? '').toString(),
      location: locationFromString.isNotEmpty ? locationFromString : composed,
      imageUrl: PropertyMedia.coverFrom(
        json['media'],
        fallback: (json['image'] ?? json['imageUrl'] ?? json['propertyImage'] ?? '')
            .toString(),
      ),
      type: (json['type'] ?? json['propertyType'] ?? '').toString(),
      unitsCount: unitsRaw is num ? unitsRaw.toInt() : int.tryParse('$unitsRaw') ?? 0,
    );
  }
}

class BusinessSummaryModel {
  final int totalProperties;
  final int occupancyRate;
  final int monthlyIncome;

  const BusinessSummaryModel({
    required this.totalProperties,
    required this.occupancyRate,
    required this.monthlyIncome,
  });

  factory BusinessSummaryModel.fromJson(Map<String, dynamic> json) {
    return BusinessSummaryModel(
      totalProperties: json['totalProperties'] ?? 0,
      occupancyRate: json['occupancyRate'] ?? 0,
      monthlyIncome: json['monthlyIncome'] ?? 0,
    );
  }
}
