part of 'rate_property_estimation_bloc.dart';

class RatePropertyEstimationState extends Equatable {
  const RatePropertyEstimationState({
    this.selectedType,
    this.location = '',
    this.area = '',
    this.propertyAge,
    this.finishingLevel,
    this.purpose,
    this.analyzeStatus = RequestStatus.init,
     this.estimatedValue = 0,
    this.minValue = 0,
    this.maxValue = 0,
    this.marketComparison = '',
    this.saveStatus = RequestStatus.init,
  });

  final String? selectedType;
  final String location;
  final String area;
  final String? propertyAge;
  final String? finishingLevel;
  final String? purpose;
  final RequestStatus analyzeStatus;

 
  final double estimatedValue;
  final double minValue;
  final double maxValue;
  final String marketComparison;
  final RequestStatus saveStatus;

 
  @override
  List<Object?> get props => [
        selectedType,
        location,
        area,
        propertyAge,
        finishingLevel,
        purpose,
        analyzeStatus,
         estimatedValue,
        minValue,
        maxValue,
        marketComparison,
        saveStatus,
      ];

  RatePropertyEstimationState copyWith({
    String? selectedType,
    String? location,
    String? area,
    String? propertyAge,
    String? finishingLevel,
    String? purpose,
    RequestStatus? analyzeStatus,
     double? estimatedValue,
    double? minValue,
    double? maxValue,
    String? marketComparison,
    RequestStatus? saveStatus,
  }) {
    return RatePropertyEstimationState(
      selectedType: selectedType ?? this.selectedType,
      location: location ?? this.location,
      area: area ?? this.area,
      propertyAge: propertyAge ?? this.propertyAge,
      finishingLevel: finishingLevel ?? this.finishingLevel,
      purpose: purpose ?? this.purpose,
      analyzeStatus: analyzeStatus ?? this.analyzeStatus,
       estimatedValue: estimatedValue ?? this.estimatedValue,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      marketComparison: marketComparison ?? this.marketComparison,
      saveStatus: saveStatus ?? this.saveStatus,
    );
  }
}
