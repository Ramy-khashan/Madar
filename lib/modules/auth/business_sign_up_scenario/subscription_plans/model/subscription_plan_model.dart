import 'package:equatable/equatable.dart';

class SubscriptionPlanModel extends Equatable {
  const SubscriptionPlanModel({
    required this.id,
    required this.badge,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.features,
  });

  final String id;
  final String badge;
  final double monthlyPrice;
  final double yearlyPrice;
  final List<String> features;

  @override
  List<Object?> get props => [id, badge, monthlyPrice, yearlyPrice, features];
}
