part of 'net_profit_loss_bloc.dart';

class NetProfitLossState extends Equatable {
  const NetProfitLossState({
    this.netProfit = 200000,
    this.annualProfit = 250000,
    this.totalExpenses = 50000,
    this.previousPeriodProfit = 180000,
    this.status = RequestStatus.init,
    this.exportStatus = RequestStatus.init,
  });

  final double netProfit;
  final double annualProfit;
  final double totalExpenses;
  final double previousPeriodProfit;
  final RequestStatus status;
  final RequestStatus exportStatus;

  double get profitChange => netProfit - previousPeriodProfit;

  double get profitChangePercent =>
      previousPeriodProfit == 0
          ? 0
          : (profitChange / previousPeriodProfit) * 100;

  bool get isProfitable => netProfit >= 0;

  NetProfitLossState copyWith({
    double? netProfit,
    double? annualProfit,
    double? totalExpenses,
    double? previousPeriodProfit,
    RequestStatus? status,
    RequestStatus? exportStatus,
  }) =>
      NetProfitLossState(
        netProfit: netProfit ?? this.netProfit,
        annualProfit: annualProfit ?? this.annualProfit,
        totalExpenses: totalExpenses ?? this.totalExpenses,
        previousPeriodProfit:
            previousPeriodProfit ?? this.previousPeriodProfit,
        status: status ?? this.status,
        exportStatus: exportStatus ?? this.exportStatus,
      );

  @override
  List<Object?> get props => [
        netProfit,
        annualProfit,
        totalExpenses,
        previousPeriodProfit,
        status,
        exportStatus,
      ];
}
