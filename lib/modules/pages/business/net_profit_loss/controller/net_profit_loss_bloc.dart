import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';

part 'net_profit_loss_event.dart';
part 'net_profit_loss_state.dart';

class NetProfitLossBloc
    extends Bloc<NetProfitLossEvent, NetProfitLossState> {
  NetProfitLossBloc() : super(const NetProfitLossState()) {
    on<NetProfitLossLoad>(_onLoad);
    on<NetProfitLossExportPdf>(_onExportPdf);
    on<NetProfitLossExportExcel>(_onExportExcel);
  }

  static NetProfitLossBloc get(BuildContext context) =>
      context.read<NetProfitLossBloc>();

  void _onLoad(
    NetProfitLossLoad event,
    Emitter<NetProfitLossState> emit,
  ) {
    emit(state.copyWith(status: RequestStatus.loading));
     emit(state.copyWith(status: RequestStatus.success));
  }

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
}
