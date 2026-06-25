import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../model/property_file_model.dart';

part 'property_file_event.dart';
part 'property_file_state.dart';

class PropertyFileBloc extends Bloc<PropertyFileEvent, PropertyFileState> {
  PropertyFileBloc() : super(const PropertyFileState()) {
    on<PropertyFileLoad>(_onLoad);
    on<PropertyFileToggleBookmark>(_onToggleBookmark);
    on<PropertyFileFilterChanged>(_onFilterChanged);
    on<PropertyFileDeleteProperty>(_onDeleteProperty);
  }

  static PropertyFileBloc get(BuildContext context) =>
      context.read<PropertyFileBloc>();

  static final PropertyFileModel _sampleProperty = PropertyFileModel(
    id: '1',
    name: 'عمارة النرجس',
    location: 'النرجس-الرياض',
    imageUrl: AppImages.propertyImage,
    propertyType: 'عمارة سكنية',
    monthlyRevenue: 83500,
    occupancyRate: 83,
    isBookmarked: false,
    units: List.generate(12, (i) {
      final letters = ['A', 'B', 'C'];
      final letter = letters[i % 3];
      final num = (i ~/ 3) + 1;
      final number = '$letter$num';
      return UnitModel(
        id: 'unit_$i',
        number: number,
        label: 'شقة $number',
        status: i % 4 == 3 ? UnitStatus.vacant : UnitStatus.rented,
        area: 150,
        rooms: 3,
        bathrooms: 3,
        monthlyRent: 2400,
        floor: (i ~/ 3) + 1,
        tenantName: i % 4 != 3 ? 'فهد العتيبي' : '',
        tenantPhone: i % 4 != 3 ? '+966 83925478' : '',
        rentStartDate: i % 4 != 3 ? '15 صفر 1664' : '',
        rentEndDate: i % 4 != 3 ? '15 صفر 1664' : '',
        isHijriDate: true,
      );
    }),
  );

  Future<void> _onLoad(
    PropertyFileLoad event,
    Emitter<PropertyFileState> emit,
  ) async {
    emit(const PropertyFileState(status: RequestStatus.loading));
    await Future.delayed(const Duration(milliseconds: 400));
    emit(state.copyWith(
      property: _sampleProperty,
      status: RequestStatus.success,
    ));
  }

  void _onToggleBookmark(
    PropertyFileToggleBookmark event,
    Emitter<PropertyFileState> emit,
  ) {
    final p = state.property;
    if (p == null) return;
    emit(state.copyWith(property: p.copyWith(isBookmarked: !p.isBookmarked)));
  }

  void _onFilterChanged(
    PropertyFileFilterChanged event,
    Emitter<PropertyFileState> emit,
  ) {
    emit(state.copyWith(unitFilter: () => event.status));
  }

  void _onDeleteProperty(
    PropertyFileDeleteProperty event,
    Emitter<PropertyFileState> emit,
  ) {
    emit(state.copyWith(isDeleted: true));
  }
}
