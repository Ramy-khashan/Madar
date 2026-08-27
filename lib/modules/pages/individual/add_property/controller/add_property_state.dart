part of 'add_property_bloc.dart';

enum AddPropertyStep { type, period, location, images, details, review }

enum SubmitStatus { initial, loading, success, failure }

class AddPropertyState extends Equatable {
  const AddPropertyState({
    this.step = AddPropertyStep.type,
    this.model = const AddPropertyModel(),
    this.isLoading = false,
    this.showPortfolioSheet = false,
    this.isNewFolder = true,
    this.submitStatus = SubmitStatus.initial,
    this.errorMessage,
    this.createdPropertyId,
    this.fieldErrors = const {},
    this.openChooseBrokerOnSuccess = false,
    this.isPreviewLoading = false,
    this.hasMarketData = false,
    this.suggestedMin,
    this.suggestedMax,
    this.aiDescription,
    this.parentCandidates = const [],
    this.parentCandidatesStatus = RequestStatus.init,
  });

  final AddPropertyStep step;
  final AddPropertyModel model;
  final bool isLoading;
  final bool showPortfolioSheet;
  final bool isNewFolder;
  final SubmitStatus submitStatus;
  final String? errorMessage;
  final String? createdPropertyId;
  final Map<String, String> fieldErrors;
  final bool openChooseBrokerOnSuccess;
  final bool isPreviewLoading;
  final bool hasMarketData;
  final num? suggestedMin;
  final num? suggestedMax;
  final String? aiDescription;
  final List<MyPropertiesModel> parentCandidates;
  final RequestStatus parentCandidatesStatus;

  /// Maps the current step to a 0-based indicator index (5 segments total).
  /// period shares index 0 with type (it's a sub-step of the type phase).
  int get indicatorIndex {
    switch (step) {
      case AddPropertyStep.type:
      case AddPropertyStep.period:
        return 0;
      case AddPropertyStep.location:
        return 1;
      case AddPropertyStep.images:
        return 2;
      case AddPropertyStep.details:
        return 3;
      case AddPropertyStep.review:
        return 4;
    }
  }

  static const int totalIndicatorSteps = 5;

  AddPropertyState copyWith({
    AddPropertyStep? step,
    AddPropertyModel? model,
    bool? isLoading,
    bool? showPortfolioSheet,
    bool? isNewFolder,
    SubmitStatus? submitStatus,
    String? errorMessage,
    String? createdPropertyId,
    Map<String, String>? fieldErrors,
    bool? openChooseBrokerOnSuccess,
    bool? isPreviewLoading,
    bool? hasMarketData,
    num? suggestedMin,
    num? suggestedMax,
    String? aiDescription,
    List<MyPropertiesModel>? parentCandidates,
    RequestStatus? parentCandidatesStatus,
  }) {
    return AddPropertyState(
      step: step ?? this.step,
      model: model ?? this.model,
      isLoading: isLoading ?? this.isLoading,
      showPortfolioSheet: showPortfolioSheet ?? this.showPortfolioSheet,
      isNewFolder: isNewFolder ?? this.isNewFolder,
      submitStatus: submitStatus ?? this.submitStatus,
      errorMessage: errorMessage,
      createdPropertyId: createdPropertyId ?? this.createdPropertyId,
      fieldErrors: fieldErrors ?? this.fieldErrors,
      openChooseBrokerOnSuccess:
          openChooseBrokerOnSuccess ?? this.openChooseBrokerOnSuccess,
      isPreviewLoading: isPreviewLoading ?? this.isPreviewLoading,
      hasMarketData: hasMarketData ?? this.hasMarketData,
      suggestedMin: suggestedMin ?? this.suggestedMin,
      suggestedMax: suggestedMax ?? this.suggestedMax,
      aiDescription: aiDescription ?? this.aiDescription,
      parentCandidates: parentCandidates ?? this.parentCandidates,
      parentCandidatesStatus:
          parentCandidatesStatus ?? this.parentCandidatesStatus,
    );
  }

  @override
  List<Object?> get props => [
    step,
    model,
    isLoading,
    showPortfolioSheet,
    isNewFolder,
    submitStatus,
    errorMessage,
        createdPropertyId,
        fieldErrors,
        openChooseBrokerOnSuccess,
        isPreviewLoading,
        hasMarketData,
        suggestedMin,
        suggestedMax,
        aiDescription,
        parentCandidates,
        parentCandidatesStatus,
      ];
}
