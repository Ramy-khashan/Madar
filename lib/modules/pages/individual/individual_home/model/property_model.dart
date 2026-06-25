import 'package:equatable/equatable.dart';

class PropertyModel extends Equatable {
  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final int beds;
  final int baths;
  final String area;
  final double price;
  final String tag;
  final bool isBookmarked;
  final bool isForSale;
  final String typeId; // matches AppConstant.propertyTypes id

  const PropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.beds,
    required this.baths,
    required this.area,
    required this.price,
    this.tag = '',
    this.isBookmarked = false,
    this.isForSale = true,
    this.typeId = '',
  });

  @override
  List<Object?> get props =>
      [id, title, location, imageUrl, beds, baths, area, price, tag, isBookmarked, isForSale, typeId];
}

