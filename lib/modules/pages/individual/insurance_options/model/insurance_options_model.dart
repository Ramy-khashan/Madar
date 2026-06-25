import 'package:equatable/equatable.dart';

class InsuranceTypeModel extends Equatable {
  final String id;
  final String name;
  final double pricePerYear;
  final List<String> coverages;
  final bool isRecommended;

  const InsuranceTypeModel({
    required this.id,
    required this.name,
    required this.pricePerYear,
    required this.coverages,
    this.isRecommended = false,
  });

  @override
  List<Object?> get props => [id, name, pricePerYear, coverages, isRecommended];
}

class InsuranceCompanyModel extends Equatable {
  final String id;
  final String name;
  final double rating;
  final int processingHours;
  final int discountPercent;

  const InsuranceCompanyModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.processingHours,
    required this.discountPercent,
  });

  @override
  List<Object?> get props => [id, name, rating, processingHours, discountPercent];
}
