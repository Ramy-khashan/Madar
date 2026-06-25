part of 'phase_details_bloc.dart';

abstract class PhaseDetailsEvent extends Equatable {
  const PhaseDetailsEvent();
  @override
  List<Object?> get props => [];
}

class ToggleTaskEvent extends PhaseDetailsEvent {
  const ToggleTaskEvent(this.taskId);
  final String taskId;
  @override
  List<Object?> get props => [taskId];
}

class AddPhaseImageEvent extends PhaseDetailsEvent {
  const AddPhaseImageEvent(this.path);
  final String path;
  @override
  List<Object?> get props => [path];
}

class RemovePhaseImageEvent extends PhaseDetailsEvent {
  const RemovePhaseImageEvent(this.index);
  final int index;
  @override
  List<Object?> get props => [index];
}

class UpdateNoteEvent extends PhaseDetailsEvent {
  const UpdateNoteEvent(this.note);
  final String note;
  @override
  List<Object?> get props => [note];
}

class UpdateCustomTaskEvent extends PhaseDetailsEvent {
  const UpdateCustomTaskEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class ApprovePhaseEvent extends PhaseDetailsEvent {
  const ApprovePhaseEvent();
}
