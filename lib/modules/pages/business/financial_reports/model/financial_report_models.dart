import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FinancialPropertyItem extends Equatable {
  const FinancialPropertyItem({
    required this.name,
    required this.amount,
    required this.paid,
    required this.status,    required this.date,
  });

  final String name;
  final String amount;
  final bool paid;
  final String status;
  final DateTime date;

  @override
  List<Object?> get props => [name, amount, paid, status, date];
}

class FinancialRentItem extends Equatable {
  const FinancialRentItem({
    required this.name,
    required this.amount,
    required this.date,
    required this.status,
    required this.paid,
  });

  final String name;
  final String amount;
  final DateTime date;
  final String status;
  final bool paid;

  @override
  List<Object?> get props => [name, amount, date, status, paid];
}

class FinancialTransaction extends Equatable {
  const FinancialTransaction({
    required this.name,
    required this.date,
    required this.desc,
    required this.amount,
  });

  final String name;
  final DateTime date;
  final String desc;
  final String amount;

  @override
  List<Object?> get props => [name, date, desc, amount];
}

class FinancialTenant extends Equatable {
  const FinancialTenant({
    required this.name,
    required this.property,
    required this.amount,
    required this.days,
  });

  final String name;
  final String property;
  final String amount;
  final String days;

  @override
  List<Object?> get props => [name, property, amount, days];
}

class FinancialSettlement extends Equatable {
  const FinancialSettlement({
    required this.label,
    required this.date,
    required this.amount,
    required this.status,
  });

  final String label;
  final DateTime date;
  final String amount;
  final String status;

  bool get isCompleted => status == 'مكتملة';

  @override
  List<Object?> get props => [label, date, amount, status];
}

class DonutSectionData extends Equatable {
  const DonutSectionData({
    required this.label,
    required this.value,
    required this.colorValue,
  });

  final String label;
  final double value;
  final int colorValue;

  Color get color => Color(colorValue);

  @override
  List<Object?> get props => [label, value, colorValue];
}
