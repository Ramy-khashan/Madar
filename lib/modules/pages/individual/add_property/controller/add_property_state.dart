part of 'add_property_bloc.dart';

enum AddPropertyStep { type, period, location, images, details, review }

class AddPropertyState extends Equatable {
  const AddPropertyState({
    this.step = AddPropertyStep.type,
    this.model = const AddPropertyModel(),
    this.isLoading = false,
    this.showPortfolioSheet = false,
    this.isNewFolder = true,
  });

  final AddPropertyStep step;
  final AddPropertyModel model;
  final bool isLoading;
  final bool showPortfolioSheet;
  final bool isNewFolder;

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
  }) {
    return AddPropertyState(
      step: step ?? this.step,
      model: model ?? this.model,
      isLoading: isLoading ?? this.isLoading,
      showPortfolioSheet: showPortfolioSheet ?? this.showPortfolioSheet,
      isNewFolder: isNewFolder ?? this.isNewFolder,
    );
  }

  @override
  List<Object?> get props => [
        step,
        model,
        isLoading,
        showPortfolioSheet,
        isNewFolder,
      ];
}
