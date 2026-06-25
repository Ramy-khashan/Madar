part of 'filter_bloc.dart';

sealed class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object?> get props => [];
}

final class FilterInitial extends FilterState {}

final class FilterUpdated extends FilterState {
  const FilterUpdated({
    required this.isForSale,
    required this.typeId,
    required this.minPrice,
    required this.maxPrice,
    required this.paymentSystem,
    required this.duration,
  });

  final bool isForSale;
  final String? typeId;
  final double minPrice;
  final double maxPrice;
  final String? paymentSystem;
  final String? duration;

  PropertyFilterModel get asModel => PropertyFilterModel(
        isForSale: isForSale,
        propertyTypeId: typeId,
        minPrice: minPrice,
        maxPrice: maxPrice,
        paymentSystem: paymentSystem,
        duration: duration,
      );

  FilterUpdated copyWith({
    bool? isForSale,
    Object? typeId = _sentinel,
    double? minPrice,
    double? maxPrice,
    Object? paymentSystem = _sentinel,
    Object? duration = _sentinel,
  }) {
    return FilterUpdated(
      isForSale: isForSale ?? this.isForSale,
      typeId: typeId == _sentinel ? this.typeId : typeId as String?,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      paymentSystem: paymentSystem == _sentinel
          ? this.paymentSystem
          : paymentSystem as String?,
      duration: duration == _sentinel ? this.duration : duration as String?,
    );
  }

  @override
  List<Object?> get props =>
      [isForSale, typeId, minPrice, maxPrice, paymentSystem, duration];
}

const Object _sentinel = Object();

/// Emitted once when Apply is tapped — the parent listens and closes the sheet.
final class FilterApplyRequested extends FilterState {
  const FilterApplyRequested({required this.filter});
  final PropertyFilterModel filter;
  @override
  List<Object> get props => [filter];
}
