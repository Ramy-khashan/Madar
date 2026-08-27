import 'package:equatable/equatable.dart';

import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/translation.dart';

class ContractDetailsModel extends Equatable {
  const ContractDetailsModel({
    required this.id,
    required this.contractNo,
    required this.title,
    required this.propertyName,
    required this.location,
    required this.tenantName,
    required this.ownerName,
    required this.brokerName,
    required this.status,
    this.statusLabel = '',
    required this.type,
    this.typeLabel = '',
    required this.startDate,
    required this.endDate,
    required this.paymentCycle,
    required this.securityDeposit,
    required this.annualRent,
    required this.monthlyRent,
    required this.totalContractValue,
    required this.terms,
    required this.attachments,
    this.commissionAmount = 0,
    this.createdAt = '',
  });

  final String id;
  final String contractNo;
  final String title;
  final String propertyName;
  final String location;
  final String tenantName;
  final String ownerName;
  final String brokerName;
  final String status;
  final String statusLabel;
  final String type;
  final String typeLabel;
  final String startDate;
  final String endDate;
  final String paymentCycle;
  final double securityDeposit;
  final double annualRent;
  final double monthlyRent;
  final double totalContractValue;
  final String terms;
  final List<String> attachments;
  final double commissionAmount;
  final String createdAt;

  bool get isPending => status.toUpperCase() == 'PENDING';
  bool get isActive => status.toUpperCase() == 'ACTIVE';
  bool get isRent {
    final value = type.toUpperCase();
    return value.contains('RENT');
  }

  @override
  List<Object?> get props => [
    id,
    contractNo,
    title,
    propertyName,
    location,
    tenantName,
    ownerName,
    brokerName,
    status,
    statusLabel,
    type,
    typeLabel,
    startDate,
    endDate,
    paymentCycle,
    securityDeposit,
    annualRent,
    monthlyRent,
    totalContractValue,
    terms,
    attachments,
    commissionAmount,
    createdAt,
  ];

  factory ContractDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'] as Map)
        : json;
    final buyer = _asMap(data['buyer']);
    final seller = _asMap(data['seller']);
    final broker = data['broker'];
    final brokerMap = _asMap(broker);
    final property = _asMap(data['property']);
    final price = _asDouble(data['price'] ?? property['price']);
    final commission = _asDouble(data['commissionAmount']);

    return ContractDetailsModel(
      id: _text(data['id'] ?? data['contractId']),
      contractNo: _text(data['contractNo']),
      title: _text(data['contractNo'] ?? data['title']),
      propertyName: _text(property['title'] ?? property['projectName']),
      location: _locationFrom(property['location'] ?? data['location']),
      tenantName: _text(buyer['fullName']),
      ownerName: _text(seller['fullName']),
      brokerName: broker is String
          ? _text(broker)
          : _text(brokerMap['fullName']),
      status: _text(data['status']),
      statusLabel: _text(data['statusLabel']),
      type: _text(data['type']),
      typeLabel: _text(data['typeLabel'] ?? data['subLabel']),
      startDate: _text(data['startDate']),
      endDate: _text(data['endDate']),
      paymentCycle: _text(data['paymentCycle']),
      securityDeposit: commission,
      annualRent: price,
      monthlyRent: price / 12,
      totalContractValue: price,
      terms: _text(data['terms']),
      attachments: data['attachments'] is List
          ? List<String>.from(
              (data['attachments'] as List).map((e) => e.toString()),
            )
          : const [],
      commissionAmount: commission,
      createdAt: _text(data['createdAt']),
    );
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map) return Map<String, dynamic>.from(value);
    return const {};
  }

  static String _text(dynamic value) {
    if (value == null) return '';
    final text = value.toString().trim();
    if (text.isEmpty || text == 'null') return '';
    return text;
  }

  static double _asDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static String _locationFrom(dynamic value) {
    if (value == null) return '';
    if (value is String) return _text(value);
    if (value is Map) {
      final map = Map<String, dynamic>.from(value);
      return [
        _text(map['district']),
        _text(map['city']),
      ].where((e) => e.isNotEmpty).join('، ');
    }
    return '';
  }

  static String typeDisplay(String type, {String fallback = ''}) {
    if (fallback.trim().isNotEmpty) return fallback;
    return switch (type.toUpperCase()) {
      'SALE' || 'BUY' => AppStrings.buyType,
      'RENT' => AppStrings.rentLabel,
      'MONTHLYRENT' => AppStrings.monthlyRentType,
      'YEARLYRENT' => AppStrings.yearlyRentType,
      _ => type.transIfExists,
    };
  }
}
