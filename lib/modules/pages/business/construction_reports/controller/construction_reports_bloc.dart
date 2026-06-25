import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';

part 'construction_reports_event.dart';
part 'construction_reports_state.dart';

class ConstructionReportsBloc
    extends Bloc<ConstructionReportsEvent, ConstructionReportsState> {
  ConstructionReportsBloc() : super(const ConstructionReportsState()) {
    on<ConstructionReportsLoad>(_onLoad);
    on<ConstructionReportsPeriodChanged>(_onPeriodChanged);
    on<ConstructionReportsScopeChanged>(_onScopeChanged);
    on<ConstructionReportsPropertyTypeToggled>(_onPropertyTypeToggled);
  }

  static ConstructionReportsBloc get(BuildContext context) =>
      context.read<ConstructionReportsBloc>();

  void _onLoad(
    ConstructionReportsLoad event,
    Emitter<ConstructionReportsState> emit,
  ) {
    emit(state.copyWith(status: RequestStatus.loading));
     emit(state.copyWith(status: RequestStatus.success));
  }

  void _onPeriodChanged(
    ConstructionReportsPeriodChanged event,
    Emitter<ConstructionReportsState> emit,
  ) {
    emit(state.copyWith(selectedPeriod: event.period));
  }

  void _onScopeChanged(
    ConstructionReportsScopeChanged event,
    Emitter<ConstructionReportsState> emit,
  ) {
    emit(state.copyWith(selectedScope: event.scope));
  }

  void _onPropertyTypeToggled(
    ConstructionReportsPropertyTypeToggled event,
    Emitter<ConstructionReportsState> emit,
  ) {
    final updated = List<String>.from(state.selectedPropertyTypeIds);
    if (updated.contains(event.typeId)) {
      updated.remove(event.typeId);
    } else {
      updated.add(event.typeId);
    }
    emit(state.copyWith(selectedPropertyTypeIds: updated));
  }
}
