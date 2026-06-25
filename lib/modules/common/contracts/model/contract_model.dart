import 'package:equatable/equatable.dart';
 

class ContractModel extends Equatable {
  final String id;
  final String title;
  final String propertyName;
  final String location;
  final double amount;
  final String date;
  final String status;
  final String type;

  const ContractModel({
    required this.id,
    required this.title,
    required this.propertyName,
    required this.location,
    required this.amount,
    required this.date,
    required this.status,
    required this.type,
  });

  @override
  List<Object?> get props =>
      [id, title, propertyName, location, amount, date, status, type];
}
