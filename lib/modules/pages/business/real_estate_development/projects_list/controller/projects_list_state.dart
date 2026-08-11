part of 'projects_list_bloc.dart';

class ProjectsListState extends Equatable {
  const ProjectsListState({
    this.status = RequestStatus.init,
    this.projects = const [],
    this.errorMessage='',
   });

  final RequestStatus status;
  final List<RealStateProjectsModel> projects;
  final String errorMessage;

  
  ProjectsListState copyWith({
    RequestStatus? status,
    List<RealStateProjectsModel>? projects,
    String? errorMessage,
    String? role,
  }) => ProjectsListState(
        status: status ?? this.status,
        projects: projects ?? this.projects,
        errorMessage: errorMessage ?? this.errorMessage,
       );

  @override
  List<Object?> get props => [status, projects, errorMessage];
}
