import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart' ;
import '../../../../../core/utils/functions/service_locator.dart';
import '../../../business/real_estate_development/projects_list/model/realstate_projects_model.dart';
part 'project_manager_home_event.dart';
part 'project_manager_home_state.dart';

class ProjectManagerHomeBloc
    extends Bloc<ProjectManagerHomeEvent, ProjectManagerHomeState> {
  ProjectManagerHomeBloc() : super(const ProjectManagerHomeState()) {
    on<ProjectManagerHomeLoad>(_onLoad);
  }

  static ProjectManagerHomeBloc get(BuildContext context) =>
      context.read<ProjectManagerHomeBloc>();

  Future<void> _onLoad(
    ProjectManagerHomeLoad event,
    Emitter<ProjectManagerHomeState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingStatus: RequestStatus.loading));
      final res = await sl.get<ApiConsumer>().get(EndPoints.realEstateProjects);
      await res.fold(
        (l) {
          emit(
            state.copyWith(loadingStatus: RequestStatus.failed, errorMsg: l),
          );
        },
        (res) {
          final projects = (res.response['data'] as List)
              .map((e) => RealStateProjectsModel.fromJson(e))
              .toList();
          emit(
            state.copyWith(
              loadingStatus: RequestStatus.success,
              projects: projects,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatus: RequestStatus.failed,
          errorMsg: e.toString(),
        ),
      );
    }
  }
}
