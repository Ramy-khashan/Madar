part of 'rate_property_estimation_bloc.dart';

class RatePropertyEstimationState extends Equatable {
  const RatePropertyEstimationState({
    this.selectedType = '',
    this.propertyId = '',
    this.location = '',
    this.area = '',
    this.propertyAge = '',
    this.finishingLevel,
    this.purpose,
    this.suggestedProperties = const [],
    this.analyzeStatus = RequestStatus.init,
    this.periodDays = 0,
    this.minValue = 0,
    this.maxValue = 0,
    this.dealsCount = 0,
    this.saveStatus = RequestStatus.init,
  });

  final String propertyId;
  final String selectedType;
  final String location;
  final String area;
  final String propertyAge;
  final String? finishingLevel;
  final String? purpose;
  final RequestStatus analyzeStatus;

  final int periodDays;
  final double minValue;
  final double maxValue;
  final int dealsCount;
  final List<String> suggestedProperties;
  final RequestStatus saveStatus;

  @override
  List<Object?> get props => [
    propertyId,
    selectedType,
    location,
    area,
    propertyAge,
    finishingLevel,
    purpose,
    analyzeStatus,
    periodDays,
    minValue,
    maxValue,
    dealsCount,
    saveStatus,
    suggestedProperties,
  ];

  RatePropertyEstimationState copyWith({
    String? propertyId,
    String? selectedType,
    String? location,
    String? area,
    String? propertyAge,
    String? finishingLevel,
    String? purpose,
    RequestStatus? analyzeStatus,
    int? periodDays,
    double? minValue,
    double? maxValue,
    int? dealsCount,
    RequestStatus? saveStatus,
    List<String>? suggestedProperties,
  }) {
    return RatePropertyEstimationState(
      propertyId: propertyId ?? this.propertyId,
      selectedType: selectedType ?? this.selectedType,
      location: location ?? this.location,
      area: area ?? this.area,
      propertyAge: propertyAge ?? this.propertyAge,
      finishingLevel: finishingLevel ?? this.finishingLevel,
      purpose: purpose ?? this.purpose,
      analyzeStatus: analyzeStatus ?? this.analyzeStatus,
      periodDays: periodDays ?? this.periodDays,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      dealsCount: dealsCount ?? this.dealsCount,
      suggestedProperties: suggestedProperties ?? this.suggestedProperties,
      saveStatus: saveStatus ?? this.saveStatus,
    );
  }
}
