part of 'project_details_bloc.dart';

abstract class ProjectDetailsEvent extends Equatable {
  const ProjectDetailsEvent();
  @override
  List<Object?> get props => [];
}

class ProjectDetailsLoad extends ProjectDetailsEvent {
  final String projectId;
  const ProjectDetailsLoad({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}
