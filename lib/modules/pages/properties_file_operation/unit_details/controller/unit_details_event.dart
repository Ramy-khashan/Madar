part of 'unit_details_bloc.dart';

abstract class UnitDetailsEvent extends Equatable {
  const UnitDetailsEvent();
  @override
  List<Object?> get props => [];
}

class UnitDetailsInit extends UnitDetailsEvent {
  const UnitDetailsInit(this.unit, {this.buildingId = ''});
  final UnitModel unit;
  final String buildingId;
  @override
  List<Object?> get props => [unit, buildingId];
}

class UnitDetailsStatusToggled extends UnitDetailsEvent {
  const UnitDetailsStatusToggled(this.status);
  final UnitStatus status;
  @override
  List<Object?> get props => [status];
}

class UnitDetailsDateTypeToggled extends UnitDetailsEvent {
  const UnitDetailsDateTypeToggled(this.isHijri);
  final bool isHijri;
  @override
  List<Object?> get props => [isHijri];
}

class UnitDetailsExpenseAdded extends UnitDetailsEvent {
  const UnitDetailsExpenseAdded({
    required this.description,
    required this.amount,
  });
  final String description;
  final double amount;
  @override
  List<Object?> get props => [description, amount];
}

class UnitDetailsExpenseRemoved extends UnitDetailsEvent {
  const UnitDetailsExpenseRemoved(this.index);
  final int index;
  @override
  List<Object?> get props => [index];
}

class UnitDetailsExpenseFilesPicked extends UnitDetailsEvent {
  const UnitDetailsExpenseFilesPicked(this.paths);
  final List<String> paths;
  @override
  List<Object?> get props => [paths];
}

class UnitDetailsDatePicked extends UnitDetailsEvent {
  const UnitDetailsDatePicked({required this.isStart, required this.date});
  final bool isStart;
  final DateTime date;
  @override
  List<Object?> get props => [isStart, date];
}

class UnitDetailsSaved extends UnitDetailsEvent {
  const UnitDetailsSaved();
}

class UnitDetailsDeleted extends UnitDetailsEvent {
  const UnitDetailsDeleted();
}

class UnitDetailsSentToBroker extends UnitDetailsEvent {
  const UnitDetailsSentToBroker();
}
