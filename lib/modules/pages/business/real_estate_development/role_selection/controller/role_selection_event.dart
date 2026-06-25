part of 'role_selection_bloc.dart';

sealed class RoleSelectionEvent extends Equatable {
  const RoleSelectionEvent();

  @override
  List<Object?> get props => [];
}

final class RoleSelectionRoleChanged extends RoleSelectionEvent {
  const RoleSelectionRoleChanged(this.role);

  /// 'owner' | 'manager'
  final String role;

  @override
  List<Object?> get props => [role];
}
