part of 'insurance_options_bloc.dart';

abstract class InsuranceOptionsEvent extends Equatable {
  const InsuranceOptionsEvent();

  @override
  List<Object?> get props => [];
}

class InsuranceOptionsLoad extends InsuranceOptionsEvent {
  final String propertyId;
  const InsuranceOptionsLoad(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}

class InsuranceOptionsTypeSelected extends InsuranceOptionsEvent {
  final String typeId;
  const InsuranceOptionsTypeSelected(this.typeId);

  @override
  List<Object?> get props => [typeId];
}

class InsuranceOptionsCompanySelected extends InsuranceOptionsEvent {
  final String companyId;
  const InsuranceOptionsCompanySelected(this.companyId);

  @override
  List<Object?> get props => [companyId];
}

class InsuranceOptionsConfirm extends InsuranceOptionsEvent {
  const InsuranceOptionsConfirm();
}
