import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_strings.dart';

class MyBidItemModel extends Equatable {
  const MyBidItemModel({
    required this.id,
    required this.title,
    required this.location,
    required this.startingBid,
    required this.imageUrl,
    required this.endTime,
    required this.rooms,
    required this.bathrooms,
    required this.area,
    required this.tag,
    required this.status,
  });

  final String id;
  final String title;
  final String location;
  final double startingBid;
  final String imageUrl;
  final DateTime endTime;
  final int rooms;
  final int bathrooms;
  final double area;
  final String tag;
  final String status;

  @override
  List<Object?> get props => [
    id,
    title,
    location,
    startingBid,
    imageUrl,
    endTime,
    rooms,
    bathrooms,
    area,
    tag,
    status,
  ];
  static Color getBadgeColor(String status, AppThemeColors colors) {
    switch (status) {
      case 'ongoing':
        return colors.primaryBrand;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static String getBadgeLabel(String status) {
    switch (status) {
      case 'ongoing':
        return AppStrings.ongoingTab;
      case 'completed':
        return AppStrings.completedTab;
      case 'cancelled':
        return AppStrings.cancelledTab;
      default:
        return status;
    }
  }

  static Color getBadgeTextColor(String status, AppThemeColors colors) {
    switch (status) {
      case 'ongoing':
        return colors.primaryBrand;
      case 'completed':
        return AppColors.successColor;
      case 'cancelled':
        return AppColors.errorColor;
      default:
        return AppColors.grey900;
    }
  }

  static String getButtonText(String status) {
    switch (status) {
      case 'ongoing':
        return AppStrings.enterAuction;
      case 'completed':
        return AppStrings.electronicReceipt;
      case 'cancelled':
        return AppStrings.reBooking;
      default:
        return AppStrings.enterAuction;
    }
  }
}
