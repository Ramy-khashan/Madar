part of 'add_property_bloc.dart';

abstract class AddPropertyEvent extends Equatable {
  const AddPropertyEvent();
  @override
  List<Object?> get props => [];
}

// ─── Navigation ────────────────────────────────────────────────────────────

class NextStepEvent extends AddPropertyEvent {
  const NextStepEvent();
}

class PreviousStepEvent extends AddPropertyEvent {
  const PreviousStepEvent();
}

// ─── Step 1 — Type ─────────────────────────────────────────────────────────

class SelectOperationTypeEvent extends AddPropertyEvent {
  const SelectOperationTypeEvent(this.type);
  final String type; // 'sell' | 'rent'
  @override
  List<Object?> get props => [type];
}

class SelectPropertyTypeEvent extends AddPropertyEvent {
  const SelectPropertyTypeEvent(this.typeId);
  final String typeId;
  @override
  List<Object?> get props => [typeId];
}

// ─── Step 2 — Rental Period ────────────────────────────────────────────────

class SelectRentalPeriodEvent extends AddPropertyEvent {
  const SelectRentalPeriodEvent(this.period);
  final String period; // 'monthly' | 'semi_annual' | 'annual'
  @override
  List<Object?> get props => [period];
}

// ─── Step 3 — Location & Deed ──────────────────────────────────────────────

class UpdateLocationEvent extends AddPropertyEvent {
  const UpdateLocationEvent(this.location);
  final String location;
  @override
  List<Object?> get props => [location];
}

class SelectDeedTypeEvent extends AddPropertyEvent {
  const SelectDeedTypeEvent(this.deedType);
  final String deedType;
  @override
  List<Object?> get props => [deedType];
}

class SelectDateTypeEvent extends AddPropertyEvent {
  const SelectDateTypeEvent(this.dateType);
  final String dateType; // 'hijri' | 'gregorian'
  @override
  List<Object?> get props => [dateType];
}

// ─── Step 4 — Images ───────────────────────────────────────────────────────

class AddImageEvent extends AddPropertyEvent {
  const AddImageEvent(this.path);
  final String path;
  @override
  List<Object?> get props => [path];
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

class ToggleVideoEvent extends AddPropertyEvent {
  const ToggleVideoEvent();
}

class Toggle360TourEvent extends AddPropertyEvent {
  const Toggle360TourEvent();
}

// ─── Step 5 — Details ──────────────────────────────────────────────────────

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
  final String field; // 'beds' | 'baths' | 'lounges' | 'majlis'
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

class ToggleAmenityEvent extends AddPropertyEvent {
  const ToggleAmenityEvent(this.amenityId);
  final String amenityId;
  @override
  List<Object?> get props => [amenityId];
}

// ─── Step 6 — Price & Review ───────────────────────────────────────────────

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

class SelectPortfolioModeEvent extends AddPropertyEvent {
  const SelectPortfolioModeEvent(this.isNew);
  final bool isNew;
  @override
  List<Object?> get props => [isNew];
}

class ConfirmSaveEvent extends AddPropertyEvent {
  const ConfirmSaveEvent();
}

class SendToBrokerEvent extends AddPropertyEvent {
  const SendToBrokerEvent();
}
