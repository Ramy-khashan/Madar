part of 'filter_bloc.dart';

sealed class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

/// Initialise the sheet with an optional existing filter.
final class FilterInitialised extends FilterEvent {
  const FilterInitialised({this.initialFilter});
  final PropertyFilterModel? initialFilter;
  @override
  List<Object> get props => [?initialFilter];
}

final class FilterSaleTypeChanged extends FilterEvent {
  const FilterSaleTypeChanged({required this.isForSale});
  final bool isForSale;
  @override
  List<Object> get props => [isForSale];
}

final class FilterPropertyTypeChanged extends FilterEvent {
  const FilterPropertyTypeChanged({required this.typeId});
  final String? typeId;
  @override
  List<Object> get props => [?typeId];
}

final class FilterPriceRangeChanged extends FilterEvent {
  const FilterPriceRangeChanged({
    required this.minPrice,
    required this.maxPrice,
  });
  final double minPrice;
  final double maxPrice;
  @override
  List<Object> get props => [minPrice, maxPrice];
}

final class FilterPaymentSystemChanged extends FilterEvent {
  const FilterPaymentSystemChanged({required this.paymentSystem});
  final String? paymentSystem;
  @override
  List<Object> get props => [?paymentSystem];
}

final class FilterDurationChanged extends FilterEvent {
  const FilterDurationChanged({required this.duration});
  final String? duration;
  @override
  List<Object> get props => [?duration];
}

/// Fired when the user taps Apply — triggers the onApply callback upstream.
final class FilterApplied extends FilterEvent {
  const FilterApplied();
}
