import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'role_selection_event.dart';
part 'role_selection_state.dart';

class RoleSelectionBloc
    extends Bloc<RoleSelectionEvent, RoleSelectionState> {
  RoleSelectionBloc() : super(const RoleSelectionState()) {
    on<RoleSelectionRoleChanged>(_onRoleChanged);
  }

  static RoleSelectionBloc get(BuildContext context) =>
      context.read<RoleSelectionBloc>();

  void _onRoleChanged(
    RoleSelectionRoleChanged event,
    Emitter<RoleSelectionState> emit,
  ) {
    emit(state.copyWith(selectedRole: event.role));
  }
}
