import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/hijri_date_picker.dart';
import '../../../../../core/repository/apis/property_file_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/hijri_date.dart';
import '../../../individual/property_details/model/property_details_model.dart';
import '../../property_file/model/property_file_model.dart';

part 'unit_details_event.dart';
part 'unit_details_state.dart';

part 'mixins/unit_details_save_mixin.dart';

class UnitDetailsBloc extends Bloc<UnitDetailsEvent, UnitDetailsState>
    with UnitDetailsSaveMixin {
  UnitDetailsBloc() : super(const UnitDetailsState()) {
    on<UnitDetailsInit>(_onInit);
    on<UnitDetailsStatusToggled>(_onStatusToggled);
    on<UnitDetailsDateTypeToggled>(_onDateTypeToggled);
    on<UnitDetailsDatePicked>(_onDatePicked);
    on<UnitDetailsExpenseAdded>(_onExpenseAdded);
    on<UnitDetailsExpenseRemoved>(_onExpenseRemoved);
    on<UnitDetailsExpenseFilesPicked>(_onExpenseFilesPicked);
    on<UnitDetailsSaved>(_onSaved);
    on<UnitDetailsDeleted>(_onDeleted);
    on<UnitDetailsSentToBroker>(_onSentToBroker);
  }

  @override
  final TextEditingController tenantNameController = TextEditingController();
  @override
  final TextEditingController tenantPhoneController = TextEditingController();
  @override
  final TextEditingController rentStartController = TextEditingController();
  @override
  final TextEditingController rentEndController = TextEditingController();
  final TextEditingController expenseDescController = TextEditingController();
  final TextEditingController expenseAmountController = TextEditingController();
  @override
  final TextEditingController titleController = TextEditingController();
  @override
  final TextEditingController projectNameController = TextEditingController();
  @override
  final TextEditingController monthlyRentController = TextEditingController();

  static UnitDetailsBloc get(BuildContext context) =>
      context.read<UnitDetailsBloc>();

  Future<void> _onInit(
    UnitDetailsInit event,
    Emitter<UnitDetailsState> emit,
  ) async {
    syncControllers(event.unit);
    emit(
      state.copyWith(
        unit: event.unit.copyWith(buildingId: event.buildingId),
        buildingId: event.buildingId,
        loadStatus: RequestStatus.loading,
      ),
    );
    if (event.unit.id.isEmpty) {
      emit(state.copyWith(loadStatus: RequestStatus.success));
      return;
    }
    if (event.buildingId.isNotEmpty) {
      final result = await PropertyFileApis.getBuildingApartment(event.unit.id);
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
        (apartment) {
          final merged = UnitModel.fromBuildingApartment(apartment);
          syncControllers(merged);
          emit(
            state.copyWith(
              unit: merged,
              loadStatus: RequestStatus.success,
            ),
          );
        },
      );
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
        syncControllers(merged);
        emit(
          state.copyWith(
            unit: merged,
            details: details,
            loadStatus: RequestStatus.success,
          ),
        );
      },
    );
  }

  @override
  void syncControllers(UnitModel unit) {
    tenantNameController.text = unit.tenantName;
    tenantPhoneController.text = unit.tenantPhone;
    rentStartController.text = unit.rentStartDate;
    rentEndController.text = unit.rentEndDate;
    titleController.text = unit.label;
    projectNameController.text = unit.projectName;
    monthlyRentController.text = unit.monthlyRent > 0
        ? formatPrice(unit.monthlyRent)
        : '';
  }

  String formatPickedDate(DateTime date) =>
      HijriDate.format(date, hijri: state.unit?.isHijriDate ?? false);

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

  void _onDatePicked(
    UnitDetailsDatePicked event,
    Emitter<UnitDetailsState> emit,
  ) {
    final formatted = formatPickedDate(event.date);
    if (event.isStart) {
      rentStartController.text = formatted;
    } else {
      rentEndController.text = formatted;
    }
  }

  Future<void> requestDate(BuildContext context, {required bool isStart}) async {
    final now = DateTime.now();
    final useHijri = state.unit?.isHijriDate ?? false;
    final DateTime? picked;
    if (useHijri) {
      picked = await showHijriDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1950),
        lastDate: DateTime(now.year + 20),
      );
    } else {
      picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1950),
        lastDate: DateTime(now.year + 20),
      );
    }
    if (picked == null) return;
    add(UnitDetailsDatePicked(isStart: isStart, date: picked));
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
    monthlyRentController.dispose();
    return super.close();
  }
}
