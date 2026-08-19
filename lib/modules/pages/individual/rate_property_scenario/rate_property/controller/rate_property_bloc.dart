import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madar_app/core/connection/concept/end_points.dart';

import '../../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/service_locator.dart';
import '../model/rate_property_model.dart';

part 'rate_property_event.dart';
part 'rate_property_state.dart';

class RatePropertyBloc extends Bloc<RatePropertyEvent, RatePropertyState> {
  RatePropertyBloc() : super(const RatePropertyState()) {
    on<RatePropertyLoad>(_onLoad);
    on<RatePropertyTabChanged>(_onTabChanged);
  }

  static RatePropertyBloc get(BuildContext context) =>
      BlocProvider.of<RatePropertyBloc>(context);

  Future<void> _onLoad(
    RatePropertyLoad event,
    Emitter<RatePropertyState> emit,
  ) async {
    emit(state.copyWith(loadStatus: RequestStatus.success, requests: []));
    // try {
    //   emit(state.copyWith(loadStatus: RequestStatus.loading));
    //   final res = await sl.get<ApiConsumer>().get(
    //     EndPoints.propertyEvaluations,
    //   );
    //   await res.fold(
    //     (failureResponse) {
    //       emit(
    //         state.copyWith(
    //           loadStatus: RequestStatus.failed,
    //           errorMsg: failureResponse,
    //         ),
    //       );
    //     },
    //     (successResponse) {
    //       emit(state.copyWith(loadStatus: RequestStatus.success, requests: []));
    //     },
    //   );
    // } catch (e) {
    //   emit(
    //     state.copyWith(
    //       loadStatus: RequestStatus.failed,
    //       errorMsg: AppStrings.somethingWentWrong,
    //     ),
    //   );
    // }
  }

  void _onTabChanged(
    RatePropertyTabChanged event,
    Emitter<RatePropertyState> emit,
  ) {
    emit(state.copyWith(currentTab: event.index));
  }
}
