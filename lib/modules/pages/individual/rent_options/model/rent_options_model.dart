import 'package:equatable/equatable.dart';

class InstallmentPlanModel extends Equatable {
  final String id;
  final int monthsCount;
  final double monthlyAmount;
  final double fees;

  const InstallmentPlanModel({
    required this.id,
    required this.monthsCount,
    required this.monthlyAmount,
    required this.fees,
  });

  @override
  List<Object?> get props => [id, monthsCount, monthlyAmount, fees];
}

class InstallmentProviderModel extends Equatable {
  final String id;
  final String name;
  final double rating;
  final int processingHours;

  const InstallmentProviderModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.processingHours,
  });

  @override
  List<Object?> get props => [id, name, rating, processingHours];
}
