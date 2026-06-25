import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/project_model.dart';

part 'phase_details_event.dart';
part 'phase_details_state.dart';

class PhaseDetailsBloc extends Bloc<PhaseDetailsEvent, PhaseDetailsState> {
  PhaseDetailsBloc({required PhaseModel phase})
      : super(PhaseDetailsState(phase: phase)) {
    on<ToggleTaskEvent>(_onToggleTask);
    on<AddPhaseImageEvent>(_onAddImage);
    on<RemovePhaseImageEvent>(_onRemoveImage);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<UpdateCustomTaskEvent>(_onUpdateCustomTask);
    on<ApprovePhaseEvent>(_onApprovePhase);
  }

  final noteController = TextEditingController();
  final customTaskController = TextEditingController();

  static PhaseDetailsBloc get(BuildContext context) =>
      context.read<PhaseDetailsBloc>();

  void _onToggleTask(ToggleTaskEvent event, Emitter<PhaseDetailsState> emit) {
    final updatedTasks = state.phase.tasks.map((t) {
      return t.id == event.taskId ? t.copyWith(isCompleted: !t.isCompleted) : t;
    }).toList();
    emit(state.copyWith(phase: state.phase.copyWith(tasks: updatedTasks)));
  }

  void _onAddImage(AddPhaseImageEvent event, Emitter<PhaseDetailsState> emit) {
    final updated = List<String>.from(state.phase.imagePaths)..add(event.path);
    emit(state.copyWith(phase: state.phase.copyWith(imagePaths: updated)));
  }

  void _onRemoveImage(
      RemovePhaseImageEvent event, Emitter<PhaseDetailsState> emit) {
    final updated = List<String>.from(state.phase.imagePaths)
      ..removeAt(event.index);
    emit(state.copyWith(phase: state.phase.copyWith(imagePaths: updated)));
  }

  void _onUpdateNote(UpdateNoteEvent event, Emitter<PhaseDetailsState> emit) {
    emit(state.copyWith(phase: state.phase.copyWith(note: event.note)));
  }

  void _onUpdateCustomTask(
      UpdateCustomTaskEvent event, Emitter<PhaseDetailsState> emit) {
    emit(state.copyWith(
        phase: state.phase.copyWith(customTask: event.value)));
  }

  void _onApprovePhase(
      ApprovePhaseEvent event, Emitter<PhaseDetailsState> emit) {
    emit(state.copyWith(isApproving: true));
    emit(state.copyWith(
      isApproving: false,
      phase: state.phase.copyWith(status: 'completed'),
    ));
  }

  @override
  Future<void> close() {
    noteController.dispose();
    customTaskController.dispose();
    return super.close();
  }
}
