part of 'role_selection_bloc.dart';

class RoleSelectionState extends Equatable {
  const RoleSelectionState({this.selectedRole = ''});

  /// 'owner' | 'manager'
  final String selectedRole;

  RoleSelectionState copyWith({String? selectedRole}) => RoleSelectionState(
        selectedRole: selectedRole ?? this.selectedRole,
      );

  @override
  List<Object?> get props => [selectedRole];
}
