part of 'net_profit_loss_bloc.dart';

sealed class NetProfitLossEvent extends Equatable {
  const NetProfitLossEvent();

  @override
  List<Object?> get props => [];
}

final class NetProfitLossLoad extends NetProfitLossEvent {
  const NetProfitLossLoad();
}

final class NetProfitLossExportPdf extends NetProfitLossEvent {
  const NetProfitLossExportPdf();
}

final class NetProfitLossExportExcel extends NetProfitLossEvent {
  const NetProfitLossExportExcel();
}
