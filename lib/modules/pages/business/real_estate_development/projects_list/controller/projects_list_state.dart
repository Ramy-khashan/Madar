part of 'projects_list_bloc.dart';

class ProjectsListState extends Equatable {
  const ProjectsListState({
    this.status = RequestStatus.init,
    this.projects = const [],
   });

  final RequestStatus status;
  final List<RealEstateProjectModel> projects;

  
  ProjectsListState copyWith({
    RequestStatus? status,
    List<RealEstateProjectModel>? projects,
    String? role,
  }) => ProjectsListState(
        status: status ?? this.status,
        projects: projects ?? this.projects,
       );

  @override
  List<Object?> get props => [status, projects];
}
