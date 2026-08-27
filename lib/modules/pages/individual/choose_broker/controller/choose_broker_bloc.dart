import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madar_app/core/utils/functions/common_fun.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../core/utils/functions/preference_utils.dart';
import '../../../../../core/utils/functions/print_state.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../model/broker_model.dart';

part 'choose_broker_event.dart';
part 'choose_broker_state.dart';

class ChooseBrokerBloc extends Bloc<ChooseBrokerEvent, ChooseBrokerState> {
  ChooseBrokerBloc() : super(const ChooseBrokerState()) {
    on<ChooseBrokerLoad>(_onLoad);
    on<GetPropertyIdEvent>((event, emit) {
      printState('GetPropertyIdEvent: ${event.propertyId}');
      emit(state.copyWith(propertyId: event.propertyId));
    });
    on<ChooseBrokerSearch>(_onSearch);
    on<ChooseBrokerSelect>(_onSelect);
    on<ChooseBrokerConfirm>(_onConfirm);
    on<ChooseBrokerBack>(_onBack);
    on<ChooseBrokerCommissionChanged>(_onCommissionChanged);
    on<ChooseBrokerPayerChanged>(_onPayerChanged);
  }

  static ChooseBrokerBloc get(BuildContext context) =>
      BlocProvider.of<ChooseBrokerBloc>(context);

  int pageSize = 10;

  Future<void> _onLoad(
    ChooseBrokerLoad event,
    Emitter<ChooseBrokerState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          loadStatus: RequestStatus.loading,
          isLoadMore: event.isLoadMore,
        ),
      );

      final response = await sl.get<ApiConsumer>().get(
        EndPoints.brokers,
        queryParameters: {'page': event.page, 'limit': pageSize},
      );

      await response.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              loadStatus: RequestStatus.failed,
              errorMsg: failedResponse,
              isLoadMore: false,
            ),
          );
        },
        (successResponse) async {
       
          final List<BrokerModel> items = [];
          for (var item in List.from(successResponse.response['data']  ?? [])) {
            items.add(BrokerModel.fromJson(item));
          }
          final pagination =
              successResponse.response['pagination'] as Map<String, dynamic>? ?? {};
          final total = pagination['total'] ?? 0;

          emit(
            state.copyWith(
              loadStatus: RequestStatus.success,
              brokers: items,
              totalCount: total,
              isLoadMore: false,
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
          isLoadMore: false,
        ),
      );
    }
  }

  void _onSearch(ChooseBrokerSearch event, Emitter<ChooseBrokerState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onSelect(ChooseBrokerSelect event, Emitter<ChooseBrokerState> emit) {
    emit(
      state.copyWith(
        selectedBrokerId: event.brokerId,
        step: ChooseBrokerStep.details,
      ),
    );
  }

  Future<void> _onConfirm(
    ChooseBrokerConfirm event,
    Emitter<ChooseBrokerState> emit,
  ) async {
    try {
      if (state.propertyId.isEmpty) {
        AppToast(AppStrings.pleaseSelectPropertyToSend);
        return;
      }
      if (state.selectedBrokerId == null || state.selectedBrokerId!.isEmpty) {
        AppToast(AppStrings.pleaseSelectPropertyToSend);
        return;
      }
      emit(state.copyWith(confirmStatus: RequestStatus.loading));
      final isIndividual =
          PreferenceUtils().getString(StorageKeys.accountType) ==
          AppConstant.individual;
      final body = <String, dynamic>{
        'brokerId': state.selectedBrokerId,
        if (isIndividual) ...{
          'commissionRate': state.commissionRate,
          'commissionPayer': state.commissionPayer,
        },
      };
      final response = await sl.get<ApiConsumer>().post(
        EndPoints.sendToBrokers + state.propertyId,
        body: body,
      );
      response.fold(
        (failedResponse) {
          AppToast(failedResponse);
          emit(state.copyWith(confirmStatus: RequestStatus.failed));
        },
        (successResponse) {
          AppToast(AppStrings.brokerRequestSentSuccessfully);
          emit(state.copyWith(confirmStatus: RequestStatus.success));
        },
      );
    } catch (e) {
      AppToast(AppStrings.somethingWentWrong);
      emit(state.copyWith(confirmStatus: RequestStatus.failed));
    }
  }

  void _onCommissionChanged(
    ChooseBrokerCommissionChanged event,
    Emitter<ChooseBrokerState> emit,
  ) {
    emit(state.copyWith(commissionRate: event.rate));
  }

  void _onPayerChanged(
    ChooseBrokerPayerChanged event,
    Emitter<ChooseBrokerState> emit,
  ) {
    emit(state.copyWith(commissionPayer: event.payer));
  }

  void _onBack(ChooseBrokerBack event, Emitter<ChooseBrokerState> emit) {
    emit(
      state.copyWith(step: ChooseBrokerStep.list, clearSelectedBrokerId: true),
    );
  }

  static List<String> responsibilities = [
    AppStrings.respReviewDocs,
    AppStrings.respPhotography,
    AppStrings.respPublish,
    AppStrings.respManageContacts,
    AppStrings.respOrganizeInspections,
    AppStrings.respCompleteProcedures,
  ];
}
