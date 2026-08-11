import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/repository/apis/real_estate_projects_apis.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/print_state.dart';
import '../../../../../auction/add_auction_property/model/property_details.dart';
import '../../shared/models/manager_request_model.dart';
import '../../shared/models/project_request_base.dart';
import '../../shared/models/project_stage_model.dart';
import '../../shared/models/stage_request_model.dart';

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
    on<AddResidentialSubStageToggled>(_onSubStageToggled);
    on<AddResidentialImagesSelected>(_onImagesSelected);
    on<AddResidentialImageRemoved>(_onImageRemoved);

    // Auto-fetch stages on initialization
    add(const AddResidentialFetchStages());
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final budgetController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final phasesController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  List<CounterItemModel> get counterItems => [
    CounterItemModel(
      label: AppStrings.roomsLabel,
      icon: AppImages.bedroomIcon,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.bathroomsLabel,
      icon: AppImages.bathroomIcon,

      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.areaLabel,

      icon: AppImages.totalSpaceIcon,
      suffix: AppStrings.mesurement,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.balconyLabel,
      icon: AppImages.balconyIcon,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.floorLabel,
      icon: AppImages.floorIcon,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.propertyNumberLabel,
      icon: AppImages.propertyNumberIcon,
      controller: TextEditingController(),
    ),
  ];

  @override
  Future<void> close() {
    nameController.dispose();
    locationController.dispose();
    budgetController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    phasesController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
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
    try{
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
      type: AppConstant.residentialProjectType,
      stages: stagesRequest,
      manager: managerRequest,
    );

    emit(state.copyWith(
      submitStatus: RequestStatus.loading,
      submitErrorMessage: null,
    ));

    final result = await RealEstateProjectsApis.createProject(
      projectRequest,
      state.selectedImages,
    );

    result.fold(
      (error) => emit(state.copyWith(
        submitStatus: RequestStatus.failed,
        submitErrorMessage: error,
      )),
      (success) => emit(state.copyWith(submitStatus: RequestStatus.success)),
    );
    }catch(e){
      printState('Error during project submission: $e');
      emit(state.copyWith(
        submitStatus: RequestStatus.failed,
        submitErrorMessage: AppStrings.somethingWentWrong,
      ));
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

    final result = await RealEstateProjectsApis.fetchProjectStages(AppConstant.residentialProjectType);

    result.fold(
      (error) => emit(state.copyWith(stagesFetchStatus: RequestStatus.failed)),
      (stages) => emit(state.copyWith(
        stagesFetchStatus: RequestStatus.success,
        stages: stages,
      )),
    );
  }

  void _onStageToggled(
    AddResidentialStageToggled event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    final selectedStageIds = List<String>.from(state.selectedStageIds);
    final selectedSubStageIds =
        Map<String, List<String>>.from(state.selectedSubStageIds);

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

    emit(state.copyWith(
      selectedStageIds: selectedStageIds,
      selectedSubStageIds: selectedSubStageIds,
    ));
  }

  void _onSubStageToggled(
    AddResidentialSubStageToggled event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    final selectedSubStageIds =
        Map<String, List<String>>.from(state.selectedSubStageIds);

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
}
