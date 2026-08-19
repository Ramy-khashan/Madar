import 'package:equatable/equatable.dart';

/// Base contract for the per-type `details` object of `POST /properties`.
///
/// Each property type serializes a different shape, so the request model only
/// depends on [toJson] and [propertyType].
abstract class PropertyDetailsBase extends Equatable {
  const PropertyDetailsBase();

  /// The API `type` value this details payload belongs to.
  String get propertyType;

  /// The object JSON-encoded into the `details` FormData field.
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [propertyType, toJson()];
}

/// Drops null values and empty collections so optional fields are omitted
/// rather than sent as `null`.
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
