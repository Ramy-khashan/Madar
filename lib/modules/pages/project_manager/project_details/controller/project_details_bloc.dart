import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/print_state.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../../../business/real_estate_development/business_project_details/model/real_state_project_model.dart';
 
part 'project_details_event.dart';
part 'project_details_state.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  ProjectDetailsBloc() : super(const ProjectDetailsState()) {
    on<ProjectDetailsLoad>(_onLoad);
    // on<ProjectDetailsAddTimeline>(_onAddTimeline);
  }

  static ProjectDetailsBloc get(BuildContext context) =>
      context.read<ProjectDetailsBloc>();

  Future<void> _onLoad(
    ProjectDetailsLoad event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: RequestStatus.loading,
          projectId: event.projectId,
        ),
      );
      final res = await sl.get<ApiConsumer>().get(
        '${EndPoints.realEstateProjects}/${event.projectId}',
      );
      res.fold(
        (failure) {
          emit(
            state.copyWith(status: RequestStatus.failed, errorMessage: failure),
          );
        },
        (data) {
          final project = RealStateProjectModel.fromJson(data.response);
          emit(state.copyWith(status: RequestStatus.success, project: project));
        },
      );
    } catch (e) {
      printState('Error loading project details: $e');
      emit(
        state.copyWith(
          status: RequestStatus.failed,
          errorMessage: AppStrings.somethingWentWrong,
        ),
      );
    }
  }
}
