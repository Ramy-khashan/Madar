import 'package:equatable/equatable.dart';

/// Plot side lengths nested under the LAND `details.dimensions` object.
class LandDimensionsModel extends Equatable {
  const LandDimensionsModel({this.north, this.south, this.east, this.west});

  final num? north;
  final num? south;
  final num? east;
  final num? west;

  bool get isEmpty =>
      north == null && south == null && east == null && west == null;

  factory LandDimensionsModel.fromJson(Map<String, dynamic> json) {
    return LandDimensionsModel(
      north: json['north'] as num?,
      south: json['south'] as num?,
      east: json['east'] as num?,
      west: json['west'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (north != null) 'north': north,
      if (south != null) 'south': south,
      if (east != null) 'east': east,
      if (west != null) 'west': west,
    };
  }

  LandDimensionsModel copyWith({num? north, num? south, num? east, num? west}) {
    return LandDimensionsModel(
      north: north ?? this.north,
      south: south ?? this.south,
      east: east ?? this.east,
      west: west ?? this.west,
    );
  }

  @override
  List<Object?> get props => [north, south, east, west];
}
