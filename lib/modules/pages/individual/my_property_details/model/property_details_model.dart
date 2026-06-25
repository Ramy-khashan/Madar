import 'package:equatable/equatable.dart';

class ContractModel extends Equatable {
  final String id;
  final String tenantName;
  final double monthlyRent;
  final String startDate;
  final String endDate;
  final String status;

  const ContractModel({
    required this.id,
    required this.tenantName,
    required this.monthlyRent,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenantName': tenantName,
      'monthlyRent': monthlyRent,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      id: json['id'] as String,
      tenantName: json['tenantName'] as String,
      monthlyRent: (json['monthlyRent'] as num).toDouble(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      status: json['status'] as String,
    );
  }

  @override
  List<Object?> get props => [
    id,
    tenantName,
    monthlyRent,
    startDate,
    endDate,
    status,
  ];
}

class FinancialMonthData extends Equatable {
  final String month;
  final double income;
  final double expenses;

  const FinancialMonthData({
    required this.month,
    required this.income,
    required this.expenses,
  });

  double get netProfit => income - expenses;

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'income': income,
      'expenses': expenses,
    };
  }

  factory FinancialMonthData.fromJson(Map<String, dynamic> json) {
    return FinancialMonthData(
      month: json['month'] as String,
      income: (json['income'] as num).toDouble(),
      expenses: (json['expenses'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [month, income, expenses];
}

class PropertyDetailsModel extends Equatable {
  final String id;
  final String title;
  final String location;
  final List<String> imageUrls;
  final int beds;
  final int balconies;
  final int baths;
  final String area;
  final int floor;
  final String propertyNumber;
  final String paymentMethod;
  final String tag;
  final bool isBookmarked;
  final double occupancyRate;
  final List<ContractModel> contracts;
  final double totalIncome;
  final double totalExpenses;
  final List<FinancialMonthData> monthlyFinancials;

  const PropertyDetailsModel({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrls,
    required this.beds,
    required this.balconies,
    required this.baths,
    required this.area,
    required this.floor,
    required this.propertyNumber,
    required this.paymentMethod,
    required this.tag,
    this.isBookmarked = false,
    required this.occupancyRate,
    required this.contracts,
    required this.totalIncome,
    required this.totalExpenses,
    required this.monthlyFinancials,
  });

  double get netProfit => totalIncome - totalExpenses;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'imageUrls': imageUrls,
      'beds': beds,
      'balconies': balconies,
      'baths': baths,
      'area': area,
      'floor': floor,
      'propertyNumber': propertyNumber,
      'paymentMethod': paymentMethod,
      'tag': tag,
      'isBookmarked': isBookmarked,
      'occupancyRate': occupancyRate,
      'contracts': contracts.map((c) => c.toJson()).toList(),
      'totalIncome': totalIncome,
      'totalExpenses': totalExpenses,
      'monthlyFinancials': monthlyFinancials.map((m) => m.toJson()).toList(),
    };
  }

  factory PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    return PropertyDetailsModel(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      imageUrls: List<String>.from(json['imageUrls'] as List),
      beds: json['beds'] as int,
      balconies: json['balconies'] as int,
      baths: json['baths'] as int,
      area: json['area'] as String,
      floor: json['floor'] as int,
      propertyNumber: json['propertyNumber'] as String,
      paymentMethod: json['paymentMethod'] as String,
      tag: json['tag'] as String,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      occupancyRate: (json['occupancyRate'] as num).toDouble(),
      contracts: (json['contracts'] as List)
          .map((c) => ContractModel.fromJson(c as Map<String, dynamic>))
          .toList(),
      totalIncome: (json['totalIncome'] as num).toDouble(),
      totalExpenses: (json['totalExpenses'] as num).toDouble(),
      monthlyFinancials: (json['monthlyFinancials'] as List)
          .map((m) => FinancialMonthData.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    location,
    imageUrls,
    beds,
    balconies,
    baths,
    area,
    floor,
    propertyNumber,
    paymentMethod,
    tag,
    isBookmarked,
    occupancyRate,
    contracts,
    totalIncome,
    totalExpenses,
    monthlyFinancials,
  ];
}
