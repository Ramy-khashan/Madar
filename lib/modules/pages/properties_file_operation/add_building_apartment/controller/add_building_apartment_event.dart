part of 'add_building_apartment_bloc.dart';

sealed class AddBuildingApartmentEvent extends Equatable {
  const AddBuildingApartmentEvent();
  @override
  List<Object?> get props => [];
}

class AddApartmentStatusChanged extends AddBuildingApartmentEvent {
  const AddApartmentStatusChanged(this.status);
  final String status;
  @override
  List<Object?> get props => [status];
}

class AddApartmentCalendarChanged extends AddBuildingApartmentEvent {
  const AddApartmentCalendarChanged(this.isHijri);
  final bool isHijri;
  @override
  List<Object?> get props => [isHijri];
}

class AddApartmentDatePicked extends AddBuildingApartmentEvent {
  const AddApartmentDatePicked({required this.isStart, required this.date});
  final bool isStart;
  final DateTime date;
  @override
  List<Object?> get props => [isStart, date];
}

class AddApartmentSubmit extends AddBuildingApartmentEvent {
  const AddApartmentSubmit();
}
