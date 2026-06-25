 import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/property_filter_model.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<FilterInitialised>(_onInitialised);
    on<FilterSaleTypeChanged>(_onSaleTypeChanged);
    on<FilterPropertyTypeChanged>(_onPropertyTypeChanged);
    on<FilterPriceRangeChanged>(_onPriceRangeChanged);
    on<FilterPaymentSystemChanged>(_onPaymentSystemChanged);
    on<FilterDurationChanged>(_onDurationChanged);
    on<FilterApplied>(_onApplied);
  }

  FilterUpdated get _current {
    final s = state;
    if (s is FilterUpdated) return s;
    return FilterUpdated(
      isForSale: true,
      typeId: null,
      minPrice: PropertyFilterModel.kMinPrice,
      maxPrice: PropertyFilterModel.kMaxPrice,
      paymentSystem: null,
      duration: null,
    );
  }

  void _onInitialised(FilterInitialised event, Emitter<FilterState> emit) {
    final f = event.initialFilter ?? const PropertyFilterModel();
    emit(FilterUpdated(
      isForSale: f.isForSale,
      typeId: f.propertyTypeId,
      minPrice: f.minPrice,
      maxPrice: f.maxPrice,
      paymentSystem: f.paymentSystem,
      duration: f.duration,
    ));
  }

  void _onSaleTypeChanged(
      FilterSaleTypeChanged event, Emitter<FilterState> emit) {
    emit(_current.copyWith(isForSale: event.isForSale));
  }

  void _onPropertyTypeChanged(
      FilterPropertyTypeChanged event, Emitter<FilterState> emit) {
    emit(_current.copyWith(typeId: event.typeId));
  }

  void _onPriceRangeChanged(
      FilterPriceRangeChanged event, Emitter<FilterState> emit) {
    emit(_current.copyWith(
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
    ));
  }

  void _onPaymentSystemChanged(
      FilterPaymentSystemChanged event, Emitter<FilterState> emit) {
    emit(_current.copyWith(paymentSystem: event.paymentSystem));
  }

  void _onDurationChanged(
      FilterDurationChanged event, Emitter<FilterState> emit) {
    emit(_current.copyWith(duration: event.duration));
  }

  void _onApplied(FilterApplied event, Emitter<FilterState> emit) {
    emit(FilterApplyRequested(filter: _current.asModel));
    // Restore updated state so the sheet remains usable if re-opened.
    emit(_current);
  }
}
