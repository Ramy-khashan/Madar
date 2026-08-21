import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/apis/dashboard_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../model/profit_loss_model.dart';

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
    AppToast(AppStrings.notAvailable);
  }

  Future<void> _onExportExcel(
    NetProfitLossExportExcel event,
    Emitter<NetProfitLossState> emit,
  ) async {
    AppToast(AppStrings.notAvailable);
  }

  Future<void> _onLoadProfitLoss(
    NetProfitLossLoad event,
    Emitter<NetProfitLossState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, errorMessage: ''));
    final result = await DashboardApis.profitLoss();
    result.fold(
      (failure) => emit(
        state.copyWith(status: RequestStatus.failed, errorMessage: failure),
      ),
      (payload) {
        final report = ProfitLossModel.fromJson(payload);
        emit(
          state.copyWith(
            status: RequestStatus.success,
            errorMessage: '',
            totalIncome: report.totalIncome,
            totalExpenses: report.totalExpenses,
            netProfit: report.netProfit,
            incomeComparison: report.incomeComparison,
            expensesComparison: report.expensesComparison,
            netProfitComparison: report.netProfitComparison,
            insights: report.insights,
          ),
        );
      },
    );
  }
}
