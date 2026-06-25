part of 'auction_deposit_bloc.dart';

abstract class AuctionDepositEvent extends Equatable {
  const AuctionDepositEvent();
  @override
  List<Object?> get props => [];
}

class AuctionDepositLoad extends AuctionDepositEvent {
  final String auctionId;
  const AuctionDepositLoad(this.auctionId);
  @override
  List<Object?> get props => [auctionId];
}

class AuctionDepositMethodSelected extends AuctionDepositEvent {
  final AuctionDepositPaymentMethod method;
  const AuctionDepositMethodSelected(this.method);
  @override
  List<Object?> get props => [method];
}

class AuctionDepositConfirmPayment extends AuctionDepositEvent {
  const AuctionDepositConfirmPayment();
}
