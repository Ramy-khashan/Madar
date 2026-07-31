part of 'net_profit_loss_bloc.dart';

class NetProfitLossState extends Equatable {
  const NetProfitLossState({
    this.netProfit = 0,
    this.annualProfit = 0,
    this.totalExpenses = 0,
    this.previousPeriodProfit = 0,
    this.status = RequestStatus.init,
    this.exportStatus = RequestStatus.init,
    this.downloadStatus = RequestStatus.init,
    this.errorMessage=''
  });

  final double netProfit;
  final double annualProfit;
  final double totalExpenses;
  final double previousPeriodProfit;
  final RequestStatus status;
  final RequestStatus exportStatus;
  final RequestStatus downloadStatus;
  final String errorMessage;
 

  NetProfitLossState copyWith({
    double? netProfit,
    double? annualProfit,
    double? totalExpenses,
    double? previousPeriodProfit,
    RequestStatus? status,
     RequestStatus? exportStatus,
    RequestStatus? downloadStatus,
    String? errorMessage,
  }) =>
      NetProfitLossState(
        netProfit: netProfit ?? this.netProfit,
        annualProfit: annualProfit ?? this.annualProfit,
        totalExpenses: totalExpenses ?? this.totalExpenses,
        previousPeriodProfit:
            previousPeriodProfit ?? this.previousPeriodProfit,
        status: status ?? this.status,
        exportStatus: exportStatus ?? this.exportStatus,
        downloadStatus: downloadStatus ?? this.downloadStatus,
        errorMessage: errorMessage ?? this.errorMessage,
      );
  @override
  List<Object?> get props => [
        netProfit,
        annualProfit,
        totalExpenses,
        previousPeriodProfit,
        status,
        exportStatus,
        downloadStatus,
        errorMessage,
      ];
}
