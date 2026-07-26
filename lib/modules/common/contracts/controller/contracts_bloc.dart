import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/print_state.dart';
import '../../../../core/utils/functions/service_locator.dart';
import '../model/contract_model.dart';
import '../model/tabs_model.dart';

part 'contracts_event.dart';
part 'contracts_state.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  ContractsBloc() : super(const ContractsState()) {
    on<ContractsLoad>(_onLoad);
    on<ContractsFilterChanged>(_onFilterChanged);
  }

  static ContractsBloc get(BuildContext context) =>
      context.read<ContractsBloc>();

  int pageSize = 10;

  Future<void> _onLoad(
    ContractsLoad event,
    Emitter<ContractsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          contractsStatus: RequestStatus.loading,
          isLoadMore: event.isLoadMore,
        ),
      );

      final queryParams = <String, dynamic>{
        'page': event.page,
        'limit': pageSize,
        if (state.selectedFilter != 'ALL') 'status': state.selectedFilter,
      };

      final response = await sl.get<ApiConsumer>().get(
        EndPoints.getContracts,
        queryParameters: queryParams,
      );

      await response.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              contractsStatus: RequestStatus.failed,
              errorMsg: failedResponse,
              isLoadMore: false,
            ),
          );
        },
        (successResponse) async {
          final List<ContractModel> items = [];
          for (var item in List.from(
            successResponse.response['contracts'] ?? [],
          )) {
            items.add(ContractModel.fromJson(item));
          }

          emit(
            state.copyWith(
              contractsStatus: RequestStatus.success,
              contracts: items,
              totalCount: successResponse.response['total'] ?? 0,
              isLoadMore: false,
            ),
          );
        },
      );
    } catch (e) {
      printState(e.toString());
      emit(
        state.copyWith(
          contractsStatus: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
          isLoadMore: false,
        ),
      );
    }
  }

  void _onFilterChanged(
    ContractsFilterChanged event,
    Emitter<ContractsState> emit,
  ) {
    emit(state.copyWith(selectedFilter: event.filter, contracts: [], totalCount: 0));
    add(const ContractsLoad());
  }

  static List<ContractTabsModel> tabs = [
    ContractTabsModel(id: 'ALL', title: AppStrings.allTab),
    ContractTabsModel(id: 'ACTIVE', title: AppStrings.activeStatus),
    ContractTabsModel(id: 'PENDING', title: AppStrings.pendingStatus),
    ContractTabsModel(id: 'UNDER_REVIEW', title: AppStrings.underReviewStatus),
    ContractTabsModel(id: 'COMPLETED', title: AppStrings.completedStatus),
  ];
}
