import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repository/apis/contracts_apis.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/print_state.dart';
import '../model/contract_details_model.dart';

part 'contract_details_event.dart';
part 'contract_details_state.dart';

class ContractDetailsBloc
    extends Bloc<ContractDetailsEvent, ContractDetailsState> {
  ContractDetailsBloc() : super(const ContractDetailsState()) {
    on<ContractDetailsLoad>(_onLoad);
    on<ContractDetailsApprove>(_onApprove);
    on<ContractDetailsReject>(_onReject);
    on<ContractDetailsRenew>(_onRenew);
  }

  static ContractDetailsBloc get(BuildContext context) =>
      context.read<ContractDetailsBloc>();

  Future<void> _onLoad(
    ContractDetailsLoad event,
    Emitter<ContractDetailsState> emit,
  ) async {
    try {
        emit(
        state.copyWith(
          loadStatus: RequestStatus.loading,
          contractId: event.contractId,
          actionStatus: RequestStatus.init,
          actionMessage: '',
          shouldPop: false,
        ),
      );
      final result = await ContractsApis.fetchDetails(
        contractId: event.contractId,
      );
      result.fold(
        (failedResponse) {
          emit(
            state.copyWith(
              loadStatus: RequestStatus.failed,
              errorMsg: failedResponse,
            ),
          );
        },
        (data) {
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

  Future<void> _onApprove(
    ContractDetailsApprove event,
    Emitter<ContractDetailsState> emit,
  ) async {
    await _runAction(
      emit,
      () => ContractsApis.approve(
        contractId: _contractId,
        durationInYears: event.durationInYears,
        finalPrice: event.finalPrice,
      ),
      AppStrings.contractApprovedSuccess,
      popOnSuccess: true,
    );
  }

  Future<void> _onReject(
    ContractDetailsReject event,
    Emitter<ContractDetailsState> emit,
  ) async {
    await _runAction(
      emit,
      () => ContractsApis.reject(contractId: _contractId),
      AppStrings.contractRejectedSuccess,
      popOnSuccess: true,
    );
  }

  Future<void> _onRenew(
    ContractDetailsRenew event,
    Emitter<ContractDetailsState> emit,
  ) async {
    await _runAction(
      emit,
      () => ContractsApis.renew(contractId: _contractId),
      AppStrings.contractRenewedSuccess,
    );
  }

  String get _contractId =>
      state.contractId.isNotEmpty
          ? state.contractId
          : (state.contract?.id ?? '');

  Future<void> _runAction(
    Emitter<ContractDetailsState> emit,
    Future<Either<String, dynamic>> Function() action,
    String successMessage, {
    bool popOnSuccess = false,
  }) async {
    if (_contractId.isEmpty || state.actionStatus == RequestStatus.loading) {
      return;
    }
    emit(
      state.copyWith(actionStatus: RequestStatus.loading, actionMessage: ''),
    );
    final result = await action();
    result.fold(
      (err) => emit(
        state.copyWith(actionStatus: RequestStatus.failed, actionMessage: err),
      ),
      (_) => emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          actionMessage: successMessage,
          shouldPop: popOnSuccess,
        ),
      ),
    );
  }
}
