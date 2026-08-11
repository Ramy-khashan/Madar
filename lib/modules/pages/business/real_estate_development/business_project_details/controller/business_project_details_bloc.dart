import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/connection/concept/end_points.dart';
import '../../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/print_state.dart';
import '../../../../../../core/utils/functions/service_locator.dart';
import '../../projects_list/model/realstate_projects_model.dart';
import '../../../../../../../../../core/utils/constants/app_enums.dart';
import '../model/real_state_project_model.dart';

part 'business_project_details_event.dart';
part 'business_project_details_state.dart';

class BusinessProjectDetailsBloc
    extends Bloc<BusinessProjectDetailsEvent, BusinessProjectDetailsState> {
  BusinessProjectDetailsBloc() : super(const BusinessProjectDetailsState()) {
    on<BusinessProjectDetailsLoad>(_onLoad);
    // on<BusinessProjectDetailsAddTimeline>(_onAddTimeline);
  }

  static BusinessProjectDetailsBloc get(BuildContext context) =>
      context.read<BusinessProjectDetailsBloc>();

  Future<void> _onLoad(
    BusinessProjectDetailsLoad event,
    Emitter<BusinessProjectDetailsState> emit,
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
