import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/repository/apis/real_estate_projects_apis.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/print_state.dart';
import '../../shared/models/project_stage_model.dart';
import '../../shared/project_form_helpers.dart';

part 'add_residential_project_event.dart';
part 'add_residential_project_state.dart';

class AddResidentialProjectBloc
    extends Bloc<AddResidentialProjectEvent, AddResidentialProjectState> {
  AddResidentialProjectBloc() : super(const AddResidentialProjectState()) {
    on<AddResidentialPropertyTypeChanged>(_onPropertyTypeChanged);
    on<AddResidentialManagerToggled>(_onManagerToggled);
    on<AddResidentialPickDateRequested>(_onPickDateRequested);
    on<AddResidentialDatePicked>(_onDatePicked);
    on<AddResidentialDatePickCancelled>(_onDatePickCancelled);
    on<AddResidentialSendToManagerRequested>(_onSendToManagerRequested);
    on<AddResidentialManagerLoginResult>(_onManagerLoginResult);
    on<AddResidentialSuccessDialogDismissed>(_onSuccessDialogDismissed);
    on<AddResidentialSubmit>(_onSubmit);
    on<AddResidentialReset>(_onReset);
    on<AddResidentialFetchStages>(_onFetchStages);
    on<AddResidentialStageToggled>(_onStageToggled);
    on<AddResidentialStageSelectAll>(_onStageSelectAll);
    on<AddResidentialSubStageToggled>(_onSubStageToggled);
    on<AddResidentialImagesSelected>(_onImagesSelected);
    on<AddResidentialImageRemoved>(_onImageRemoved);
    on<AddResidentialCustomSubStageAdded>(_onCustomSubStageAdded);
    on<AddResidentialCustomSubStageRemoved>(_onCustomSubStageRemoved);

    // Auto-fetch stages on initialization
    add(const AddResidentialFetchStages());
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
    AddResidentialPropertyTypeChanged event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(state.copyWith(selectedPropertyType: event.propertyType));
  }

  void _onManagerToggled(
    AddResidentialManagerToggled event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(state.copyWith(showManagerForm: event.show));
  }

  void _onPickDateRequested(
    AddResidentialPickDateRequested event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(state.copyWith(pendingDateField: event.field));
  }

  void _onDatePicked(
    AddResidentialDatePicked event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    if (event.field == ResidentialDateField.start) {
      startDateController.text = event.date;
    } else {
      endDateController.text = event.date;
    }
    emit(state.copyWith(pendingDateField: ResidentialDateField.none));
  }

  void _onDatePickCancelled(
    AddResidentialDatePickCancelled event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(state.copyWith(pendingDateField: ResidentialDateField.none));
  }

  void _onSendToManagerRequested(
    AddResidentialSendToManagerRequested event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(
      state.copyWith(dialogAction: ResidentialDialogAction.showManagerLogin),
    );
  }

  void _onManagerLoginResult(
    AddResidentialManagerLoginResult event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(
      state.copyWith(
        dialogAction: event.success
            ? ResidentialDialogAction.showSuccess
            : ResidentialDialogAction.none,
      ),
    );
  }

  void _onSuccessDialogDismissed(
    AddResidentialSuccessDialogDismissed event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(state.copyWith(dialogAction: ResidentialDialogAction.none));
  }

  Future<void> _onSubmit(
    AddResidentialSubmit event,
    Emitter<AddResidentialProjectState> emit,
  ) async {
    try {
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
        type: AppConstant.residentialProjectType,
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
    } catch (e) {
      printState('Error during project submission: $e');
      emit(
        state.copyWith(
          submitStatus: RequestStatus.failed,
          submitErrorMessage: AppStrings.somethingWentWrong,
        ),
      );
    }
  }

  void _onReset(
    AddResidentialReset event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(const AddResidentialProjectState());
  }

  Future<void> _onFetchStages(
    AddResidentialFetchStages event,
    Emitter<AddResidentialProjectState> emit,
  ) async {
    printState('Fetching stages for residential project...');
    emit(state.copyWith(stagesFetchStatus: RequestStatus.loading));

    final result = await RealEstateProjectsApis.fetchProjectStages(
      AppConstant.residentialProjectType,
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
    AddResidentialStageToggled event,
    Emitter<AddResidentialProjectState> emit,
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
    AddResidentialStageSelectAll event,
    Emitter<AddResidentialProjectState> emit,
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
    AddResidentialSubStageToggled event,
    Emitter<AddResidentialProjectState> emit,
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
    AddResidentialImagesSelected event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    final updatedImages = List<String>.from(state.selectedImages)
      ..addAll(event.paths);
    emit(state.copyWith(selectedImages: updatedImages));
  }

  void _onImageRemoved(
    AddResidentialImageRemoved event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    final updatedImages = List<String>.from(state.selectedImages)
      ..removeAt(event.index);
    emit(state.copyWith(selectedImages: updatedImages));
  }

  void _onCustomSubStageAdded(
    AddResidentialCustomSubStageAdded event,
    Emitter<AddResidentialProjectState> emit,
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
    AddResidentialCustomSubStageRemoved event,
    Emitter<AddResidentialProjectState> emit,
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
