part of 'rent_installment_bloc.dart';

sealed class RentInstallmentEvent extends Equatable {
  const RentInstallmentEvent();

  @override
  List<Object> get props => [];
}

final class RentInstallmentLoad extends RentInstallmentEvent {
  const RentInstallmentLoad();
}

final class RentInstallmentTabChanged extends RentInstallmentEvent {
  final int tabIndex;
  const RentInstallmentTabChanged(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
