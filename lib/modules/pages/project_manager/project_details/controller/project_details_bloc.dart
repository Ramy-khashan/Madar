import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/project_model.dart';

part 'project_details_event.dart';
part 'project_details_state.dart';
  
class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  ProjectDetailsBloc({required ProjectModel project})
      : super(ProjectDetailsState(project: project)) {
    on<ProjectDetailsLoad>((event, emit) {});
  }

  static ProjectDetailsBloc get(BuildContext context) =>
      context.read<ProjectDetailsBloc>();
}
