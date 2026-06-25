import 'package:equatable/equatable.dart';

class BusinessPortfolioPropertyModel extends Equatable {
  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final String status;
  final String typeId;
  final int contractNumber;
  final int occupancyRate;
  final String lastUpdate;
  final bool isForSale;

  const BusinessPortfolioPropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,

    this.typeId = '',
    required this.contractNumber,
    required this.occupancyRate,
    required this.lastUpdate,
    this.isForSale = true,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    location,
    imageUrl,
    status,
    contractNumber,
    occupancyRate,
    lastUpdate,

    typeId,
    isForSale,
  ];
}
