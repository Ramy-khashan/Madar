import 'package:equatable/equatable.dart';

 
class RatePropertyRequestModel extends Equatable {
  final String id;
  final String title;
  final String requestNumber;
  final String type; // 'certified' | 'estimated'
  final String requestDate;
  final String status;
  final double? estimatedValue;

  const RatePropertyRequestModel({
    required this.id,
    required this.title,
    required this.requestNumber,
    required this.type,
    required this.requestDate,
    required this.status,
    this.estimatedValue,
  });

  @override
  List<Object?> get props =>
      [id, title, requestNumber, type, requestDate, status, estimatedValue];
}

class RatePropertyCompanyModel extends Equatable {
  final String id;
  final String name;
  final double rating;
  final int reviewsCount;
  final String workDays;
  final double price;

  const RatePropertyCompanyModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviewsCount,
    required this.workDays,
    required this.price,
  });

  @override
  List<Object?> get props =>
      [id, name, rating, reviewsCount, workDays, price];
}

class RatePropertyUploadedFile extends Equatable {
  final String name;
  final double sizeKb;

  const RatePropertyUploadedFile({
    required this.name,
    required this.sizeKb,
  });

  @override
  List<Object?> get props => [name, sizeKb];
}
