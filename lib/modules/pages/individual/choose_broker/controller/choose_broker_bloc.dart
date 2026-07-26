 import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/print_state.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../model/broker_model.dart';

part 'choose_broker_event.dart';
part 'choose_broker_state.dart';

class ChooseBrokerBloc extends Bloc<ChooseBrokerEvent, ChooseBrokerState> {
  ChooseBrokerBloc() : super(const ChooseBrokerState()) {
    on<ChooseBrokerLoad>(_onLoad);
    on<ChooseBrokerSearch>(_onSearch);
    on<ChooseBrokerSelect>(_onSelect);
    on<ChooseBrokerConfirm>(_onConfirm);
    on<ChooseBrokerBack>(_onBack);
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
          final dataWrapper =
              successResponse.response['data'] as Map<String, dynamic>? ?? {};
          final List<BrokerModel> items = [];
          for (var item in List.from(dataWrapper['data'] ?? [])) {
            items.add(BrokerModel.fromJson(item));
          }
          final pagination =
              dataWrapper['pagination'] as Map<String, dynamic>? ?? {};
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
    emit(state.copyWith(
      selectedBrokerId: event.brokerId,
      step: ChooseBrokerStep.details,
    ));
  }

  Future<void> _onConfirm(
    ChooseBrokerConfirm event,
    Emitter<ChooseBrokerState> emit,
  ) async {
    emit(state.copyWith(confirmStatus: RequestStatus.loading));
    emit(state.copyWith(confirmStatus: RequestStatus.success));
  }

  void _onBack(ChooseBrokerBack event, Emitter<ChooseBrokerState> emit) {
    emit(state.copyWith(
      step: ChooseBrokerStep.list,
      clearSelectedBrokerId: true,
    ));
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
