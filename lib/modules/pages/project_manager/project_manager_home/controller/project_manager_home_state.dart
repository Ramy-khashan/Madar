part of 'project_manager_home_bloc.dart';

class ProjectManagerHomeState extends Equatable {
  const ProjectManagerHomeState({
    this.projects = const [],
    this.loadingStatus = RequestStatus.init,
    this.errorMsg = '',
  });

  final List<RealStateProjectsModel> projects;
  final RequestStatus loadingStatus;
  final String errorMsg;

  ProjectManagerHomeState copyWith({
    List<RealStateProjectsModel>? projects,
    RequestStatus? loadingStatus,
    String? errorMsg,
  }) {
    return ProjectManagerHomeState(
      projects: projects ?? this.projects,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [projects, loadingStatus,errorMsg];
}
