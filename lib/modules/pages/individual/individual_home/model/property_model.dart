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
  final String typeId;

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

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    final locationData =
        json['location'] as Map<String, dynamic>?;

    return PropertyModel(
      id: json['propertyId']?.toString() ?? '',
      title: json['title']?.toString() ?? '',

      // Build a readable location from the nested location object
      location: _buildLocation(locationData),

      imageUrl: json['mainImage']?.toString() ?? '',

      beds: _toInt(json['bedrooms']),
      baths: _toInt(json['bathrooms']),

      // API: totalArea: 130
      area: json['totalArea']?.toString() ?? '0',

      price: _toDouble(json['price']),

      // You can change this depending on what you want to display
      tag: json['status']?.toString() ?? '',

      isBookmarked: false,

      // SALE => true, RENT => false
      isForSale:
          json['listingType']?.toString().toUpperCase() == 'SALE',

      // APARTMENT, VILLA, etc.
      typeId: json['type']?.toString() ?? '',
    );
  }

  static String _buildLocation(Map<String, dynamic>? location) {
    if (location == null) return '';

    final district = location['district']?.toString() ?? '';
    final city = location['city']?.toString() ?? '';

    if (district.isNotEmpty && city.isNotEmpty) {
      return '$district، $city';
    }

    return district.isNotEmpty ? district : city;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;

    if (value is int) return value;

    if (value is double) return value.toInt();

    return int.tryParse(value.toString()) ?? 0;
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;

    if (value is double) return value;

    if (value is int) return value.toDouble();

    return double.tryParse(value.toString()) ?? 0.0;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        imageUrl,
        beds,
        baths,
        area,
        price,
        tag,
        isBookmarked,
        isForSale,
        typeId,
      ];
}