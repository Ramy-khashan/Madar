import 'package:equatable/equatable.dart';

enum BidResultStatus { waiting, won, outbid }

class AuctionBidResultModel extends Equatable {
  const AuctionBidResultModel({
    required this.auctionId,
    required this.propertyTitle,
    required this.propertyLocation,
    required this.bidAmount,
    required this.status,
    this.countdownSeconds = 5,
  });

  final String auctionId;
  final String propertyTitle;
  final String propertyLocation;
  final double bidAmount;
  final BidResultStatus status;
  final int countdownSeconds;

  @override
  List<Object?> get props => [
        auctionId,
        propertyTitle,
        propertyLocation,
        bidAmount,
        status,
        countdownSeconds,
      ];

  AuctionBidResultModel copyWith({
    String? auctionId,
    String? propertyTitle,
    String? propertyLocation,
    double? bidAmount,
    BidResultStatus? status,
    int? countdownSeconds,
  }) {
    return AuctionBidResultModel(
      auctionId: auctionId ?? this.auctionId,
      propertyTitle: propertyTitle ?? this.propertyTitle,
      propertyLocation: propertyLocation ?? this.propertyLocation,
      bidAmount: bidAmount ?? this.bidAmount,
      status: status ?? this.status,
      countdownSeconds: countdownSeconds ?? this.countdownSeconds,
    );
  }
}
