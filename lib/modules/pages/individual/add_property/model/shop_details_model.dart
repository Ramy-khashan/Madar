import 'property_details_base.dart';
import 'property_enums.dart';

/// `details` payload for `type: SHOP`.
class ShopDetailsModel extends PropertyDetailsBase {
  const ShopDetailsModel({
    this.frontWidth,
    this.locationType,
    this.mallName,
    this.facilities = const [],
    this.activities = const [],
    this.condition,
  });

  /// Shop frontage width in meters.
  final num? frontWidth;

  /// One of [PropertyApiEnums.shopLocationMainStreet] and friends.
  final String? locationType;
  final String? mallName;

  /// Values from [PropertyApiEnums.facilityAc] and friends.
  final List<String> facilities;

  /// Values from [PropertyApiEnums.activityCafe] and friends.
  final List<String> activities;
  final String? condition;

  @override
  String get propertyType => PropertyApiEnums.typeShop;

  factory ShopDetailsModel.fromJson(Map<String, dynamic> json) {
    return ShopDetailsModel(
      frontWidth: json['frontWidth'] as num?,
      locationType: json['locationType']?.toString(),
      mallName: json['mallName']?.toString(),
      facilities:
          (json['facilities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      activities:
          (json['activities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      condition: json['condition']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => compactJson({
    'frontWidth': frontWidth,
    'locationType': locationType,
    'mallName': mallName,
    'facilities': facilities,
    'activities': activities,
    'condition': condition,
  });

  ShopDetailsModel copyWith({
    num? frontWidth,
    String? locationType,
    String? mallName,
    List<String>? facilities,
    List<String>? activities,
    String? condition,
  }) {
    return ShopDetailsModel(
      frontWidth: frontWidth ?? this.frontWidth,
      locationType: locationType ?? this.locationType,
      mallName: mallName ?? this.mallName,
      facilities: facilities ?? this.facilities,
      activities: activities ?? this.activities,
      condition: condition ?? this.condition,
    );
  }
}
