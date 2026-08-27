import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/property_filter_model.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    // ignore: prefer_const_constructors
    on<FilterInitialised>(_onInitialised);
    on<FilterSaleTypeChanged>(_onSaleTypeChanged);
    on<FilterPropertyTypeChanged>(_onPropertyTypeChanged);
    on<FilterPriceRangeChanged>(_onPriceRangeChanged);
    on<FilterPaymentSystemChanged>(_onPaymentSystemChanged);
    on<FilterDurationChanged>(_onDurationChanged);
    on<FilterCityChanged>(_onCityChanged);
    on<FilterApplied>(_onApplied);
  }

  final TextEditingController cityController = TextEditingController();

  FilterUpdated get _current {
    final s = state;
    if (s is FilterUpdated) return s;
    return const FilterUpdated(
      isForSale: true,
      typeId: null,
      minPrice: PropertyFilterModel.kMinPrice,
      maxPrice: PropertyFilterModel.kMaxPrice,
      paymentSystem: null,
      duration: null,
      city: null,
    );
  }

  void _onInitialised(FilterInitialised event, Emitter<FilterState> emit) {
    final f = event.initialFilter ?? const PropertyFilterModel();
    cityController.text = f.city ?? '';
    emit(FilterUpdated(
      isForSale: f.isForSale,
      typeId: f.propertyTypeId,
      minPrice: f.minPrice,
      maxPrice: f.maxPrice,
      paymentSystem: f.paymentSystem,
      duration: f.isForSale ? null : f.duration,
      city: f.city,
    ));
  }

  void _onSaleTypeChanged(
      FilterSaleTypeChanged event, Emitter<FilterState> emit) {
    emit(_current.copyWith(
      isForSale: event.isForSale,
      duration: event.isForSale ? null : _current.duration,
    ));
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

  void _onCityChanged(FilterCityChanged event, Emitter<FilterState> emit) {
    emit(_current.copyWith(city: event.city));
  }

  void _onApplied(FilterApplied event, Emitter<FilterState> emit) {
    final model = _current.copyWith(city: cityController.text).asModel;
    emit(FilterApplyRequested(filter: model));
    emit(_current.copyWith(city: cityController.text));
  }

  @override
  Future<void> close() {
    cityController.dispose();
    return super.close();
  }
}
