import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/repository/apis/real_estate_projects_apis.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../shared/models/project_stage_model.dart';
import '../../shared/project_form_helpers.dart';

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
    on<AddCommercialStageSelectAll>(_onStageSelectAll);
    on<AddCommercialSubStageToggled>(_onSubStageToggled);
    on<AddCommercialImagesSelected>(_onImagesSelected);
    on<AddCommercialImageRemoved>(_onImageRemoved);
    on<AddCommercialCustomSubStageAdded>(_onCustomSubStageAdded);
    on<AddCommercialCustomSubStageRemoved>(_onCustomSubStageRemoved);

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
    final stagesRequest = ProjectFormHelpers.buildStages(
      selectedStageIds: state.selectedStageIds,
      selectedSubStageIds: state.selectedSubStageIds,
      customSubStages: state.customSubStages,
    );
    final error = ProjectFormHelpers.validateCreate(
      formValid: formKey.currentState?.validate() ?? false,
      stages: stagesRequest,
      attachments: state.selectedImages,
      managerName: usernameController.text,
      managerPhone: phoneController.text,
      managerPassword: passwordController.text,
    );
    if (error != null) {
      emit(
        state.copyWith(
          submitStatus: RequestStatus.init,
          clearSubmitError: true,
        ),
      );
      emit(
        state.copyWith(
          submitStatus: RequestStatus.failed,
          submitErrorMessage: error,
        ),
      );
      return;
    }

    final projectRequest = ProjectFormHelpers.buildRequest(
      projectName: nameController.text,
      location: locationController.text,
      startDate: startDateController.text,
      endDate: endDateController.text,
      price: budgetController.text,
      type: AppConstant.commercialProjectType,
      stages: stagesRequest,
      managerName: usernameController.text,
      managerPhone: phoneController.text,
      managerPassword: passwordController.text,
    );

    emit(
      state.copyWith(
        submitStatus: RequestStatus.loading,
        clearSubmitError: true,
      ),
    );

    final result = await RealEstateProjectsApis.createProject(
      projectRequest,
      state.selectedImages,
    );

    result.fold(
      (err) => emit(
        state.copyWith(
          submitStatus: RequestStatus.failed,
          submitErrorMessage: err,
        ),
      ),
      (_) => emit(
        state.copyWith(
          submitStatus: RequestStatus.success,
          clearSubmitError: true,
        ),
      ),
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
    final customSubStages = Map<String, List<String>>.from(
      state.customSubStages,
    );

    if (selectedStageIds.contains(event.stageId)) {
      selectedStageIds.remove(event.stageId);
      selectedSubStageIds.remove(event.stageId);
      customSubStages.remove(event.stageId);
    } else {
      selectedStageIds.add(event.stageId);
      if (!selectedSubStageIds.containsKey(event.stageId)) {
        selectedSubStageIds[event.stageId] = [];
      }
    }

    emit(
      state.copyWith(
        selectedStageIds: selectedStageIds,
        selectedSubStageIds: selectedSubStageIds,
        customSubStages: customSubStages,
      ),
    );
  }

  void _onStageSelectAll(
    AddCommercialStageSelectAll event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    final result = ProjectFormHelpers.selectAllExceptOther(
      stages: state.stages,
      stageId: event.stageId,
      selectedStageIds: state.selectedStageIds,
      selectedSubStageIds: state.selectedSubStageIds,
    );
    emit(
      state.copyWith(
        selectedStageIds: result.selectedStageIds,
        selectedSubStageIds: result.selectedSubStageIds,
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

    final selectedStageIds = List<String>.from(state.selectedStageIds);
    if (subStageList.isNotEmpty && !selectedStageIds.contains(event.stageId)) {
      selectedStageIds.add(event.stageId);
    }

    emit(
      state.copyWith(
        selectedStageIds: selectedStageIds,
        selectedSubStageIds: selectedSubStageIds,
      ),
    );
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

  void _onCustomSubStageAdded(
    AddCommercialCustomSubStageAdded event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    final name = event.name.trim();
    if (name.isEmpty) return;
    final custom = Map<String, List<String>>.from(state.customSubStages);
    custom[event.stageId] = [...(custom[event.stageId] ?? const []), name];
    final selectedStageIds = List<String>.from(state.selectedStageIds);
    if (!selectedStageIds.contains(event.stageId)) {
      selectedStageIds.add(event.stageId);
    }
    emit(
      state.copyWith(
        customSubStages: custom,
        selectedStageIds: selectedStageIds,
      ),
    );
  }

  void _onCustomSubStageRemoved(
    AddCommercialCustomSubStageRemoved event,
    Emitter<AddCommercialProjectState> emit,
  ) {
    final custom = Map<String, List<String>>.from(state.customSubStages);
    final list = List<String>.from(custom[event.stageId] ?? const []);
    if (event.index < 0 || event.index >= list.length) return;
    list.removeAt(event.index);
    if (list.isEmpty) {
      custom.remove(event.stageId);
    } else {
      custom[event.stageId] = list;
    }
    emit(state.copyWith(customSubStages: custom));
  }
}
