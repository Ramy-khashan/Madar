part of 'construction_reports_bloc.dart';

sealed class ConstructionReportsEvent extends Equatable {
  const ConstructionReportsEvent();

  @override
  List<Object?> get props => [];
}

final class ConstructionReportsLoad extends ConstructionReportsEvent {
  const ConstructionReportsLoad();
}

final class ConstructionReportsPeriodChanged extends ConstructionReportsEvent {
  final String period;
  const ConstructionReportsPeriodChanged(this.period);

  @override
  List<Object?> get props => [period];
}

final class ConstructionReportsScopeChanged extends ConstructionReportsEvent {
  final String scope;
  const ConstructionReportsScopeChanged(this.scope);

  @override
  List<Object?> get props => [scope];
}

final class ConstructionReportsPropertyTypeToggled
    extends ConstructionReportsEvent {
  final String typeId;
  const ConstructionReportsPropertyTypeToggled(this.typeId);

  @override
  List<Object?> get props => [typeId];
}
