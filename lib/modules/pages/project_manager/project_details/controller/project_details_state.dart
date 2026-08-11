part of 'project_details_bloc.dart';

class ProjectDetailsState extends Equatable {
  const ProjectDetailsState({
    this.status = RequestStatus.init,
    this.errorMessage = '',
    this.projectId = '',
    this.project,
  });

  final RequestStatus status;
  final RealStateProjectModel? project;
  final String errorMessage;
  final String projectId;

  ProjectDetailsState copyWith({
    RequestStatus? status,
    String? errorMessage,
    RealStateProjectModel? project,
    String? projectId,
  }) => ProjectDetailsState(
    status: status ?? this.status,
    project: project ?? this.project,
    errorMessage: errorMessage ?? this.errorMessage,
    projectId: projectId ?? this.projectId,
  );

  @override
  List<Object?> get props => [status, project, errorMessage, projectId];
}
