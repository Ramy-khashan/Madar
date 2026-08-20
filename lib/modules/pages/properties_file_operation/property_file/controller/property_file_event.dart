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

class PropertyFileSaveChanges extends PropertyFileEvent {
  const PropertyFileSaveChanges();
}

class PropertyFileExpenseAdded extends PropertyFileEvent {
  const PropertyFileExpenseAdded();
}

class PropertyFileExpenseRemoved extends PropertyFileEvent {
  const PropertyFileExpenseRemoved(this.index);
  final int index;
  @override
  List<Object?> get props => [index];
}

class PropertyFileExpenseFilesPicked extends PropertyFileEvent {
  const PropertyFileExpenseFilesPicked(this.paths);
  final List<String> paths;
  @override
  List<Object?> get props => [paths];
}
