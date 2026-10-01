part of 'add_property_bloc.dart';

abstract class AddPropertyEvent extends Equatable {
  const AddPropertyEvent();
  @override
  List<Object?> get props => [];
}

class NextStepEvent extends AddPropertyEvent {
  const NextStepEvent();
}

class PreviousStepEvent extends AddPropertyEvent {
  const PreviousStepEvent();
}

class SelectOperationTypeEvent extends AddPropertyEvent {
  const SelectOperationTypeEvent(this.type);
  final String type;
  @override
  List<Object?> get props => [type];
}

class SelectPropertyTypeEvent extends AddPropertyEvent {
  const SelectPropertyTypeEvent(this.typeId);
  final String typeId;
  @override
  List<Object?> get props => [typeId];
}

class SelectRentalPeriodEvent extends AddPropertyEvent {
  const SelectRentalPeriodEvent(this.period);
  final String period;
  @override
  List<Object?> get props => [period];
}

class UpdateLocationEvent extends AddPropertyEvent {
  const UpdateLocationEvent(this.location);
  final String location;
  @override
  List<Object?> get props => [location];
}

class UpdateCoordinatesEvent extends AddPropertyEvent {
  const UpdateCoordinatesEvent({
    required this.latitude,
    required this.longitude,
    this.city,
    this.district,
  });

  final double latitude;
  final double longitude;
  final String? city;
  final String? district;

  @override
  List<Object?> get props => [latitude, longitude, city, district];
}

