part of 'add_commercial_project_bloc.dart';

sealed class AddCommercialProjectEvent extends Equatable {
  const AddCommercialProjectEvent();

  @override
  List<Object?> get props => [];
}

final class AddCommercialPropertyTypeChanged extends AddCommercialProjectEvent {
  const AddCommercialPropertyTypeChanged(this.propertyType);

  final String propertyType;

  @override
  List<Object?> get props => [propertyType];
}

final class AddCommercialAreaTypeChanged extends AddCommercialProjectEvent {
  const AddCommercialAreaTypeChanged(this.areaType);

  final String? areaType;

  @override
  List<Object?> get props => [areaType];
}

final class AddCommercialPickDateRequested extends AddCommercialProjectEvent {
  const AddCommercialPickDateRequested(this.field);

  final CommercialDateField field;

  @override
  List<Object?> get props => [field];
}

final class AddCommercialDatePicked extends AddCommercialProjectEvent {
  const AddCommercialDatePicked(this.field, this.date);

  final CommercialDateField field;
  final String date;

  @override
  List<Object?> get props => [field, date];
}

final class AddCommercialDatePickCancelled extends AddCommercialProjectEvent {
  const AddCommercialDatePickCancelled();
}

final class AddCommercialManagerToggled extends AddCommercialProjectEvent {
  const AddCommercialManagerToggled(this.show);
  final bool show;
  @override
  List<Object?> get props => [show];
}

final class AddCommercialSendToManagerRequested
    extends AddCommercialProjectEvent {
  const AddCommercialSendToManagerRequested();
}

final class AddCommercialManagerLoginResult extends AddCommercialProjectEvent {
  const AddCommercialManagerLoginResult(this.success);

  final bool success;

  @override
  List<Object?> get props => [success];
}

final class AddCommercialSuccessDialogDismissed
    extends AddCommercialProjectEvent {
  const AddCommercialSuccessDialogDismissed();
}

final class AddCommercialSubmit extends AddCommercialProjectEvent {
  const AddCommercialSubmit();
}

final class AddCommercialReset extends AddCommercialProjectEvent {
  const AddCommercialReset();
}
