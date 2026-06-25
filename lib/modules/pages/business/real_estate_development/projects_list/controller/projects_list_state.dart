part of 'projects_list_bloc.dart';

class ProjectsListState extends Equatable {
  const ProjectsListState({
    this.status = RequestStatus.init,
    this.projects = const [],
    this.role = 'owner',
  });

  final RequestStatus status;
  final List<RealEstateProjectModel> projects;

  /// 'owner' | 'manager'
  final String role;

  ProjectsListState copyWith({
    RequestStatus? status,
    List<RealEstateProjectModel>? projects,
    String? role,
  }) => ProjectsListState(
        status: status ?? this.status,
        projects: projects ?? this.projects,
        role: role ?? this.role,
      );

  @override
  List<Object?> get props => [status, projects, role];
}
