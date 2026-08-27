import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repository/apis/contracts_apis.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/guest_mode.dart';
import '../../../../core/utils/functions/print_state.dart';
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
    if (GuestMode.isGuest) {
      emit(
        state.copyWith(
          contractsStatus: RequestStatus.success,
          contracts: [],
          isLoadMore: false,
        ),
      );
      return;
    }
    try {
      emit(
        state.copyWith(
          contractsStatus: event.isLoadMore
              ? state.contractsStatus
              : RequestStatus.loading,
          isLoadMore: event.isLoadMore,
          errorMsg: '',
        ),
      );

      final result = await ContractsApis.fetchContracts(
        page: event.page,
        pageSize: pageSize,
        status: state.selectedFilter,
      );

      result.fold(
        (failedResponse) {
          emit(
            state.copyWith(
              contractsStatus: RequestStatus.failed,
              errorMsg: failedResponse,
              isLoadMore: false,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              contractsStatus: RequestStatus.success,
              contracts: event.isLoadMore
                  ? [...state.contracts, ...success.items]
                  : success.items,
              totalCount: success.total,
              counts: success.counts,
              hasNext: success.hasNext,
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
    emit(
      state.copyWith(
        selectedFilter: event.filter,
        contracts: [],
        totalCount: 0,
        hasNext: false,
      ),
    );
    add(const ContractsLoad());
  }

  static List<ContractTabsModel> tabs = [
    ContractTabsModel(id: 'ALL', title: AppStrings.allTab),
    ContractTabsModel(id: 'PENDING', title: AppStrings.pendingStatus),
    ContractTabsModel(id: 'ACTIVE', title: AppStrings.activeStatus),
    ContractTabsModel(id: 'COMPLETED', title: AppStrings.completedStatus),
    ContractTabsModel(id: 'REJECTED', title: AppStrings.rejectedStatus),
    ContractTabsModel(id: 'CANCELLED', title: AppStrings.cancelledTab),
  ];
}
