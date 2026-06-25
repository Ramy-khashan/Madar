import 'package:equatable/equatable.dart';

class BrokerModel extends Equatable {
  const BrokerModel({
    required this.id,
    required this.name,
    required this.licenseNumber,
    required this.rating,
    required this.reviewsCount,
    required this.propertiesCount,
    required this.location,
    required this.experienceYears,
    required this.commissionPercent,
    required this.description,
    this.imageUrl = '',
  });

  final String id;
  final String name;
  final String licenseNumber;
  final double rating;
  final int reviewsCount;
  final int propertiesCount;
  final String location;
  final int experienceYears;
  final double commissionPercent;
  final String description;
  final String imageUrl;

  @override
  List<Object?> get props => [
        id, name, licenseNumber, rating, reviewsCount, propertiesCount,
        location, experienceYears, commissionPercent, description, imageUrl,
      ];
}
