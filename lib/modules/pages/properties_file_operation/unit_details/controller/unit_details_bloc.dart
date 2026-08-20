import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/apis/property_file_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
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
    on<UnitDetailsExpenseFilesPicked>(_onExpenseFilesPicked);
    on<UnitDetailsSaved>(_onSaved);
    on<UnitDetailsDeleted>(_onDeleted);
    on<UnitDetailsSentToBroker>(_onSentToBroker);
  }

  final TextEditingController tenantNameController = TextEditingController();
  final TextEditingController tenantPhoneController = TextEditingController();
  final TextEditingController rentStartController = TextEditingController();
  final TextEditingController rentEndController = TextEditingController();
  final TextEditingController expenseDescController = TextEditingController();
  final TextEditingController expenseAmountController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController projectNameController = TextEditingController();

  static UnitDetailsBloc get(BuildContext context) =>
      context.read<UnitDetailsBloc>();

  Future<void> _onInit(
    UnitDetailsInit event,
    Emitter<UnitDetailsState> emit,
  ) async {
    _syncControllers(event.unit);
    emit(
      state.copyWith(unit: event.unit, loadStatus: RequestStatus.loading),
    );
    if (event.unit.id.isEmpty) {
      emit(state.copyWith(loadStatus: RequestStatus.success));
      return;
    }
    final result = await PropertyFileApis.getProperty(event.unit.id);
    if (isClosed) return;
    result.fold(
      (error) {
        emit(
          state.copyWith(
            loadStatus: RequestStatus.success,
            errorMsg: error,
          ),
        );
      },
      (details) {
        final merged = UnitModel.fromDetails(details, base: event.unit);
        _syncControllers(merged);
        emit(state.copyWith(unit: merged, loadStatus: RequestStatus.success));
      },
    );
  }

  void _syncControllers(UnitModel unit) {
    tenantNameController.text = unit.tenantName;
    tenantPhoneController.text = unit.tenantPhone;
    rentStartController.text = unit.rentStartDate;
    rentEndController.text = unit.rentEndDate;
    titleController.text = unit.label;
    projectNameController.text = unit.projectName;
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
      ..add(
        UnitExpenseModel(
          description: event.description,
          amount: event.amount,
        ),
      );
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
    final updated = List<UnitExpenseModel>.from(u.expenses)
      ..removeAt(event.index);
    emit(state.copyWith(unit: u.copyWith(expenses: updated)));
  }

  void _onExpenseFilesPicked(
    UnitDetailsExpenseFilesPicked event,
    Emitter<UnitDetailsState> emit,
  ) {
    emit(state.copyWith(expenseFiles: [...state.expenseFiles, ...event.paths]));
  }

  Future<void> _onSaved(
    UnitDetailsSaved event,
    Emitter<UnitDetailsState> emit,
  ) async {
    final u = state.unit;
    if (u == null || u.id.isEmpty) {
      emit(state.copyWith(saveStatus: RequestStatus.failed));
      return;
    }
    emit(state.copyWith(saveStatus: RequestStatus.loading));
    final updatedUnit = u.copyWith(
      tenantName: tenantNameController.text,
      tenantPhone: tenantPhoneController.text,
      rentStartDate: rentStartController.text,
      rentEndDate: rentEndController.text,
      label: titleController.text.trim().isEmpty
          ? u.label
          : titleController.text.trim(),
      projectName: projectNameController.text.trim(),
    );

    final result = await PropertyFileApis.updateProperty(
      propertyId: u.id,
      title: updatedUnit.label,
      projectName: updatedUnit.projectName,
    );
    if (isClosed) return;

    await result.fold(
      (error) async {
        AppToast(error, isError: true);
        emit(state.copyWith(saveStatus: RequestStatus.failed));
      },
      (_) async {
        if (updatedUnit.expenses.any((e) => !e.isRemote) ||
            state.expenseFiles.isNotEmpty) {
          final expenseResult = await PropertyFileApis.saveExpenses(
            propertyId: u.id,
            expenses: updatedUnit.expenses.where((e) => !e.isRemote).toList(),
            filePaths: state.expenseFiles,
          );
          expenseResult.fold(
            (error) => AppToast(error, isError: true),
            (_) {},
          );
        }
        emit(
          state.copyWith(
            unit: updatedUnit,
            saveStatus: RequestStatus.success,
            expenseFiles: const [],
          ),
        );
        AppToast(AppStrings.propertyUpdated);
      },
    );
  }

  Future<void> _onDeleted(
    UnitDetailsDeleted event,
    Emitter<UnitDetailsState> emit,
  ) async {
    final id = state.unit?.id ?? '';
    if (id.isEmpty) return;
    final result = await PropertyFileApis.deleteProperty(id);
    result.fold(
      (error) => AppToast(error, isError: true),
      (_) => emit(state.copyWith(isDeleted: true)),
    );
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
    titleController.dispose();
    projectNameController.dispose();
    return super.close();
  }
}
