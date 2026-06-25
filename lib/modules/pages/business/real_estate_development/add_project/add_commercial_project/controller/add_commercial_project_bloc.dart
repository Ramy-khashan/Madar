import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/constants/app_enums.dart';

part 'add_commercial_project_event.dart';
part 'add_commercial_project_state.dart';

class AddCommercialProjectBloc
    extends Bloc<AddCommercialProjectEvent, AddCommercialProjectState> {
  AddCommercialProjectBloc() : super(const AddCommercialProjectState()) {
    on<AddCommercialPropertyTypeChanged>(_onPropertyTypeChanged);
    on<AddCommercialAreaTypeChanged>(_onAreaTypeChanged);
    on<AddCommercialPickDateRequested>(_onPickDateRequested);
    on<AddCommercialDatePicked>(_onDatePicked);
    on<AddCommercialDatePickCancelled>(_onDatePickCancelled);
    on<AddCommercialSendToManagerRequested>(_onSendToManagerRequested);
    on<AddCommercialManagerLoginResult>(_onManagerLoginResult);
    on<AddCommercialSuccessDialogDismissed>(_onSuccessDialogDismissed);
    on<AddCommercialSubmit>(_onSubmit);
    on<AddCommercialReset>(_onReset);
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final unitsController = TextEditingController();
  final parkingController = TextEditingController();
  final budgetController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final tenantsController = TextEditingController();

  @override
  Future<void> close() {
    nameController.dispose();
    locationController.dispose();
    unitsController.dispose();
    parkingController.dispose();
    budgetController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    tenantsController.dispose();
    return super.close();
  }

  void _onPropertyTypeChanged(
    AddCommercialPropertyTypeChanged event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    emit(state.copyWith(selectedPropertyType: event.propertyType));
  }

  void _onAreaTypeChanged(
    AddCommercialAreaTypeChanged event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    emit(state.copyWith(selectedAreaType: event.areaType));
  }

  void _onPickDateRequested(
    AddCommercialPickDateRequested event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    emit(state.copyWith(pendingDateField: event.field));
  }

  void _onDatePicked(
    AddCommercialDatePicked event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    if (event.field == CommercialDateField.start) {
      startDateController.text = event.date;
    } else {
      endDateController.text = event.date;
    }
    emit(state.copyWith(pendingDateField: CommercialDateField.none));
  }

  void _onDatePickCancelled(
    AddCommercialDatePickCancelled event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    emit(state.copyWith(pendingDateField: CommercialDateField.none));
  }

  void _onSendToManagerRequested(
    AddCommercialSendToManagerRequested event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    emit(
      state.copyWith(dialogAction: CommercialDialogAction.showManagerLogin),
    );
  }

  void _onManagerLoginResult(
    AddCommercialManagerLoginResult event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    emit(
      state.copyWith(
        dialogAction: event.success
            ? CommercialDialogAction.showSuccess
            : CommercialDialogAction.none,
      ),
    );
  }

  void _onSuccessDialogDismissed(
    AddCommercialSuccessDialogDismissed event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    emit(state.copyWith(dialogAction: CommercialDialogAction.none));
  }

  Future<void> _onSubmit(
    AddCommercialSubmit event,
    Emitter<AddCommercialProjectState> emit,
  ) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    emit(state.copyWith(submitStatus: RequestStatus.loading));
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(submitStatus: RequestStatus.success));
  }

  void _onReset(
    AddCommercialReset event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    emit(const AddCommercialProjectState());
  }
}
