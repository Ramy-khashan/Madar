part of 'rate_property_estimation_bloc.dart';

abstract class RatePropertyEstimationEvent extends Equatable {
  const RatePropertyEstimationEvent();

  @override
  List<Object?> get props => [];
}

class RatePropertyEstimationTypeSelected extends RatePropertyEstimationEvent {
  final String typeId;
  const RatePropertyEstimationTypeSelected(this.typeId);

  @override
  List<Object?> get props => [typeId];
}

class RatePropertyEstimationFieldChanged extends RatePropertyEstimationEvent {
  final String? location;
  final String? area;
  final String? propertyAge;
  final String? finishingLevel;
  final String? purpose;

  const RatePropertyEstimationFieldChanged({
    this.location,
    this.area,
    this.propertyAge,
    this.finishingLevel,
    this.purpose,
  });

  @override
  List<Object?> get props =>
      [location, area, propertyAge, finishingLevel, purpose];
}

class RatePropertyEstimationCalculate extends RatePropertyEstimationEvent {
  const RatePropertyEstimationCalculate();
}

class RatePropertyEstimationSave extends RatePropertyEstimationEvent {
  const RatePropertyEstimationSave();
}
