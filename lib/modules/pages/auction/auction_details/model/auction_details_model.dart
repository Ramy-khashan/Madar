import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../auction_list/model/auction_item_model.dart';

class AuctionDetailsModel extends Equatable {
  const AuctionDetailsModel({
    required this.id,
    required this.title,
    required this.location,
    required this.currentBid,
    required this.minBidIncrement,
    required this.imageUrls,
    required this.endTime,
    required this.bidsCount,
    required this.propertyType,
    required this.beds,
    required this.baths,
    required this.area,
    required this.floor,
    required this.balconies,
    required this.propertyNumber,
    required this.description,
    required this.status,
    required this.hasDepositPaid,
    required this.startingBid,
    required this.tag,
    required this.startTime,
    required this.sellerName,
    this.sellerRating = 4.8,
    this.sellerReviewCount = 24,
    this.depositAmount = 30000,
  });

  final String id;
  final String title;
  final String location;
  final double currentBid;
  final double minBidIncrement;
  final List<String> imageUrls;
  final DateTime endTime;
  final DateTime startTime;
  final int bidsCount;
  final String propertyType;
  final int beds;
  final int baths;
  final String area;
  final int floor;
  final int balconies;
  final String propertyNumber;
  final String description;
  final AuctionStatus status;
  final bool hasDepositPaid;
  final double startingBid;
  final String tag;
  final String sellerName;
  final double sellerRating;
  final int sellerReviewCount;
  final double depositAmount;

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        currentBid,
        minBidIncrement,
        imageUrls,
        endTime,
        bidsCount,
        propertyType,
        beds,
        baths,
        area,
        floor,
        balconies,
        propertyNumber,
        description,
        status,
        hasDepositPaid,
        startingBid,
        tag,
      ];

  AuctionDetailsModel copyWith({
    String? id,
    String? title,
    String? location,
    double? currentBid,
    double? minBidIncrement,
    List<String>? imageUrls,
    DateTime? endTime,
    int? bidsCount,
    String? propertyType,
    int? beds,
    int? baths,
    String? area,
    int? floor,
    int? balconies,
    String? propertyNumber,
    String? description,
    AuctionStatus? status,
    bool? hasDepositPaid,
    double? startingBid,
    String? tag,
    DateTime? startTime,
    String? sellerName,
    double? sellerRating,
    int? sellerReviewCount,
    double? depositAmount,
  }) {
    return AuctionDetailsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      currentBid: currentBid ?? this.currentBid,
      minBidIncrement: minBidIncrement ?? this.minBidIncrement,
      imageUrls: imageUrls ?? this.imageUrls,
      endTime: endTime ?? this.endTime,
      startTime: startTime ?? this.startTime,
      bidsCount: bidsCount ?? this.bidsCount,
      propertyType: propertyType ?? this.propertyType,
      beds: beds ?? this.beds,
      baths: baths ?? this.baths,
      area: area ?? this.area,
      floor: floor ?? this.floor,
      balconies: balconies ?? this.balconies,
      propertyNumber: propertyNumber ?? this.propertyNumber,
      description: description ?? this.description,
      status: status ?? this.status,
      hasDepositPaid: hasDepositPaid ?? this.hasDepositPaid,
      startingBid: startingBid ?? this.startingBid,
      tag: tag ?? this.tag,
      sellerName: sellerName ?? this.sellerName,
      sellerRating: sellerRating ?? this.sellerRating,
      sellerReviewCount: sellerReviewCount ?? this.sellerReviewCount,
      depositAmount: depositAmount ?? this.depositAmount,
    );
  }
    static String label(AuctionStatus status) => switch (status) {
       AuctionStatus.live => AppStrings.auctionStatusOpen,
      AuctionStatus.upcoming => AppStrings.auctionStatusUpcoming,
      AuctionStatus.ended => AppStrings.auctionStatusEnded,
    };
    static Color color(BuildContext context, AuctionStatus status) => switch (status) {
      AuctionStatus.live => AppThemeColors.of(context).primaryBrand,
      AuctionStatus.upcoming => AppThemeColors.of(context).primaryBrand,
      AuctionStatus.ended => AppColors.errorColor,
    };
}
