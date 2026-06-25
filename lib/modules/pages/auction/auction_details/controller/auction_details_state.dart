part of 'auction_details_bloc.dart';

class AuctionDetailsState extends Equatable {
  const AuctionDetailsState({
    this.auction,
    this.loadStatus = RequestStatus.init,
    this.bidStatus = RequestStatus.init,
    this.errorMsg = '',
  });

  final AuctionDetailsModel? auction;
  final RequestStatus loadStatus;
  final RequestStatus bidStatus;
  final String errorMsg;

  @override
  List<Object?> get props => [auction, loadStatus, bidStatus, errorMsg];

  AuctionDetailsState copyWith({
    AuctionDetailsModel? auction,
    RequestStatus? loadStatus,
    RequestStatus? bidStatus,
    String? errorMsg,
  }) {
    return AuctionDetailsState(
      auction: auction ?? this.auction,
      loadStatus: loadStatus ?? this.loadStatus,
      bidStatus: bidStatus ?? this.bidStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
