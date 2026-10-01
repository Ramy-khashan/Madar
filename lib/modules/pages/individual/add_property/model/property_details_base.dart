import 'package:equatable/equatable.dart';

abstract class PropertyDetailsBase extends Equatable {
  const PropertyDetailsBase();

  String get propertyType;

  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [propertyType, toJson()];
}

Map<String, dynamic> compactJson(Map<String, dynamic> source) {
  final result = <String, dynamic>{};
  source.forEach((key, value) {
    if (value == null) return;
    if (value is String && value.isEmpty) return;
    if (value is Iterable && value.isEmpty) return;
    if (value is Map && value.isEmpty) return;
    result[key] = value;
  });
  return result;
}
