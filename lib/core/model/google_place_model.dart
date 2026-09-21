import 'package:equatable/equatable.dart';

class PlacePrediction extends Equatable {
  const PlacePrediction({
    required this.placeId,
    required this.primaryText,
    required this.secondaryText,
    this.description = '',
  });

  final String placeId;
  final String primaryText;
  final String secondaryText;
  final String description;

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    final structured = json['structured_formatting'];
    final structuredMap = structured is Map
        ? Map<String, dynamic>.from(structured)
        : <String, dynamic>{};
    final description = json['description']?.toString() ?? '';
    final primary =
        structuredMap['main_text']?.toString().trim() ?? description;
    return PlacePrediction(
      placeId: json['place_id']?.toString() ?? '',
      primaryText: primary,
      secondaryText: structuredMap['secondary_text']?.toString().trim() ?? '',
      description: description,
    );
  }

  String get fullText {
    if (description.isNotEmpty) return description;
    if (secondaryText.isEmpty) return primaryText;
    if (primaryText.isEmpty) return secondaryText;
    return '$primaryText، $secondaryText';
  }

  @override
  List<Object?> get props => [placeId, primaryText, secondaryText, description];
}

class PlaceDetails {
  const PlaceDetails({
    required this.placeId,
    required this.name,
    required this.formattedAddress,
    required this.latitude,
    required this.longitude,
  });

  final String placeId;
  final String name;
  final String formattedAddress;
  final double latitude;
  final double longitude;

  String get label {
    if (name.isNotEmpty &&
        formattedAddress.isNotEmpty &&
        name != formattedAddress) {
      return '$name\n$formattedAddress';
    }
    return formattedAddress.isNotEmpty ? formattedAddress : name;
  }
}
