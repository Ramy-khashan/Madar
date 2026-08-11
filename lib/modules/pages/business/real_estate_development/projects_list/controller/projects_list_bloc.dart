import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/connection/concept/end_points.dart';
import '../../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../../core/utils/functions/service_locator.dart';
 import '../../../../../../../../../core/utils/constants/app_enums.dart';
import '../model/realstate_projects_model.dart';

part 'projects_list_event.dart';
part 'projects_list_state.dart';

class ProjectsListBloc extends Bloc<ProjectsListEvent, ProjectsListState> {
  ProjectsListBloc() : super(const ProjectsListState()) {
    on<ProjectsListLoad>(_onLoad);
  }

  static ProjectsListBloc get(BuildContext context) =>
      context.read<ProjectsListBloc>();

  Future<void> _onLoad(
    ProjectsListLoad event,
    Emitter<ProjectsListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: RequestStatus.loading));
      final res = await sl.get<ApiConsumer>().get(EndPoints.realEstateProjects);
      await res.fold(
        (failure) async {
          emit(
            state.copyWith(status: RequestStatus.failed, errorMessage: failure),
          );
        },
        (data) async {
          final projects = (data.response['data'] as List)
              .map((e) => RealStateProjectsModel.fromJson(e))
              .toList();
          emit(
            state.copyWith(status: RequestStatus.success, projects: projects),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.failed,
          errorMessage: e.toString(),
        ),
      );
    }
    // if (mockProjects.isEmpty) {
    //   emit(state.copyWith(status: RequestStatus.failed, projects: const []));
    // } else {
    //   emit(
    //     state.copyWith(
    //       status: RequestStatus.success,
    //       projects: [],
    //      ),
    //   );
    // }
  }
}
