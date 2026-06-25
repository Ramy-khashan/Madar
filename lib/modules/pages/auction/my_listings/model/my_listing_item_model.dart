import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/constants/app_strings.dart';

class MyListingItemModel extends Equatable {
  const MyListingItemModel({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.rooms,
    required this.bathrooms,
    required this.area,
    required this.tag,
    required this.status,
    this.startingBid = 0,
    this.endTime,
    // Completed fields
    this.finalPrice,
    this.winnerName,
    this.deliveryStatus,
    this.receiptFileName,
    // Cancelled fields
    this.cancellationReason,
    this.cancelledAt,
  });

  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final int rooms;
  final int bathrooms;
  final double area;
  final String tag;
  final String status;
  final double startingBid;
  final DateTime? endTime;
  // Completed
  final double? finalPrice;
  final String? winnerName;
  final String? deliveryStatus;
  final String? receiptFileName;
  // Cancelled
  final String? cancellationReason;
  final DateTime? cancelledAt;

  @override
  List<Object?> get props => [
    id,
    title,
    location,
    imageUrl,
    rooms,
    bathrooms,
    area,
    tag,
    status,
    startingBid,
    endTime,
    finalPrice,
    winnerName,
    deliveryStatus,
    receiptFileName,
    cancellationReason,
    cancelledAt,
  ];
  static Map<String, Object> getColorAndLabel({
    required AppThemeColors colors,
    required String status,
  }) {
    Color bgColor;
    Color textColor;
    String label;
    switch (status) {
      case 'active':
        bgColor = Colors.red.withValues(alpha: 0.1);
        textColor = Colors.red;
        label = AppStrings.liveBadge;
        break;
      case 'completed':
        bgColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green;
        label = AppStrings.paidBadge;
        break;
      case 'cancelled':
        bgColor = colors.textFieldBorder.withValues(alpha: 0.3);
        textColor = colors.textSecondary;
        label = AppStrings.cancelledTab;
        break;
      default:
        bgColor = colors.textFieldBorder.withValues(alpha: 0.3);
        textColor = colors.textSecondary;
        label = status;
    }
    return {'bgColor': bgColor, 'textColor': textColor, 'label': label};
  }

  static String getCountDownString(DateTime? endTime) {
    if (endTime == null) return '';
    final diff = endTime.difference(DateTime.now());
    final h = diff.inHours;
    final m = diff.inMinutes.remainder(60);
    final s = diff.inSeconds.remainder(60);
    final display = diff.isNegative ? '--' : '${h}h ${m}m ${s}s';
    return display;
  }
}
