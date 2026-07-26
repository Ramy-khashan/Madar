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

  factory AuctionItemModel.fromJson(Map<String, dynamic> json) {
    final property = json['property'] as Map<String, dynamic>? ?? {};
    final price = (json['startingPrice'] ?? 0).toDouble();
    return AuctionItemModel(
      id: json['id'] ?? '',
      title: property['title'] ?? '',
      location: property['description'] ?? '',
      currentBid: price,
      startingBid: price,
      imageUrl: '',
      endTime: json['endAt'] != null
          ? DateTime.parse(json['endAt'])
          : DateTime.now(),
      bidsCount: 0,
      tag: property['type'] ?? '',
      status: _parseStatus(json['status']),
    );
  }

  static AuctionStatus _parseStatus(String? status) {
    switch (status?.toUpperCase()) {
      case 'ACTIVE':
      case 'LIVE':
        return AuctionStatus.live;
      case 'UPCOMING':
        return AuctionStatus.upcoming;
      case 'CLOSED':
      case 'CANCELLED':
      default:
        return AuctionStatus.ended;
    }
  }
}
