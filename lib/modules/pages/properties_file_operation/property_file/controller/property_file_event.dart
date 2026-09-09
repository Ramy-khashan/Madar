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

class PropertyFilePublishRequested extends PropertyFileEvent {
  const PropertyFilePublishRequested({
    required this.adLicenseNumber,
    required this.falLicenseNumber,
  });

  final String adLicenseNumber;
  final String falLicenseNumber;

  @override
  List<Object?> get props => [adLicenseNumber, falLicenseNumber];
}

class PropertyFileStatusToggled extends PropertyFileEvent {
  const PropertyFileStatusToggled(this.status);
  final UnitStatus status;
  @override
  List<Object?> get props => [status];
}

class PropertyFileDateTypeToggled extends PropertyFileEvent {
  const PropertyFileDateTypeToggled(this.isHijri);
  final bool isHijri;
  @override
  List<Object?> get props => [isHijri];
}

class PropertyFileDatePicked extends PropertyFileEvent {
  const PropertyFileDatePicked({required this.isStart, required this.date});
  final bool isStart;
  final DateTime date;
  @override
  List<Object?> get props => [isStart, date];
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
