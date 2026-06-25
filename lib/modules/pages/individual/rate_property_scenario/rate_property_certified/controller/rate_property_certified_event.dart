part of 'rate_property_certified_bloc.dart';

abstract class RatePropertyCertifiedEvent extends Equatable {
  const RatePropertyCertifiedEvent();

  @override
  List<Object?> get props => [];
}

class RatePropertyCertifiedTypeSelected extends RatePropertyCertifiedEvent {
  final String typeId;
  const RatePropertyCertifiedTypeSelected(this.typeId);

  @override
  List<Object?> get props => [typeId];
}

class RatePropertyCertifiedFieldChanged extends RatePropertyCertifiedEvent {
  final String? location;
  final String? area;
  final String? propertyAge;
  final String? finishingLevel;
  final String? purpose;

  const RatePropertyCertifiedFieldChanged({
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

class RatePropertyCertifiedNextStep extends RatePropertyCertifiedEvent {
  const RatePropertyCertifiedNextStep();
}

class RatePropertyCertifiedPrevStep extends RatePropertyCertifiedEvent {
  const RatePropertyCertifiedPrevStep();
}

class RatePropertyCertifiedFileAdded extends RatePropertyCertifiedEvent {
  final String fileKey;
  final String fileName;
  final double sizeKb;

  const RatePropertyCertifiedFileAdded({
    required this.fileKey,
    required this.fileName,
    required this.sizeKb,
  });

  @override
  List<Object?> get props => [fileKey, fileName, sizeKb];
}

class RatePropertyCertifiedFileRemoved extends RatePropertyCertifiedEvent {
  final String fileKey;
  const RatePropertyCertifiedFileRemoved(this.fileKey);

  @override
  List<Object?> get props => [fileKey];
}

class RatePropertyCertifiedLoadCompanies extends RatePropertyCertifiedEvent {
  const RatePropertyCertifiedLoadCompanies();
}

class RatePropertyCertifiedCompanySelected extends RatePropertyCertifiedEvent {
  final String companyId;
  const RatePropertyCertifiedCompanySelected(this.companyId);

  @override
  List<Object?> get props => [companyId];
}

class RatePropertyCertifiedSubmit extends RatePropertyCertifiedEvent {
  const RatePropertyCertifiedSubmit();
}
