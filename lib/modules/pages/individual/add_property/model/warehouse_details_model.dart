import 'property_details_base.dart';
import 'property_enums.dart';

/// `details` payload for `type: WAREHOUSE`.
class WarehouseDetailsModel extends PropertyDetailsBase {
  const WarehouseDetailsModel({
    this.height,
    this.doorsCount,
    this.doorType,
    this.coolingType,
    this.hasOffice,
    this.electricityKW,
    this.floorType,
    this.hasYard,
    this.yardArea,
    this.condition,
  });

  /// Internal clear height in meters.
  final num? height;
  final int? doorsCount;

  /// One of [PropertyApiEnums.doorTypeNormal] and friends.
  final String? doorType;

  /// One of [PropertyApiEnums.coolingNone] and friends.
  final String? coolingType;
  final bool? hasOffice;

  /// Electrical capacity in kilowatts.
  final num? electricityKW;

  /// One of [PropertyApiEnums.flooringConcrete] and friends.
  final String? floorType;
  final bool? hasYard;

  /// Outdoor yard area in square meters.
  final num? yardArea;
  final String? condition;

  @override
  String get propertyType => PropertyApiEnums.typeWarehouse;

  factory WarehouseDetailsModel.fromJson(Map<String, dynamic> json) {
    return WarehouseDetailsModel(
      height: json['height'] as num?,
      doorsCount: (json['doorsCount'] as num?)?.toInt(),
      doorType: json['doorType']?.toString(),
      coolingType: json['coolingType']?.toString(),
      hasOffice: json['hasOffice'] as bool?,
      electricityKW: json['electricityKW'] as num?,
      floorType: json['floorType']?.toString(),
      hasYard: json['hasYard'] as bool?,
      yardArea: json['yardArea'] as num?,
      condition: json['condition']?.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() => compactJson({
    'height': height,
    'doorsCount': doorsCount,
    'doorType': doorType,
    'coolingType': coolingType,
    'hasOffice': hasOffice,
    'electricityKW': electricityKW,
    'floorType': floorType,
    'hasYard': hasYard,
    'yardArea': yardArea,
    'condition': condition,
  });

  WarehouseDetailsModel copyWith({
    num? height,
    int? doorsCount,
    String? doorType,
    String? coolingType,
    bool? hasOffice,
    num? electricityKW,
    String? floorType,
    bool? hasYard,
    num? yardArea,
    String? condition,
  }) {
    return WarehouseDetailsModel(
      height: height ?? this.height,
      doorsCount: doorsCount ?? this.doorsCount,
      doorType: doorType ?? this.doorType,
      coolingType: coolingType ?? this.coolingType,
      hasOffice: hasOffice ?? this.hasOffice,
      electricityKW: electricityKW ?? this.electricityKW,
      floorType: floorType ?? this.floorType,
      hasYard: hasYard ?? this.hasYard,
      yardArea: yardArea ?? this.yardArea,
      condition: condition ?? this.condition,
    );
  }
}
