part of 'project_details_bloc.dart';

class ProjectDetailsState extends Equatable {
  const ProjectDetailsState({required this.project});

  final ProjectModel project;

  @override
  List<Object?> get props => [project];
}
