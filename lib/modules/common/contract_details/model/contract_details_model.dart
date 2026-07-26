import 'package:equatable/equatable.dart';

import '../../../../core/utils/constants/app_strings.dart';

 
class ContractDetailsModel extends Equatable {
  const ContractDetailsModel({
    required this.id,
    required this.title,
    required this.propertyName,
    required this.location,
    required this.tenantName,
    required this.ownerName,
    required this.brokerName,
    required this.status,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.paymentCycle,
    required this.securityDeposit,
    required this.annualRent,
    required this.monthlyRent,
    required this.totalContractValue,
    required this.terms,
    required this.attachments,
  });

  final String id;
  final String title;
  final String propertyName;
  final String location;
  final String tenantName;
  final String ownerName;
  final String brokerName;
  final String status;
  final String type;
  final String startDate;
  final String endDate;
  final String paymentCycle;
  final double securityDeposit;
  final double annualRent;
  final double monthlyRent;
  final double totalContractValue;
  final  String terms;
  final List<String> attachments;

  @override
  List<Object?> get props => [
        id,
        title,
        propertyName,
        location,
        tenantName,
        ownerName,
        brokerName,
        status,
        type,
        startDate,
        endDate,
        paymentCycle,
        securityDeposit,
        annualRent,
        monthlyRent,
        totalContractValue,
        terms,
        attachments,
      ];

  factory ContractDetailsModel.fromJson(Map<String, dynamic> json) {
    final buyer = json['buyer'] as Map<String, dynamic>?;
    final seller = json['seller'] as Map<String, dynamic>?;
    final property = json['property'] as Map<String, dynamic>?;
    final price = (json['price'] ?? 0).toDouble();
    return ContractDetailsModel(
      id: json['id'] ?? '',
      title: json['contractNo'] ?? '',
      propertyName: property?['title'] ?? property?['projectName'] ?? '',
      location: property?['location'] ?? '',
      tenantName: buyer?['fullName'] ?? '',
      ownerName: seller?['fullName'] ?? '',
      brokerName: json['broker'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      paymentCycle: json['paymentCycle'] ?? '',
      securityDeposit: (json['commissionAmount'] ?? 0).toDouble(),
      annualRent: price,
      monthlyRent: price / 12,
      totalContractValue: price,
      terms: json['terms'] ?? '',
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }

  static String typeLabel(String type) {
    return switch (type) {
      'buy' => AppStrings.buyType,
      'monthlyRent' => AppStrings.monthlyRentType,
      'yearlyRent' => AppStrings.yearlyRentType,
      _ => type,
    };
  }
}
