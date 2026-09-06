part of '../unit_details_bloc.dart';

mixin UnitDetailsSaveMixin on Bloc<UnitDetailsEvent, UnitDetailsState> {
  TextEditingController get tenantNameController;
  TextEditingController get tenantPhoneController;
  TextEditingController get rentStartController;
  TextEditingController get rentEndController;
  TextEditingController get titleController;
  TextEditingController get projectNameController;
  TextEditingController get monthlyRentController;
  void syncControllers(UnitModel unit);

  Future<void> _onSaved(
    UnitDetailsSaved event,
    Emitter<UnitDetailsState> emit,
  ) async {
    final u = state.unit;
    if (u == null || u.id.isEmpty) {
      emit(state.copyWith(saveStatus: RequestStatus.failed));
      return;
    }
    final rent =
        num.tryParse(digitsOnly(monthlyRentController.text.trim())) ??
        u.monthlyRent;
    final updatedUnit = u.copyWith(
      tenantName: tenantNameController.text.trim(),
      tenantPhone: tenantPhoneController.text.trim(),
      rentStartDate: rentStartController.text.trim(),
      rentEndDate: rentEndController.text.trim(),
      monthlyRent: rent.toDouble(),
      label: titleController.text.trim().isEmpty
          ? u.label
          : titleController.text.trim(),
      projectName: projectNameController.text.trim(),
    );

    if (state.buildingId.isNotEmpty) {
      if (updatedUnit.status == UnitStatus.rented &&
          (updatedUnit.tenantName.isEmpty ||
              updatedUnit.tenantPhone.isEmpty ||
              updatedUnit.monthlyRent <= 0 ||
              updatedUnit.rentStartDate.isEmpty ||
              updatedUnit.rentEndDate.isEmpty)) {
        AppToast(AppStrings.pleaseCompleteTenantData, isError: true);
        emit(state.copyWith(saveStatus: RequestStatus.failed));
        return;
      }
      emit(state.copyWith(saveStatus: RequestStatus.loading));
      final tenancyBody = <String, dynamic>{
        'status': updatedUnit.status == UnitStatus.rented
            ? 'RENTED'
            : 'VACANT',
      };
      if (updatedUnit.monthlyRent > 0) {
        tenancyBody['monthlyRent'] = updatedUnit.monthlyRent % 1 == 0
            ? updatedUnit.monthlyRent.toInt()
            : updatedUnit.monthlyRent;
      }
      if (updatedUnit.status == UnitStatus.rented) {
        tenancyBody.addAll({
          'tenantName': updatedUnit.tenantName,
          'tenantPhone': updatedUnit.tenantPhone,
          'startDate': updatedUnit.rentStartDate,
          'endDate': updatedUnit.rentEndDate,
          'calendarType': updatedUnit.isHijriDate ? 'HIJRI' : 'GREGORIAN',
        });
      }
      // TODO: this single PUT updates status + tenant. Change
      // EndPoints.updateBuildingApartment when the URL is finalized.
      final statusResult = await PropertyFileApis.updateBuildingApartment(
        propertyId: u.id,
        body: tenancyBody,
      );
      if (isClosed) return;
      final statusFailed = statusResult.fold((error) {
        AppToast(error, isError: true);
        return true;
      }, (_) => false);
      if (statusFailed) {
        emit(state.copyWith(saveStatus: RequestStatus.failed));
        return;
      }

      final newExpenses = updatedUnit.expenses.where((e) => !e.isRemote).toList();
      if (newExpenses.isNotEmpty || state.expenseFiles.isNotEmpty) {
        final expenseResult = await PropertyFileApis.saveExpenses(
          propertyId: u.id,
          expenses: newExpenses,
          filePaths: state.expenseFiles,
        );
        if (isClosed) return;
        final expenseFailed = expenseResult.fold((error) {
          AppToast(error, isError: true);
          return true;
        }, (_) => false);
        if (expenseFailed) {
          emit(state.copyWith(saveStatus: RequestStatus.failed));
          return;
        }
      }

      final refreshed = await PropertyFileApis.getBuildingApartment(u.id);
      if (isClosed) return;
      refreshed.fold(
        (_) {
          emit(
            state.copyWith(
              unit: updatedUnit,
              saveStatus: RequestStatus.success,
              expenseFiles: const [],
            ),
          );
        },
        (apartment) {
          final merged = UnitModel.fromBuildingApartment(apartment);
          syncControllers(merged);
          emit(
            state.copyWith(
              unit: merged,
              saveStatus: RequestStatus.success,
              expenseFiles: const [],
            ),
          );
        },
      );
      AppToast(AppStrings.propertyUpdated);
      return;
    }

    emit(state.copyWith(saveStatus: RequestStatus.loading));
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
}
