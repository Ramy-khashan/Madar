class MyPropertiesModel {
  final String id;
  final String title;
  final String location;
  final String imageUrl;

  const MyPropertiesModel({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
  });

  factory MyPropertiesModel.fromJson(Map<String, dynamic> json) {
    return MyPropertiesModel(
      id: json['property_id'] ?? '',
      title: json['title'] ?? '',
      location: (json['city'] ?? '' )+' , '+(json['district'] ?? ''),
      imageUrl: json['image'] ?? '',
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
