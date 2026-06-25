import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../../property_file/model/property_file_model.dart';

part 'unit_details_event.dart';
part 'unit_details_state.dart';

class UnitDetailsBloc extends Bloc<UnitDetailsEvent, UnitDetailsState> {
  UnitDetailsBloc() : super(const UnitDetailsState()) {
    on<UnitDetailsInit>(_onInit);
    on<UnitDetailsStatusToggled>(_onStatusToggled);
    on<UnitDetailsDateTypeToggled>(_onDateTypeToggled);
    on<UnitDetailsExpenseAdded>(_onExpenseAdded);
    on<UnitDetailsExpenseRemoved>(_onExpenseRemoved);
    on<UnitDetailsSaved>(_onSaved);
    on<UnitDetailsDeleted>(_onDeleted);
    on<UnitDetailsSentToBroker>(_onSentToBroker);
  }

  // Text controllers owned by the BLoC, disposed on close
  final TextEditingController tenantNameController = TextEditingController();
  final TextEditingController tenantPhoneController = TextEditingController();
  final TextEditingController rentStartController = TextEditingController();
  final TextEditingController rentEndController = TextEditingController();
  final TextEditingController expenseDescController = TextEditingController();
  final TextEditingController expenseAmountController = TextEditingController();

  static UnitDetailsBloc get(BuildContext context) =>
      context.read<UnitDetailsBloc>();

  void _onInit(UnitDetailsInit event, Emitter<UnitDetailsState> emit) {
    tenantNameController.text = event.unit.tenantName;
    tenantPhoneController.text = event.unit.tenantPhone;
    rentStartController.text = event.unit.rentStartDate;
    rentEndController.text = event.unit.rentEndDate;
    emit(state.copyWith(unit: event.unit));
  }

  void _onStatusToggled(
    UnitDetailsStatusToggled event,
    Emitter<UnitDetailsState> emit,
  ) {
    final u = state.unit;
    if (u == null) return;
    emit(state.copyWith(unit: u.copyWith(status: event.status)));
  }

  void _onDateTypeToggled(
    UnitDetailsDateTypeToggled event,
    Emitter<UnitDetailsState> emit,
  ) {
    final u = state.unit;
    if (u == null) return;
    emit(state.copyWith(unit: u.copyWith(isHijriDate: event.isHijri)));
  }

  void _onExpenseAdded(
    UnitDetailsExpenseAdded event,
    Emitter<UnitDetailsState> emit,
  ) {
    final u = state.unit;
    if (u == null) return;
    final updated = List<UnitExpenseModel>.from(u.expenses)
      ..add(UnitExpenseModel(
        description: event.description,
        amount: event.amount,
      ));
    emit(state.copyWith(unit: u.copyWith(expenses: updated)));
    expenseDescController.clear();
    expenseAmountController.clear();
  }

  void _onExpenseRemoved(
    UnitDetailsExpenseRemoved event,
    Emitter<UnitDetailsState> emit,
  ) {
    final u = state.unit;
    if (u == null) return;
    final updated = List<UnitExpenseModel>.from(u.expenses)..removeAt(event.index);
    emit(state.copyWith(unit: u.copyWith(expenses: updated)));
  }

  Future<void> _onSaved(
    UnitDetailsSaved event,
    Emitter<UnitDetailsState> emit,
  ) async {
    emit(state.copyWith(saveStatus: RequestStatus.loading));
    await Future.delayed(const Duration(milliseconds: 600));
    final u = state.unit;
    if (u == null) {
      emit(state.copyWith(saveStatus: RequestStatus.failed));
      return;
    }
    emit(state.copyWith(
      unit: u.copyWith(
        tenantName: tenantNameController.text,
        tenantPhone: tenantPhoneController.text,
        rentStartDate: rentStartController.text,
        rentEndDate: rentEndController.text,
      ),
      saveStatus: RequestStatus.success,
    ));
  }

  void _onDeleted(
    UnitDetailsDeleted event,
    Emitter<UnitDetailsState> emit,
  ) {
    emit(state.copyWith(isDeleted: true));
  }

  void _onSentToBroker(
    UnitDetailsSentToBroker event,
    Emitter<UnitDetailsState> emit,
  ) {
    emit(state.copyWith(isSentToBroker: true));
  }

  @override
  Future<void> close() {
    tenantNameController.dispose();
    tenantPhoneController.dispose();
    rentStartController.dispose();
    rentEndController.dispose();
    expenseDescController.dispose();
    expenseAmountController.dispose();
    return super.close();
  }
}
