part of 'project_manager_home_bloc.dart';

abstract class ProjectManagerHomeEvent extends Equatable {
  const ProjectManagerHomeEvent();
  @override
  List<Object?> get props => [];
}

class ProjectManagerHomeLoad extends ProjectManagerHomeEvent {
  const ProjectManagerHomeLoad();
}
