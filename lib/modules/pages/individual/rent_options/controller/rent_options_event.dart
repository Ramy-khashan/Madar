part of 'rent_options_bloc.dart';

abstract class RentOptionsEvent extends Equatable {
  const RentOptionsEvent();

  @override
  List<Object?> get props => [];
}

class RentOptionsLoad extends RentOptionsEvent {
  final String propertyId;
  const RentOptionsLoad(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}

class RentOptionsPlanSelected extends RentOptionsEvent {
  final String planId;
  const RentOptionsPlanSelected(this.planId);

  @override
  List<Object?> get props => [planId];
}

class RentOptionsProviderSelected extends RentOptionsEvent {
  final String providerId;
  const RentOptionsProviderSelected(this.providerId);

  @override
  List<Object?> get props => [providerId];
}

class RentOptionsConfirm extends RentOptionsEvent {
  const RentOptionsConfirm();
}
