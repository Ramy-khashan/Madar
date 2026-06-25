part of 'add_residential_project_bloc.dart';

sealed class AddResidentialProjectEvent extends Equatable {
  const AddResidentialProjectEvent();

  @override
  List<Object?> get props => [];
}

final class AddResidentialPropertyTypeChanged
    extends AddResidentialProjectEvent {
  const AddResidentialPropertyTypeChanged(this.propertyType);

  final String propertyType;

  @override
  List<Object?> get props => [propertyType];
}

final class AddResidentialManagerToggled extends AddResidentialProjectEvent {
  const AddResidentialManagerToggled(this.show);

  final bool show;

  @override
  List<Object?> get props => [show];
}
 
final class AddResidentialPickDateRequested extends AddResidentialProjectEvent {
  const AddResidentialPickDateRequested(this.field);

  final ResidentialDateField field;

  @override
  List<Object?> get props => [field];
}

final class AddResidentialDatePicked extends AddResidentialProjectEvent {
  const AddResidentialDatePicked(this.field, this.date);

  final ResidentialDateField field;
  final String date;

  @override
  List<Object?> get props => [field, date];
}

final class AddResidentialDatePickCancelled extends AddResidentialProjectEvent {
  const AddResidentialDatePickCancelled();
}

final class AddResidentialSendToManagerRequested
    extends AddResidentialProjectEvent {
  const AddResidentialSendToManagerRequested();
}

final class AddResidentialManagerLoginResult extends AddResidentialProjectEvent {
  const AddResidentialManagerLoginResult(this.success);

  final bool success;

  @override
  List<Object?> get props => [success];
}

final class AddResidentialSuccessDialogDismissed
    extends AddResidentialProjectEvent {
  const AddResidentialSuccessDialogDismissed();
}

final class AddResidentialSubmit extends AddResidentialProjectEvent {
  const AddResidentialSubmit();
}

final class AddResidentialReset extends AddResidentialProjectEvent {
  const AddResidentialReset();
}
