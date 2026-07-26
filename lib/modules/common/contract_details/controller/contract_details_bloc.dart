import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/print_state.dart';
import '../../../../core/utils/functions/service_locator.dart';
import '../model/contract_details_model.dart';

part 'contract_details_event.dart';
part 'contract_details_state.dart';

class ContractDetailsBloc
    extends Bloc<ContractDetailsEvent, ContractDetailsState> {
  ContractDetailsBloc() : super(const ContractDetailsState()) {
    on<ContractDetailsLoad>(_onLoad);
  }

  static ContractDetailsBloc get(BuildContext context) =>
      context.read<ContractDetailsBloc>();

  Future<void> _onLoad(
    ContractDetailsLoad event,
    Emitter<ContractDetailsState> emit,
  ) async {
    try {
      emit(state.copyWith(loadStatus: RequestStatus.loading));

      final response = await sl.get<ApiConsumer>().get(
        EndPoints.contractDetails(event.contractId),
      );

      await response.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              loadStatus: RequestStatus.failed,
              errorMsg: failedResponse,
            ),
          );
        },
        (successResponse) async {
          final data = ContractDetailsModel.fromJson(
            successResponse.response,
          );
          emit(
            state.copyWith(
              loadStatus: RequestStatus.success,
              contract: data,
              errorMsg: '',
            ),
          );
        },
      );
    } catch (e) {
      printState(e.toString());
      emit(
        state.copyWith(
          loadStatus: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
        ),
      );
    }
  }
}
