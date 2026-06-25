part of 'project_manager_home_bloc.dart';

class ProjectManagerHomeState extends Equatable {
  const ProjectManagerHomeState({
    this.projects = const [],
    this.isLoading = false,
  });

  final List<ProjectModel> projects;
  final bool isLoading;

  ProjectManagerHomeState copyWith({
    List<ProjectModel>? projects,
    bool? isLoading,
  }) {
    return ProjectManagerHomeState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [projects, isLoading];
}
