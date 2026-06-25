part of 'property_insurance_bloc.dart';

sealed class PropertyInsuranceEvent extends Equatable {
  const PropertyInsuranceEvent();

  @override
  List<Object> get props => [];
}

final class PropertyInsuranceLoad extends PropertyInsuranceEvent {
  const PropertyInsuranceLoad();
}

final class PropertyInsuranceTabChanged extends PropertyInsuranceEvent {
  final int tabIndex;
  const PropertyInsuranceTabChanged(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
