import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/functions/service_locator.dart';

part 'net_profit_loss_event.dart';
part 'net_profit_loss_state.dart';

class NetProfitLossBloc extends Bloc<NetProfitLossEvent, NetProfitLossState> {
  NetProfitLossBloc() : super(const NetProfitLossState()) {
    on<NetProfitLossLoad>(_onLoadProfitLoss);
    on<NetProfitLossExportPdf>(_onExportPdf);
    on<NetProfitLossExportExcel>(_onExportExcel);
  }

  static NetProfitLossBloc get(BuildContext context) =>
      context.read<NetProfitLossBloc>();

 

  Future<void> _onExportPdf(
    NetProfitLossExportPdf event,
    Emitter<NetProfitLossState> emit,
  ) async {
    emit(state.copyWith(exportStatus: RequestStatus.loading));
    emit(state.copyWith(exportStatus: RequestStatus.success));
  }

  Future<void> _onExportExcel(
    NetProfitLossExportExcel event,
    Emitter<NetProfitLossState> emit,
  ) async {
    emit(state.copyWith(exportStatus: RequestStatus.loading));
    emit(state.copyWith(exportStatus: RequestStatus.success));
  }

  Future<void> _onLoadProfitLoss(
    NetProfitLossLoad event,
    Emitter<NetProfitLossState> emit,
  ) async {
    try {
      emit(state.copyWith(exportStatus: RequestStatus.loading));
      final response=await sl.get<ApiConsumer>().get(
        EndPoints.netProfitLoss,
       );
      await response.fold(
        (failure) async {
          emit(
            state.copyWith(exportStatus: RequestStatus.failed, errorMessage: failure),
          );
        },
        (data) async {
          emit(state.copyWith(exportStatus: RequestStatus.success));
        },
      );
    } catch (e) {
      emit(state.copyWith(exportStatus: RequestStatus.failed));
    }
  }
}
