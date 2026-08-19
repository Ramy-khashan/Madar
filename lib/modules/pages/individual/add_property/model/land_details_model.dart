import 'land_dimensions_model.dart';
import 'property_details_base.dart';
import 'property_enums.dart';

/// `details` payload for `type: LAND`.
class LandDetailsModel extends PropertyDetailsBase {
  const LandDetailsModel({
    this.classification,
    this.plotNumber,
    this.planNumber,
    this.dimensions,
    this.buildingRatio,
    this.allowedFloors,
    this.services = const [],
  });

  /// One of [PropertyApiEnums.classificationResidential] and friends.
  final String? classification;
  final String? plotNumber;
  final String? planNumber;
  final LandDimensionsModel? dimensions;

  /// Allowed construction ratio as a percentage, e.g. `60`.
  final num? buildingRatio;
  final int? allowedFloors;

  /// Values from [PropertyApiEnums.landServiceElectricity] and friends.
  final List<String> services;

  @override
  String get propertyType => PropertyApiEnums.typeLand;

  factory LandDetailsModel.fromJson(Map<String, dynamic> json) {
    final rawDimensions = json['dimensions'];
    return LandDetailsModel(
      classification: json['classification']?.toString(),
      plotNumber: json['plotNumber']?.toString(),
      planNumber: json['planNumber']?.toString(),
      dimensions: rawDimensions is Map<String, dynamic>
          ? LandDimensionsModel.fromJson(rawDimensions)
          : null,
      buildingRatio: json['buildingRatio'] as num?,
      allowedFloors: (json['allowedFloors'] as num?)?.toInt(),
      services:
          (json['services'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  @override
  Map<String, dynamic> toJson() => compactJson({
    'classification': classification,
    'plotNumber': plotNumber,
    'planNumber': planNumber,
    'dimensions': (dimensions != null && !dimensions!.isEmpty)
        ? dimensions!.toJson()
        : null,
    'buildingRatio': buildingRatio,
    'allowedFloors': allowedFloors,
    'services': services,
  });

  LandDetailsModel copyWith({
    String? classification,
    String? plotNumber,
    String? planNumber,
    LandDimensionsModel? dimensions,
    num? buildingRatio,
    int? allowedFloors,
    List<String>? services,
  }) {
    return LandDetailsModel(
      classification: classification ?? this.classification,
      plotNumber: plotNumber ?? this.plotNumber,
      planNumber: planNumber ?? this.planNumber,
      dimensions: dimensions ?? this.dimensions,
      buildingRatio: buildingRatio ?? this.buildingRatio,
      allowedFloors: allowedFloors ?? this.allowedFloors,
      services: services ?? this.services,
    );
  }
}
