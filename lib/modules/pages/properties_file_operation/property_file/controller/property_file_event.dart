part of 'property_file_bloc.dart';

abstract class PropertyFileEvent extends Equatable {
  const PropertyFileEvent();
  @override
  List<Object?> get props => [];
}

class PropertyFileLoad extends PropertyFileEvent {
  const PropertyFileLoad({this.propertyId = ''});
  final String propertyId;
  @override
  List<Object?> get props => [propertyId];
}

class PropertyFileToggleBookmark extends PropertyFileEvent {
  const PropertyFileToggleBookmark();
}
 
class PropertyFileDeleteProperty extends PropertyFileEvent {
  const PropertyFileDeleteProperty();
}