class MapLocationSelectedEvent extends AddPropertyEvent {
  const MapLocationSelectedEvent({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}

class SearchPlacesEvent extends AddPropertyEvent {
  const SearchPlacesEvent(this.query);
  final String query;
  @override
  List<Object?> get props => [query];
}

class SelectPlaceEvent extends AddPropertyEvent {
  const SelectPlaceEvent(this.prediction);
  final PlacePrediction prediction;
  @override
  List<Object?> get props => [prediction];
}

class ClearPlaceSuggestionsEvent extends AddPropertyEvent {
  const ClearPlaceSuggestionsEvent();
}

class SelectDeedTypeEvent extends AddPropertyEvent {
  const SelectDeedTypeEvent(this.deedType);
  final String deedType;
  @override
  List<Object?> get props => [deedType];
}

class SelectDateTypeEvent extends AddPropertyEvent {
  const SelectDateTypeEvent(this.dateType);
  final String dateType;
  @override
  List<Object?> get props => [dateType];
}

class DeedDatePickedEvent extends AddPropertyEvent {
  const DeedDatePickedEvent(this.date);
  final DateTime date;
  @override
  List<Object?> get props => [date];
}

class AddImageEvent extends AddPropertyEvent {
  const AddImageEvent(this.path);
  final String path;
  @override
  List<Object?> get props => [path];
}

class AddImagesEvent extends AddPropertyEvent {
  const AddImagesEvent(this.paths);
  final List<String> paths;
  @override
  List<Object?> get props => [paths];
}

class RemoveImageEvent extends AddPropertyEvent {
  const RemoveImageEvent(this.index);
  final int index;
  @override
  List<Object?> get props => [index];
}

class ToggleAiEnhancementEvent extends AddPropertyEvent {
  const ToggleAiEnhancementEvent();
}

class SetVideoPathEvent extends AddPropertyEvent {
  const SetVideoPathEvent(this.path);
  final String path;
  @override
  List<Object?> get props => [path];
}

class ClearVideoEvent extends AddPropertyEvent {
  const ClearVideoEvent();
}

class SetVirtualTourPathEvent extends AddPropertyEvent {
  const SetVirtualTourPathEvent(this.path);
  final String path;
  @override
  List<Object?> get props => [path];
}

class ClearVirtualTourEvent extends AddPropertyEvent {
  const ClearVirtualTourEvent();
}

class SetDeedDocumentEvent extends AddPropertyEvent {
  const SetDeedDocumentEvent(this.path);
  final String path;
  @override
  List<Object?> get props => [path];
}

class ClearDeedDocumentEvent extends AddPropertyEvent {
  const ClearDeedDocumentEvent();
}

class PreviewEvaluationEvent extends AddPropertyEvent {
  const PreviewEvaluationEvent();
}

class ApplyAiDescriptionEvent extends AddPropertyEvent {
  const ApplyAiDescriptionEvent();
}

class SelectFacadeEvent extends AddPropertyEvent {
  const SelectFacadeEvent(this.facade);
  final String facade;
  @override
  List<Object?> get props => [facade];
}

class IncrementStreetCountEvent extends AddPropertyEvent {
  const IncrementStreetCountEvent();
}

class DecrementStreetCountEvent extends AddPropertyEvent {
  const DecrementStreetCountEvent();
}

class SelectStreetWidthEvent extends AddPropertyEvent {
  const SelectStreetWidthEvent(this.width);
  final String width;
  @override
  List<Object?> get props => [width];
}

class SelectPropertyAgeEvent extends AddPropertyEvent {
  const SelectPropertyAgeEvent(this.age);
  final String age;
  @override
  List<Object?> get props => [age];
}

class IncrementCounterEvent extends AddPropertyEvent {
  const IncrementCounterEvent(this.field);
  final String field;
  @override
  List<Object?> get props => [field];
}

class DecrementCounterEvent extends AddPropertyEvent {
  const DecrementCounterEvent(this.field);
  final String field;
  @override
  List<Object?> get props => [field];
}

class SelectDropdownEvent extends AddPropertyEvent {
  const SelectDropdownEvent(this.field, this.value);
  final String field;
  final String value;
  @override
  List<Object?> get props => [field, value];
}

class SetDetailFieldEvent extends AddPropertyEvent {
  const SetDetailFieldEvent(this.key, this.value);
  final String key;
  final dynamic value;
  @override
  List<Object?> get props => [key, value];
}

class ToggleDetailListItemEvent extends AddPropertyEvent {
  const ToggleDetailListItemEvent(this.key, this.value);
  final String key;
  final String value;
  @override
  List<Object?> get props => [key, value];
}

class IncrementDetailCounterEvent extends AddPropertyEvent {
  const IncrementDetailCounterEvent(this.key);
  final String key;
  @override
  List<Object?> get props => [key];
}

class DecrementDetailCounterEvent extends AddPropertyEvent {
  const DecrementDetailCounterEvent(this.key);
  final String key;
  @override
  List<Object?> get props => [key];
}

class ToggleDetailFlagEvent extends AddPropertyEvent {
  const ToggleDetailFlagEvent(this.key);
  final String key;
  @override
  List<Object?> get props => [key];
}

class ToggleAmenityEvent extends AddPropertyEvent {
  const ToggleAmenityEvent(this.amenityId);
  final String amenityId;
  @override
  List<Object?> get props => [amenityId];
}

class ToggleRentInstallmentEvent extends AddPropertyEvent {
  const ToggleRentInstallmentEvent();
}

class ToggleInsuranceEvent extends AddPropertyEvent {
  const ToggleInsuranceEvent();
}

class ShowPortfolioSheetEvent extends AddPropertyEvent {
  const ShowPortfolioSheetEvent();
}

class HidePortfolioSheetEvent extends AddPropertyEvent {
  const HidePortfolioSheetEvent();
}

class ConfirmSaveEvent extends AddPropertyEvent {
  const ConfirmSaveEvent({
    this.brokerId,
    this.openChooseBrokerOnSuccess = false,
    this.adLicenseNumber,
    this.falLicenseNumber,
  });
  final String? brokerId;
  final bool openChooseBrokerOnSuccess;
  final String? adLicenseNumber;
  final String? falLicenseNumber;
  @override
  List<Object?> get props => [
    brokerId,
    openChooseBrokerOnSuccess,
    adLicenseNumber,
    falLicenseNumber,
  ];
}

class SendToBrokerEvent extends AddPropertyEvent {
  const SendToBrokerEvent({this.brokerId});
  final String? brokerId;
  @override
  List<Object?> get props => [brokerId];
}
