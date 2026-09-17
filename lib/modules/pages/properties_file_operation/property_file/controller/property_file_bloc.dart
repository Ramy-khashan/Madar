import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/hijri_date_picker.dart';
import '../../../../../core/repository/apis/property_file_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/hijri_date.dart';
import '../../../../../core/utils/functions/print_state.dart';
import '../../../individual/property_details/model/property_details_model.dart';
import '../model/property_file_model.dart';

part 'property_file_event.dart';
part 'property_file_state.dart';
part 'mixins/property_file_tenancy_mixin.dart';

class PropertyFileBloc extends Bloc<PropertyFileEvent, PropertyFileState>
    with PropertyFileTenancyMixin {
  PropertyFileBloc() : super(const PropertyFileState()) {
    on<PropertyFileLoad>(_onLoad);
    on<PropertyFileToggleBookmark>(_onToggleBookmark);
    on<PropertyFileDeleteProperty>(_onDeleteProperty);
    on<PropertyFileSaveChanges>(_onSaveChanges);
    on<PropertyFilePublishRequested>(_onPublish);
    on<PropertyFileExpenseAdded>(_onExpenseAdded);
    on<PropertyFileExpenseRemoved>(_onExpenseRemoved);
    on<PropertyFileExpenseFilesPicked>(_onExpenseFilesPicked);
    on<PropertyFileStatusToggled>(_onStatusToggled);
    on<PropertyFileDateTypeToggled>(_onDateTypeToggled);
    on<PropertyFileDatePicked>(_onDatePicked);
    on<PropertyFileTenancySaved>(_onSaveTenancy);
  }

  String _propertyId = '';
  final TextEditingController titleController = TextEditingController();
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController expenseDescController = TextEditingController();
  final TextEditingController expenseAmountController = TextEditingController();
  @override
  final TextEditingController tenantNameController = TextEditingController();
  @override
  final TextEditingController tenantPhoneController = TextEditingController();
  @override
  final TextEditingController monthlyRentController = TextEditingController();
  @override
  final TextEditingController rentStartController = TextEditingController();
  @override
  final TextEditingController rentEndController = TextEditingController();

  static PropertyFileBloc get(BuildContext context) =>
      context.read<PropertyFileBloc>();

  Future<void> _onLoad(
    PropertyFileLoad event,
    Emitter<PropertyFileState> emit,
  ) async {
    if (event.propertyId.isNotEmpty) {
      _propertyId = event.propertyId;
    }
    emit(const PropertyFileState(status: RequestStatus.loading));
    if (_propertyId.isEmpty) {
      emit(
        state.copyWith(
          status: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
        ),
      );
      return;
    }

    final result = await PropertyFileApis.getProperty(_propertyId);
    if (isClosed) return;
    result.fold(
      (error) {
        emit(state.copyWith(status: RequestStatus.failed, errorMsg: error));
      },
      (details) {
        titleController.text = details.title ?? '';
        projectNameController.text = details.projectName ?? '';
        syncTenancy(details);
        final mapped = PropertyFileModel.fromDetails(details);
        emit(
          state.copyWith(
            details: details,
            property: mapped,
            expenses: UnitModel.fromDetails(details).expenses,
            status: RequestStatus.success,
            tenancyStatus: unitStatusFrom(details.tenancyStatus),
            isHijriDate:
                (details.tenancyCalendarType ?? '').toUpperCase() == 'HIJRI',
          ),
        );
      },
    );
  }

  void _onToggleBookmark(
    PropertyFileToggleBookmark event,
    Emitter<PropertyFileState> emit,
  ) {
    final p = state.property;
    if (p == null) return;
    emit(state.copyWith(property: p.copyWith(isBookmarked: !p.isBookmarked)));
  }

  Future<void> _onDeleteProperty(
    PropertyFileDeleteProperty event,
    Emitter<PropertyFileState> emit,
  ) async {
    if (_propertyId.isEmpty) return;
    final result = await PropertyFileApis.deleteProperty(_propertyId);
    result.fold(
      (error) => AppToast(error, isError: true),
      (_) => emit(state.copyWith(isDeleted: true)),
    );
  }

  Future<void> _onSaveChanges(
    PropertyFileSaveChanges event,
    Emitter<PropertyFileState> emit,
  ) async {
    if (_propertyId.isEmpty) return;
    emit(state.copyWith(saveStatus: RequestStatus.loading));
    final result = await PropertyFileApis.updateProperty(
      propertyId: _propertyId,
      title: titleController.text.trim(),
      projectName: projectNameController.text.trim(),
    );
    if (isClosed) return;

    await result.fold(
      (error) async {
        AppToast(error, isError: true);
        emit(state.copyWith(saveStatus: RequestStatus.failed));
      },
      (details) async {
        var nextDetails = details;
        final shouldSaveExpenses =
            state.expenses.any((e) => !e.isRemote) ||
            state.expenseFiles.isNotEmpty;
        if (shouldSaveExpenses) {
          final expenseResult = await PropertyFileApis.saveExpenses(
            propertyId: _propertyId,
            expenses: state.expenses.where((e) => !e.isRemote).toList(),
            filePaths: state.expenseFiles,
          );
          await expenseResult.fold(
            (error) async => AppToast(error, isError: true),
            (_) async {
              final reload = await PropertyFileApis.getProperty(_propertyId);
              reload.fold((_) {}, (fresh) => nextDetails = fresh);
            },
          );
        }
        if ((nextDetails.media == null || nextDetails.media!.isEmpty) &&
            state.details != null) {
          nextDetails.media = state.details!.media;
        }
        nextDetails.title = titleController.text.trim();
        nextDetails.projectName = projectNameController.text.trim();
        syncTenancy(nextDetails);
        final mapped = PropertyFileModel.fromDetails(nextDetails);
        emit(
          state.copyWith(
            details: nextDetails,
            property: mapped,
            expenses: UnitModel.fromDetails(nextDetails).expenses,
            saveStatus: RequestStatus.success,
            expenseFiles: const [],
            tenancyStatus: unitStatusFrom(nextDetails.tenancyStatus),
            isHijriDate:
                (nextDetails.tenancyCalendarType ?? '').toUpperCase() ==
                'HIJRI',
          ),
        );
        AppToast(AppStrings.propertyUpdated);
      },
    );
  }

  Future<void> _onSaveTenancy(
    PropertyFileTenancySaved event,
    Emitter<PropertyFileState> emit,
  ) async {
    if (_propertyId.isEmpty) return;
    final tenancy = tenancyBody();
    if (state.isRented && tenancy == null) {
      AppToast(AppStrings.pleaseCompleteTenantData, isError: true);
      return;
    }
    final body = tenancy ?? {'status': 'VACANT'};
    emit(state.copyWith(tenancySaveStatus: RequestStatus.loading));
    final result = await PropertyFileApis.updatePropertyTenancy(
      propertyId: _propertyId,
      tenancy: body,
    );
    if (isClosed) return;
    await result.fold(
      (error) async {
        AppToast(error, isError: true);
        emit(state.copyWith(tenancySaveStatus: RequestStatus.failed));
      },
      (details) async {
        final nextDetails = details;
        if ((nextDetails.tenancyStatus ?? '').isEmpty) {
          nextDetails.tenancyStatus = body['status']?.toString();
          nextDetails.tenantName = body['tenantName']?.toString();
          nextDetails.tenantPhone = body['tenantPhone']?.toString();
          nextDetails.monthlyRent = num.tryParse(
            body['monthlyRent']?.toString() ?? '',
          );
          nextDetails.tenancyStartDate = body['startDate']?.toString();
          nextDetails.tenancyEndDate = body['endDate']?.toString();
        }
        if ((nextDetails.media == null || nextDetails.media!.isEmpty) &&
            state.details != null) {
          nextDetails.media = state.details!.media;
        }
        if ((nextDetails.title ?? '').isEmpty) {
          nextDetails.title = state.details?.title;
        }
        syncTenancy(nextDetails);
        emit(
          state.copyWith(
            details: nextDetails,
            property: PropertyFileModel.fromDetails(nextDetails),
            expenses: UnitModel.fromDetails(nextDetails).expenses,
            tenancySaveStatus: RequestStatus.success,
            tenancyStatus: unitStatusFrom(nextDetails.tenancyStatus),
            isHijriDate:
                (nextDetails.tenancyCalendarType ?? '').toUpperCase() ==
                'HIJRI',
          ),
        );
        AppToast(AppStrings.propertyUpdated);
      },
    );
  }

  void _onExpenseAdded(
    PropertyFileExpenseAdded event,
    Emitter<PropertyFileState> emit,
  ) {
    printState('Adding expense');
    final desc = expenseDescController.text.trim();
    final amt = parsePrice(expenseAmountController.text)?.toDouble() ?? 0;
    if (desc.isEmpty || amt <= 0) return;
    emit(
      state.copyWith(
        expenses: [
          ...state.expenses,
          UnitExpenseModel(description: desc, amount: amt,),
        ],
      ),
    );
    expenseDescController.clear();
    expenseAmountController.clear();
  }

  void _onExpenseRemoved(
    PropertyFileExpenseRemoved event,
    Emitter<PropertyFileState> emit,
  ) {
    final updated = List<UnitExpenseModel>.from(state.expenses)
      ..removeAt(event.index);
    emit(state.copyWith(expenses: updated));
  }

  void _onExpenseFilesPicked(
    PropertyFileExpenseFilesPicked event,
    Emitter<PropertyFileState> emit,
  ) {
    emit(state.copyWith(expenseFiles: [...state.expenseFiles, ...event.paths]));
  }

  Future<void> _onPublish(
    PropertyFilePublishRequested event,
    Emitter<PropertyFileState> emit,
  ) async {
    if (_propertyId.isEmpty) return;
    emit(state.copyWith(publishStatus: RequestStatus.loading));
    final result = await PropertyFileApis.publishProperty(
      propertyId: _propertyId,
      adLicenseNumber: event.adLicenseNumber,
      falLicenseNumber: event.falLicenseNumber,
    );
    if (isClosed) return;
    result.fold(
      (error) {
        AppToast(error, isError: true);
        emit(state.copyWith(publishStatus: RequestStatus.failed));
      },
      (_) {
        state.details?.publicationStatus = 'PUBLISHED';
        AppToast(AppStrings.propertyPublished);
        emit(state.copyWith(publishStatus: RequestStatus.success));
      },
    );
  }

  @override
  Future<void> close() {
    titleController.dispose();
    projectNameController.dispose();
    expenseDescController.dispose();
    expenseAmountController.dispose();
    tenantNameController.dispose();
    tenantPhoneController.dispose();
    monthlyRentController.dispose();
    rentStartController.dispose();
    rentEndController.dispose();
    return super.close();
  }
}
