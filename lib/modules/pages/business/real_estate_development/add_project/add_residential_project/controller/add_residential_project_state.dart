part of 'add_residential_project_bloc.dart';

enum ResidentialObscureField { password, email, phone }

enum ResidentialDateField { none, start, end }

enum ResidentialDialogAction { none, showManagerLogin, showSuccess }

class AddResidentialProjectState extends Equatable {
  const AddResidentialProjectState({
    this.selectedPropertyType = '',
    this.showManagerForm = false,
    this.submitStatus = RequestStatus.init,
    this.pendingDateField = ResidentialDateField.none,
    this.dialogAction = ResidentialDialogAction.none,
    this.stages = const [],
    this.stagesFetchStatus = RequestStatus.init,
    this.selectedStageIds = const [],
    this.selectedSubStageIds = const {},
    this.selectedImages = const [],
    this.customSubStages = const {},
    this.submitErrorMessage,
  });

  final String selectedPropertyType;
  final bool showManagerForm;
  final RequestStatus submitStatus;
  final ResidentialDateField pendingDateField;
  final ResidentialDialogAction dialogAction;
  final List<ProjectStageModel> stages;
  final RequestStatus stagesFetchStatus;
  final List<String> selectedStageIds;
  final Map<String, List<String>> selectedSubStageIds;
  final List<String> selectedImages;
  final Map<String, List<String>> customSubStages;
  final String? submitErrorMessage;

  AddResidentialProjectState copyWith({
    String? selectedPropertyType,
    bool? showManagerForm,
    RequestStatus? submitStatus,
    ResidentialDateField? pendingDateField,
    ResidentialDialogAction? dialogAction,
    List<ProjectStageModel>? stages,
    RequestStatus? stagesFetchStatus,
    List<String>? selectedStageIds,
    Map<String, List<String>>? selectedSubStageIds,
    List<String>? selectedImages,
    Map<String, List<String>>? customSubStages,
    String? submitErrorMessage,
    bool clearSubmitError = false,
  }) => AddResidentialProjectState(
    selectedPropertyType: selectedPropertyType ?? this.selectedPropertyType,
    showManagerForm: showManagerForm ?? this.showManagerForm,
    submitStatus: submitStatus ?? this.submitStatus,
    pendingDateField: pendingDateField ?? this.pendingDateField,
    dialogAction: dialogAction ?? this.dialogAction,
    stages: stages ?? this.stages,
    stagesFetchStatus: stagesFetchStatus ?? this.stagesFetchStatus,
    selectedStageIds: selectedStageIds ?? this.selectedStageIds,
    selectedSubStageIds: selectedSubStageIds ?? this.selectedSubStageIds,
    selectedImages: selectedImages ?? this.selectedImages,
    customSubStages: customSubStages ?? this.customSubStages,
    submitErrorMessage: clearSubmitError
        ? null
        : submitErrorMessage ?? this.submitErrorMessage,
  );

  @override
  List<Object?> get props => [
    selectedPropertyType,
    showManagerForm,
    submitStatus,
    pendingDateField,
    dialogAction,
    stages,
    stagesFetchStatus,
    selectedStageIds,
    selectedSubStageIds,
    selectedImages,
    customSubStages,
    submitErrorMessage,
  ];
}
