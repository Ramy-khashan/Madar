import 'package:equatable/equatable.dart';

class PortfolioPropertyModel extends Equatable {
  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final String status;
  final String typeId;
  final int bed;
  final int bath;
  final String area;
  final bool isForSale;

  const PortfolioPropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,

    this.typeId = '',
    required this.bed,
    required this.bath,
    required this.area,
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
    bed,
    bath,
    area,

    typeId,
    isForSale,
  ];
}
