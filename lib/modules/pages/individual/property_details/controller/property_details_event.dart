part of 'property_details_bloc.dart';

abstract class PropertyDetailsEvent extends Equatable {
  const PropertyDetailsEvent();

  @override
  List<Object?> get props => [];
}

class PropertyDetailsLoad extends PropertyDetailsEvent {
  final String propertyId;
  const PropertyDetailsLoad(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}

class PropertyDetailsToggleBookmark extends PropertyDetailsEvent {
  const PropertyDetailsToggleBookmark();
}

class PropertyDetailsSubmitRequest extends PropertyDetailsEvent {
  const PropertyDetailsSubmitRequest();
}
