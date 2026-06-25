import 'package:equatable/equatable.dart';

class PropertyFilterModel extends Equatable {
  final bool isForSale;
  final String? propertyTypeId; // null = all types
  final double minPrice;
  final double maxPrice;
  final String? paymentSystem; // null = any
  final String? duration; // null = any

  static const double kMinPrice = 0;
  static const double kMaxPrice = 5000000;

  const PropertyFilterModel({
    this.isForSale = true,
    this.propertyTypeId,
    this.minPrice = kMinPrice,
    this.maxPrice = kMaxPrice,
    this.paymentSystem,
    this.duration,
  });

  bool get isActive =>
      !isForSale ||
      propertyTypeId != null ||
      minPrice > kMinPrice ||
      maxPrice < kMaxPrice ||
      paymentSystem != null ||
      duration != null;

  PropertyFilterModel copyWith({
    bool? isForSale,
    Object? propertyTypeId = _sentinel,
    double? minPrice,
    double? maxPrice,
    Object? paymentSystem = _sentinel,
    Object? duration = _sentinel,
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
    );
  }

  @override
  List<Object?> get props =>
      [isForSale, propertyTypeId, minPrice, maxPrice, paymentSystem, duration];
}

const Object _sentinel = Object();
