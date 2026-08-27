import 'package:equatable/equatable.dart';

class PropertyFilterModel extends Equatable {
  final bool isForSale;
  final String? propertyTypeId; // null = all types
  final double minPrice;
  final double maxPrice;
  final String? paymentSystem; // null = any
  final String? duration; // null = any
  final String? city;

  static const double kMinPrice = 0;
  static const double kMaxPrice = 5000000;

  const PropertyFilterModel({
    this.isForSale = true,
    this.propertyTypeId,
    this.minPrice = kMinPrice,
    this.maxPrice = kMaxPrice,
    this.paymentSystem,
    this.duration,
    this.city,
  });

  String get listingType => isForSale ? 'SALE' : 'RENT';

  bool get isActive =>
      !isForSale ||
      propertyTypeId != null ||
      minPrice > kMinPrice ||
      maxPrice < kMaxPrice ||
      paymentSystem != null ||
      duration != null ||
      (city ?? '').trim().isNotEmpty;

  Map<String, dynamic> toQuery({
    required int page,
    required int pageSize,
    String? title,
  }) {
    final query = <String, dynamic>{
      'page': page,
      'limit': pageSize,
      'listingType': listingType,
    };
    final type = propertyTypeId?.trim() ?? '';
    if (type.isNotEmpty) query['type'] = type;
    final cityValue = city?.trim() ?? '';
    if (cityValue.isNotEmpty) query['city'] = cityValue;
    if (minPrice > kMinPrice) query['minPrice'] = minPrice.round();
    if (maxPrice < kMaxPrice) query['maxPrice'] = maxPrice.round();
    final search = title?.trim() ?? '';
    if (search.isNotEmpty) query['title'] = search;
    return query;
  }

  Map<String, dynamic> toMapQuery({
    required double latitude,
    required double longitude,
    required int page,
    String? title,
  }) {
    final query = toQuery(page: page, pageSize: 50, title: title);
    query['latitude'] = latitude;
    query['longitude'] = longitude;
    query.remove('limit');
    return query;
  }

  PropertyFilterModel copyWith({
    bool? isForSale,
    Object? propertyTypeId = _sentinel,
    double? minPrice,
    double? maxPrice,
    Object? paymentSystem = _sentinel,
    Object? duration = _sentinel,
    Object? city = _sentinel,
  }) {
    return PropertyFilterModel(
      isForSale: isForSale ?? this.isForSale,
      propertyTypeId:
          propertyTypeId == _sentinel
              ? this.propertyTypeId
              : propertyTypeId as String?,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      paymentSystem:
          paymentSystem == _sentinel
              ? this.paymentSystem
              : paymentSystem as String?,
      duration:
          duration == _sentinel ? this.duration : duration as String?,
      city: city == _sentinel ? this.city : city as String?,
    );
  }

  @override
  List<Object?> get props => [
    isForSale,
    propertyTypeId,
    minPrice,
    maxPrice,
    paymentSystem,
    duration,
    city,
  ];
}

const Object _sentinel = Object();
