import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/repository/apis/real_estate_projects_apis.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../shared/models/manager_request_model.dart';
import '../../shared/models/project_request_base.dart';
import '../../shared/models/project_stage_model.dart';
import '../../shared/models/stage_request_model.dart';

part 'add_commercial_project_event.dart';
part 'add_commercial_project_state.dart';

class AddCommercialProjectBloc
    extends Bloc<AddCommercialProjectEvent, AddCommercialProjectState> {
  AddCommercialProjectBloc() : super(const AddCommercialProjectState()) {
    on<AddCommercialPropertyTypeChanged>(_onPropertyTypeChanged);
    on<AddCommercialAreaTypeChanged>(_onAreaTypeChanged);
    on<AddCommercialManagerToggled>(_onManagerToggled);
    on<AddCommercialPickDateRequested>(_onPickDateRequested);
    on<AddCommercialDatePicked>(_onDatePicked);
    on<AddCommercialDatePickCancelled>(_onDatePickCancelled);
    on<AddCommercialSendToManagerRequested>(_onSendToManagerRequested);
    on<AddCommercialManagerLoginResult>(_onManagerLoginResult);
    on<AddCommercialSuccessDialogDismissed>(_onSuccessDialogDismissed);
    on<AddCommercialSubmit>(_onSubmit);
    on<AddCommercialReset>(_onReset);
    on<AddCommercialFetchStages>(_onFetchStages);
    on<AddCommercialStageToggled>(_onStageToggled);
    on<AddCommercialSubStageToggled>(_onSubStageToggled);
    on<AddCommercialImagesSelected>(_onImagesSelected);
    on<AddCommercialImageRemoved>(_onImageRemoved);

    // Auto-fetch stages on initialization
    add(const AddCommercialFetchStages());
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final budgetController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Future<void> close() {
    nameController.dispose();
    locationController.dispose();
    budgetController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
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

  void _onManagerToggled(
    AddCommercialManagerToggled event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    emit(state.copyWith(showManagerForm: event.show));
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
    emit(state.copyWith(dialogAction: CommercialDialogAction.showManagerLogin));
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

    // Build stages request from selected stages/substages
    final stagesRequest = state.selectedStageIds.map((stageId) {
      final subStageIds = state.selectedSubStageIds[stageId] ?? [];
      return StageRequestModel(stageId: stageId, subStageIds: subStageIds);
    }).toList();

    // Build manager request
    final managerRequest = ManagerRequestModel(
      fullName: usernameController.text,
      phone: phoneController.text,
      password: passwordController.text,
    );

    // Build project request
    final projectRequest = ProjectRequestBase(
      projectName: nameController.text,
      location: locationController.text,
      startDate: startDateController.text,
      endDate: endDateController.text,
      price: budgetController.text,
      type: AppConstant.commercialProjectType,
      stages: stagesRequest,
      manager: managerRequest,
    );

    emit(
      state.copyWith(
        submitStatus: RequestStatus.loading,
        submitErrorMessage: null,
      ),
    );

    final result = await RealEstateProjectsApis.createProject(
      projectRequest,
      state.selectedImages,
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          submitStatus: RequestStatus.failed,
          submitErrorMessage: error,
        ),
      ),
      (success) => emit(state.copyWith(submitStatus: RequestStatus.success)),
    );
  }

  void _onReset(
    AddCommercialReset event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    emit(const AddCommercialProjectState());
  }

  Future<void> _onFetchStages(
    AddCommercialFetchStages event,
    Emitter<AddCommercialProjectState> emit,
  ) async {
    emit(state.copyWith(stagesFetchStatus: RequestStatus.loading));

    final result = await RealEstateProjectsApis.fetchProjectStages(
      AppConstant.commercialProjectType,
    );

    result.fold(
      (error) => emit(state.copyWith(stagesFetchStatus: RequestStatus.failed)),
      (stages) => emit(
        state.copyWith(
          stagesFetchStatus: RequestStatus.success,
          stages: stages,
        ),
      ),
    );
  }

  void _onStageToggled(
    AddCommercialStageToggled event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    final selectedStageIds = List<String>.from(state.selectedStageIds);
    final selectedSubStageIds = Map<String, List<String>>.from(
      state.selectedSubStageIds,
    );

    if (selectedStageIds.contains(event.stageId)) {
      // Remove stage and its substages
      selectedStageIds.remove(event.stageId);
      selectedSubStageIds.remove(event.stageId);
    } else {
      // Add stage
      selectedStageIds.add(event.stageId);
      if (!selectedSubStageIds.containsKey(event.stageId)) {
        selectedSubStageIds[event.stageId] = [];
      }
    }

    emit(
      state.copyWith(
        selectedStageIds: selectedStageIds,
        selectedSubStageIds: selectedSubStageIds,
      ),
    );
  }

  void _onSubStageToggled(
    AddCommercialSubStageToggled event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    final selectedSubStageIds = Map<String, List<String>>.from(
      state.selectedSubStageIds,
    );

    if (!selectedSubStageIds.containsKey(event.stageId)) {
      selectedSubStageIds[event.stageId] = [];
    }

    final subStageList = List<String>.from(selectedSubStageIds[event.stageId]!);

    if (subStageList.contains(event.subStageId)) {
      subStageList.remove(event.subStageId);
    } else {
      subStageList.add(event.subStageId);
    }

    selectedSubStageIds[event.stageId] = subStageList;

    emit(state.copyWith(selectedSubStageIds: selectedSubStageIds));
  }

  void _onImagesSelected(
    AddCommercialImagesSelected event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    final updatedImages = List<String>.from(state.selectedImages)
      ..addAll(event.paths);
    emit(state.copyWith(selectedImages: updatedImages));
  }

  void _onImageRemoved(
    AddCommercialImageRemoved event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    final updatedImages = List<String>.from(state.selectedImages)
      ..removeAt(event.index);
    emit(state.copyWith(selectedImages: updatedImages));
  }
}
