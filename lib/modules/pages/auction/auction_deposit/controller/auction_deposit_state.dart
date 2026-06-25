part of 'auction_deposit_bloc.dart';

class AuctionDepositState extends Equatable {
  const AuctionDepositState({
    this.depositAmount = 30000,
    this.propertyTitle = '',
    this.selectedPaymentMethod,
    this.transactionId = '',
    this.step = AuctionDepositStep.paymentSelection,
    this.loadStatus = RequestStatus.init,
    this.confirmStatus = RequestStatus.init,
    this.errorMsg = '',
  });

  final double depositAmount;
  final String propertyTitle;
  final AuctionDepositPaymentMethod? selectedPaymentMethod;
  final String transactionId;
  final AuctionDepositStep step;
  final RequestStatus loadStatus;
  final RequestStatus confirmStatus;
  final String errorMsg;

  @override
  List<Object?> get props => [
        depositAmount,
        propertyTitle,
        selectedPaymentMethod,
        transactionId,
        step,
        loadStatus,
        confirmStatus,
        errorMsg,
      ];

  AuctionDepositState copyWith({
    double? depositAmount,
    String? propertyTitle,
    AuctionDepositPaymentMethod? selectedPaymentMethod,
    String? transactionId,
    AuctionDepositStep? step,
    RequestStatus? loadStatus,
    RequestStatus? confirmStatus,
    String? errorMsg,
  }) {
    return AuctionDepositState(
      depositAmount: depositAmount ?? this.depositAmount,
      propertyTitle: propertyTitle ?? this.propertyTitle,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      transactionId: transactionId ?? this.transactionId,
      step: step ?? this.step,
      loadStatus: loadStatus ?? this.loadStatus,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
