part of 'add_commercial_project_bloc.dart';

enum CommercialDateField { none, start, end }

enum CommercialDialogAction { none, showManagerLogin, showSuccess }

class AddCommercialProjectState extends Equatable {
  const AddCommercialProjectState({
    this.selectedPropertyType = '',
    this.selectedAreaType,
    this.showManagerForm = false,
    this.submitStatus = RequestStatus.init,
    this.pendingDateField = CommercialDateField.none,
    this.dialogAction = CommercialDialogAction.none,
    this.stages = const [],
    this.stagesFetchStatus = RequestStatus.init,
    this.selectedStageIds = const [],
    this.selectedSubStageIds = const {},
    this.selectedImages = const [],
    this.customSubStages = const {},
    this.submitErrorMessage,
  });

  final String selectedPropertyType;
  final String? selectedAreaType;
  final bool showManagerForm;
  final RequestStatus submitStatus;
  final CommercialDateField pendingDateField;
  final CommercialDialogAction dialogAction;
  final List<ProjectStageModel> stages;
  final RequestStatus stagesFetchStatus;
  final List<String> selectedStageIds;
  final Map<String, List<String>> selectedSubStageIds;
  final List<String> selectedImages;
  final Map<String, List<String>> customSubStages;
  final String? submitErrorMessage;

  AddCommercialProjectState copyWith({
    String? selectedPropertyType,
    String? selectedAreaType,
    bool? showManagerForm,
    RequestStatus? submitStatus,
    CommercialDateField? pendingDateField,
    CommercialDialogAction? dialogAction,
    List<ProjectStageModel>? stages,
    RequestStatus? stagesFetchStatus,
    List<String>? selectedStageIds,
    Map<String, List<String>>? selectedSubStageIds,
    List<String>? selectedImages,
    Map<String, List<String>>? customSubStages,
    String? submitErrorMessage,
    bool clearSubmitError = false,
  }) => AddCommercialProjectState(
    selectedPropertyType: selectedPropertyType ?? this.selectedPropertyType,
    selectedAreaType: selectedAreaType ?? this.selectedAreaType,
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
    selectedAreaType,
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
