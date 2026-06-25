import 'package:equatable/equatable.dart';

class AuctionDepositTypeModel extends Equatable {
  const AuctionDepositTypeModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.features,
    this.isRecommended = false,
  });

  final String id;
  final String name;
  final double amount;
  final List<String> features;
  final bool isRecommended;

  @override
  List<Object?> get props => [id, name, amount, features, isRecommended];
}

enum AuctionDepositStep { paymentSelection, processing, success }

