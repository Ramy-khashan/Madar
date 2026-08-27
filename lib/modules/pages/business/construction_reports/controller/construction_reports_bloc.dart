import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/apis/dashboard_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../model/performance_report_model.dart';

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

  Future<void> _onLoad(
    ConstructionReportsLoad event,
    Emitter<ConstructionReportsState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, errorMessage: ''));
    final result = await DashboardApis.performance(
      period: state.selectedPeriod,
      scope: state.selectedScope,
      propertyTypes: state.selectedPropertyTypeIds,
    );
    result.fold(
      (err) =>
          emit(state.copyWith(status: RequestStatus.failed, errorMessage: err)),
      (payload) {
        final report = PerformanceReportModel.fromJson(payload);
        emit(
          state.copyWith(
            status: RequestStatus.success,
            errorMessage: '',
            report: report,
          ),
        );
      },
    );
  }

  void _onPeriodChanged(
    ConstructionReportsPeriodChanged event,
    Emitter<ConstructionReportsState> emit,
  ) {
    emit(state.copyWith(selectedPeriod: event.period));
    add(const ConstructionReportsLoad());
  }

  void _onScopeChanged(
    ConstructionReportsScopeChanged event,
    Emitter<ConstructionReportsState> emit,
  ) {
    emit(state.copyWith(selectedScope: event.scope));
    add(const ConstructionReportsLoad());
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
    add(const ConstructionReportsLoad());
  }
}
