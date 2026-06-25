import 'package:equatable/equatable.dart';

/// Represents a broker or owner profile shown in the listing header.
class PropertyListingUserModel extends Equatable {
  const PropertyListingUserModel({
    required this.name,
    required this.rating,
    required this.reviewsCount,
    required this.propertiesCount,
    this.imageUrl,
  });

  final String name;
  final double rating;
  final int reviewsCount;
  final int propertiesCount;
  final String? imageUrl;

  @override
  List<Object?> get props => [
        name,
        rating,
        reviewsCount,
        propertiesCount,
        imageUrl,
      ];
}
