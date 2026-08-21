part of 'property_details_bloc.dart';

abstract class PropertyDetailsEvent extends Equatable {
  const PropertyDetailsEvent();

  @override
  List<Object?> get props => [];
}

class PropertyDetailsLoad extends PropertyDetailsEvent {
  final String propertyId;
  final String? brokerRequestId;
  final String? adLicenseNumber;

  const PropertyDetailsLoad(
    this.propertyId, {
    this.brokerRequestId,
    this.adLicenseNumber,
  });

  @override
  List<Object?> get props => [propertyId, brokerRequestId, adLicenseNumber];
}

class PropertyDetailsCheckIfPropertyIsSaved extends PropertyDetailsEvent {
  final String propertyId;
  const PropertyDetailsCheckIfPropertyIsSaved(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}

class AddedPropertyToSavedEvent extends PropertyDetailsEvent {
  final String propertyId;
  const AddedPropertyToSavedEvent(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}

class PropertyDetailsToggleBookmark extends PropertyDetailsEvent {
  const PropertyDetailsToggleBookmark();
}

class PropertyDetailsSubmitRequest extends PropertyDetailsEvent {
  const PropertyDetailsSubmitRequest();
}

class PropertyDetailsBrokerAccept extends PropertyDetailsEvent {
  const PropertyDetailsBrokerAccept({required this.adLicenseNumber});
  final String adLicenseNumber;

  @override
  List<Object?> get props => [adLicenseNumber];
}

class PropertyDetailsBrokerReject extends PropertyDetailsEvent {
  const PropertyDetailsBrokerReject({required this.rejectReason});
  final String rejectReason;

  @override
  List<Object?> get props => [rejectReason];
}
