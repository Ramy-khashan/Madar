part of 'projects_list_bloc.dart';

sealed class ProjectsListEvent extends Equatable {
  const ProjectsListEvent();

  @override
  List<Object?> get props => [];
}

final class ProjectsListLoad extends ProjectsListEvent {
  const ProjectsListLoad(this.role);

  /// 'owner' | 'manager'
  final String role;

  @override
  List<Object?> get props => [role];
}
