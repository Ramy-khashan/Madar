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

final class AddResidentialManagerLoginResult
    extends AddResidentialProjectEvent {
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

final class AddResidentialFetchStages extends AddResidentialProjectEvent {
  const AddResidentialFetchStages();
}

final class AddResidentialStageToggled extends AddResidentialProjectEvent {
  const AddResidentialStageToggled(this.stageId);

  final String stageId;

  @override
  List<Object?> get props => [stageId];
}

final class AddResidentialSubStageToggled extends AddResidentialProjectEvent {
  const AddResidentialSubStageToggled(this.stageId, this.subStageId);

  final String stageId;
  final String subStageId;

  @override
  List<Object?> get props => [stageId, subStageId];
}

final class AddResidentialImagesSelected extends AddResidentialProjectEvent {
  const AddResidentialImagesSelected(this.paths);

  final List<String> paths;

  @override
  List<Object?> get props => [paths];
}

final class AddResidentialImageRemoved extends AddResidentialProjectEvent {
  const AddResidentialImageRemoved(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

final class AddResidentialCustomSubStageAdded
    extends AddResidentialProjectEvent {
  const AddResidentialCustomSubStageAdded(this.stageId, this.name);

  final String stageId;
  final String name;

  @override
  List<Object?> get props => [stageId, name];
}

final class AddResidentialCustomSubStageRemoved
    extends AddResidentialProjectEvent {
  const AddResidentialCustomSubStageRemoved(this.stageId, this.index);

  final String stageId;
  final int index;

  @override
  List<Object?> get props => [stageId, index];
}
