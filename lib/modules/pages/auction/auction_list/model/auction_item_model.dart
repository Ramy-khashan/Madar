import 'package:equatable/equatable.dart';

enum AuctionStatus { live, upcoming, ended }

enum AuctionFilterTab { all, live, upcoming, ended }

class AuctionItemModel extends Equatable {
  const AuctionItemModel({
    required this.id,
    required this.title,
    required this.location,
    required this.currentBid,
    required this.startingBid,
    required this.imageUrl,
    required this.endTime,
    required this.bidsCount,
    required this.tag,
    required this.status,
  });

  final String id;
  final String title;
  final String location;
  final double currentBid;
  final double startingBid;
  final String imageUrl;
  final DateTime endTime;
  final int bidsCount;
  final String tag;
  final AuctionStatus status;

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        currentBid,
        startingBid,
        imageUrl,
        endTime,
        bidsCount,
        tag,
        status,
      ];
}
